//
//  RFAppDelegate.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFAppDelegate.h"
#import "RFWindow.h"
#import "RFWindowController.h"

@interface RFAppDelegate (PRIVATE)
- (void)openNewWindow:(NSURL *)fileURL;
- (RFWindowController *)currentWindowController;
@end

@implementation RFAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    windowControllers = [[NSMutableArray alloc] init];
}

- (IBAction)open:(id)sender
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowedFileTypes:ALLOWED_FILE_TYPES];
    if([panel runModal] == NSOKButton) {
        NSURL *fileURL = [[panel URLs] objectAtIndex:0];
        [self openNewWindow:fileURL];
    }
}

- (IBAction)close:(id)sender {
    RFWindowController *windowController = [self currentWindowController];
    [windowControllers removeObject:windowController];
    [windowController close];
}

- (IBAction)duplicate:(id)sender
{
    NSURL *fileURL = [[[NSApp keyWindow] windowController] currentImageURL];
    [self openNewWindow:fileURL];
}

#pragma mark --- PRIVATE ---

- (void)openNewWindow:(NSURL *)fileURL
{
    RFWindowController *windowController = [[RFWindowController alloc] initWithWindowNibName:@"DocumentWindow" initialFileURL:fileURL];
    [windowControllers addObject:windowController];
    [windowController showWindow:self];
}

- (RFWindowController *)currentWindowController
{
    return (RFWindowController *)[[NSApp keyWindow] windowController];
}

@end
