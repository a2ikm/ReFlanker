//
//  RFAppDelegate.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RFAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>
{
    NSMutableArray *windowControllers;
    NSArray *_allowedFileTypes;
}

- (IBAction)openAbout:(id)sender;

- (IBAction)open:(id)sender;
- (IBAction)close:(id)sender;

- (IBAction)nextWindow:(id)sender;
- (IBAction)previousWindow:(id)sender;

- (NSArray *)allowedFileTypes;
- (void)openNewWindowWithInitialFileURL:(NSURL *)fileURL;

- (NSURL *)cacheDirectory;

@end
