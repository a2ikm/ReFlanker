//
//  RFWindowController.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFAppDelegate.h"
#import "RFWindowController.h"
#import "NSArray+Ring.h"
#import "NSImage+PixelSize.h"

@interface RFWindowController (PRIVATE)
- (void)updateWindowAndImageView;
- (void)loadCurrentImage;
- (void)reloadFileNames;
- (BOOL)isAllowedFile:(NSString *)fileName;

- (void)resizeToScale:(CGFloat)scale;

- (void)playMoveToTrashSound;
- (void)playUndoSound;
- (void)playSound:(NSString *)soundFile;
@end

@implementation RFWindowController

- (id)initWithInitialFileURL:(NSURL *)fileURL
{
    if (self = [super initWithWindowNibName:@"DocumentWindow"]) {
        directoryURL = [fileURL URLByDeletingLastPathComponent];
        currentFileName = [fileURL lastPathComponent];
        
        fileNames = [[NSMutableArray alloc] init];
        [self reloadFileNames];
        
        undoManager = [[NSUndoManager alloc] init];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [[self imageView] setImageScaling:NSScaleToFit];
    [self updateWindowAndImageView];
}

- (IBAction)duplicate:(id)sender
{
    [APP_DELEGATE openNewWindowWithInitialFileURL:[self currentImageURL]];
}

- (IBAction)next:(id)sender
{
    currentFileName = [fileNames nextObjectOf:currentFileName];
    [self updateWindowAndImageView];
}

- (IBAction)previous:(id)sender
{
    currentFileName = [fileNames previousObjectOf:currentFileName];
    [self updateWindowAndImageView];
}

- (IBAction)move:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldLabel:@"Move to:"];
    [savePanel setNameFieldStringValue:currentFileName];
    if ([savePanel runModal] == NSFileHandlingPanelCancelButton) return;
    
    NSURL *movedURL = [savePanel URL];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL result = [fileManager moveItemAtURL:[self currentImageURL] toURL:movedURL error:NULL];
    if (result) {
        [self playUndoSound];
        
        NSDictionary *dict = @{ @"movedURL":movedURL, @"originalURL":[self currentImageURL] };
        [undoManager registerUndoWithTarget:self selector:@selector(undoFileMove:) object:dict];
        
        [self next:nil];
        [self reloadFileNames];
    }
}

- (IBAction)moveToTrash:(id)sender
{
    NSURL *movedURL = nil;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL result = [fileManager trashItemAtURL:[self currentImageURL] resultingItemURL:&movedURL error:NULL];
    if (result) {
        [self playMoveToTrashSound];
        
        NSDictionary *dict = @{ @"movedURL":movedURL, @"originalURL":[self currentImageURL] };
        [undoManager registerUndoWithTarget:self selector:@selector(undoFileMove:) object:dict];
        
        [self next:nil];
        [self reloadFileNames];
    }
}

- (void)undoFileMove:(id)dict
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL result = [fileManager moveItemAtURL:[(NSDictionary* )dict objectForKey:@"movedURL"]
                                       toURL:[(NSDictionary* )dict objectForKey:@"originalURL"]
                                       error:NULL];
    if (result) {
        [self playUndoSound];
        [self reloadFileNames];
    } else {
        NSBeep();
    }
}

- (IBAction)copy:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldLabel:@"Copy to:"];
    [savePanel setNameFieldStringValue:currentFileName];
    if ([savePanel runModal] == NSFileHandlingPanelCancelButton) return;
    
    NSURL *copiedURL = [savePanel URL];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL result = [fileManager copyItemAtURL:[self currentImageURL] toURL:copiedURL error:NULL];
    if (result) {
        [self playUndoSound];
        [self reloadFileNames];
    }
}

- (IBAction)showInFinder:(id)sender
{
    NSArray *fileURLs = @[[self currentImageURL]];
    [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:fileURLs];
}

- (IBAction)showTitleViaNotificationCenter:(id)sender
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = currentFileName;
    notification.informativeText = [NSString stringWithFormat:@"Stored in %@", [directoryURL path]];
    notification.hasActionButton = NO;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

- (IBAction)minimize:(id)sender
{
    [[self window] miniaturize:sender];
}

- (IBAction)resizeToFit:(id)sender
{
    NSSize pixelSize = [[[self imageView] image] pixelSize];
    
    CGFloat w = pixelSize.width;
    CGFloat h = pixelSize.height;
    NSSize maxSize = self.window.screen.visibleFrame.size;
    if (w > maxSize.width)  { h = h * maxSize.width / w;  w = maxSize.width; }
    if (h > maxSize.height) { w = w * maxSize.height / h; h = maxSize.height; }
    
    CGFloat x = self.window.frame.origin.x;
    CGFloat y = self.window.frame.origin.y;
    [[self window] setFrame:NSMakeRect(x, y, w, h) display:YES];
}

- (IBAction)resizeToActualSize:(id)sender
{
    [self resizeToScale:1.0];
}

- (IBAction)resizeToHalfSize:(id)sender
{
    [self resizeToScale:0.5];
}

- (IBAction)resizeToThirdSize:(id)sender
{
    [self resizeToScale:0.33];
}

- (IBAction)resizeToQuarterSize:(id)sender
{
    [self resizeToScale:0.25];
}

- (NSURL *)currentImageURL
{
    return [directoryURL URLByAppendingPathComponent:currentFileName];
}

#pragma mark --- PRIVATE ---

- (void)updateWindowAndImageView
{
    NSString *title = [[directoryURL lastPathComponent] stringByAppendingPathComponent:currentFileName];
    [[self window] setTitle:title];
    
    [self loadCurrentImage];
}

- (void)loadCurrentImage
{
    NSImage *image = [[NSImage alloc] initByReferencingURL: [self currentImageURL]];
    [[self imageView] setImage:image];
    
    NSSize pixelSize = [image pixelSize];
    [[self window] setAspectRatio:pixelSize];
    
    [self resizeToFit:nil];
}

- (void)reloadFileNames
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *fileURLs = [fileManager contentsOfDirectoryAtURL:directoryURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:NULL];
    
    [fileNames removeAllObjects];
    for (NSURL *fileURL in fileURLs) {
        NSString *fileName = [fileURL lastPathComponent];
        if ([self isAllowedFile:fileName]) [fileNames addObject:fileName];
    }
}
             
- (BOOL)isAllowedFile:(NSString *)fileName
{
    for (NSString *fileType in ALLOWED_FILE_TYPES) {
        if ([[fileName lowercaseString] hasSuffix:[fileType lowercaseString]]) {
            return YES;
        }
    }
    return NO;
}

- (void)resizeToScale:(CGFloat)scale
{
    NSSize size = [[[self imageView] image] pixelSize];
    CGFloat w = size.width  * scale;
    CGFloat h = size.height * scale;
    CGFloat x = self.window.frame.origin.x;
    CGFloat y = self.window.frame.origin.y;
    [[self window] setFrame:NSMakeRect(x, y, w, h) display:YES];
}

- (void)playMoveToTrashSound
{
    [self playSound:@"/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/dock/drag to trash.aif"];
}

- (void)playUndoSound
{
    [self playSound:@"/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/system/Volume Mount.aif"];
}

- (void)playSound:(NSString *)soundFile
{
    NSSound *systemSound = [[NSSound alloc] initWithContentsOfFile:soundFile byReference:YES];
    if (systemSound) {
        [systemSound play];
    }
}

#pragma mark --- NSWindowDelegate --

- (void)windowDidBecomeKey:(NSNotification *)notification
{
    [self reloadFileNames];
}

- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)aWindow
{
    return undoManager;
}
@end
