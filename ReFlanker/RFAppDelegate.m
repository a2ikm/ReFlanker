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

@implementation RFAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    windowControllers = [[NSMutableArray alloc] init];
}

- (IBAction)open:(id)sender
{
    RFWindowController *windowController = [[RFWindowController alloc] initWithWindowNibName:@"DocumentWindow"];
    [windowControllers addObject:windowController];
    [windowController showWindow:self];
}

- (IBAction)close:(id)sender {
    [[[NSApp keyWindow] windowController] close];
}

@end
