//
//  RFWindowController.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFWindowController.h"

@interface RFWindowController (PRIVATE)
- (void)loadCurrentImage;
- (void)setImage:(NSImage *)image;
- (void)reloadFileNames;
- (void)playMoveToTrashSound;
@end

@implementation RFWindowController

- (id)initWithWindowNibName:(NSString *)windowNibName initialFileURL:(NSURL *)fileURL
{
    if (self = [super initWithWindowNibName:windowNibName]) {
        directoryURL = [fileURL URLByDeletingLastPathComponent];
        currentFileName = [fileURL lastPathComponent];
        
        fileNames = [[NSMutableArray alloc] init];
        [self reloadFileNames];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    maxSize = self.window.screen.visibleFrame.size;
    
    [[self imageView] setImageScaling:NSScaleToFit];
    [self loadCurrentImage];
}

- (IBAction)next:(id)sender
{
    NSInteger i = [fileNames indexOfObject:currentFileName] + 1;
    if (i >= [fileNames count]) i = 0;
    currentFileName = [fileNames objectAtIndex:i];
    [self loadCurrentImage];
}

- (IBAction)previous:(id)sender
{
    NSInteger i = [fileNames indexOfObject:currentFileName] - 1;
    if (i < 0) i = [fileNames count] - 1;
    currentFileName = [fileNames objectAtIndex:i];
    [self loadCurrentImage];
}

- (IBAction)moveToTrash:(id)sender
{
    NSURL *movedURL = nil;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL result = [fileManager trashItemAtURL:[self currentImageURL] resultingItemURL:&movedURL error:NULL];
    if (result) {
        [self playMoveToTrashSound];
        [self next:nil];
        [self reloadFileNames];
    }
}

- (NSURL *)currentImageURL
{
    return [directoryURL URLByAppendingPathComponent:currentFileName];
}

- (void)loadCurrentImage
{
    NSImage *image = [[NSImage alloc] initByReferencingURL: [self currentImageURL]];
    [self setImage:image];
}

- (void)setImage:(NSImage *)image
{
    [[self imageView] setImage:image];
    [[self window] setAspectRatio:[image size]];
    
    CGFloat x = self.window.frame.origin.x;
    CGFloat y = self.window.frame.origin.y;
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    if (w > maxSize.width)  { h = h * maxSize.width / w;  w = maxSize.width; }
    if (h > maxSize.height) { w = w * maxSize.height / h; h = maxSize.height; }
    [[self window] setFrame:NSMakeRect(x, y, w, h) display:YES];
}

- (void)reloadFileNames
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *fileURLs = [fileManager contentsOfDirectoryAtURL:directoryURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:NULL];
    
    [fileNames removeAllObjects];
    for (NSInteger i = 0; i < [fileURLs count]; i++) {
        [fileNames addObject:[[fileURLs objectAtIndex:i] lastPathComponent]];
    }
}

- (void)playMoveToTrashSound
{
    NSSound *systemSound = [[NSSound alloc] initWithContentsOfFile:@"/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/dock/drag to trash.aif" byReference:YES];
    if (systemSound) {
        [systemSound play];
    }
}
@end
