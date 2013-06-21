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
#import "NSArray+Ring.h"

@interface RFAppDelegate (PRIVATE)
- (void)openNewWindow:(NSURL *)fileURL;
- (RFWindowController *)currentWindowController;
@end

@implementation RFAppDelegate

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

- (IBAction)nextWindow:(id)sender
{
    RFWindowController *windowController = [windowControllers nextObjectOf:[self currentWindowController]];
    [[windowController window] makeKeyAndOrderFront:sender];
}

- (IBAction)previousWindow:(id)sender
{
    RFWindowController *windowController = [windowControllers previousObjectOf:[self currentWindowController]];
    [[windowController window] makeKeyAndOrderFront:sender];
}

- (NSArray *)allowedFileTypes
{
    return _allowedFileTypes;
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

#pragma mark --- NSApplicationDelegate ---

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    windowControllers = [[NSMutableArray alloc] init];
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    for (NSDictionary *dict in [infoDict objectForKey:@"CFBundleDocumentTypes"]) {
        for (NSString *extension in [dict objectForKey:@"CFBundleTypeExtensions"]) {
            [array addObject:extension];
        }
    }
    _allowedFileTypes = [[NSMutableArray alloc] initWithArray:array copyItems:NO];
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
    NSURL *fileURL = [NSURL fileURLWithPath:filename];
    [self openNewWindow:fileURL];
    return YES;
}

#pragma mark --- NSUserNotificationCenterDelegate ---


- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    [center removeDeliveredNotification:notification];
}

@end
