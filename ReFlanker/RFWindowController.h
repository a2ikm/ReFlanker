//
//  RFWindowController.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RFWindow;

@interface RFWindowController : NSWindowController
{
    NSURL *initialFileURL;
}

@property (strong) IBOutlet NSImageView *imageView;

- (id)initWithWindowNibName:(NSString *)windowNibName initialFileURL:(NSURL *)fileURL;

@end
