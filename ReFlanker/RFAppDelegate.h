//
//  RFAppDelegate.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RFWindow;

@interface RFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet RFWindow *window;
@property (assign) IBOutlet NSImageView *imageView;

@end
