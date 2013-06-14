//
//  RFAppDelegate.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFAppDelegate.h"
#import "RFWindow.h"

@implementation RFAppDelegate

- (void)setImage:(NSImage *)anImage
{
    [[self imageView] setImage:anImage];
    [[self window] setAspectRatio:[anImage size]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Init imageView
    [[self imageView] setImageScaling:NSScaleToFit];
    
    NSImage *image = [[NSImage alloc] initByReferencingFile:@"/path/to/image"];
    [self setImage: image];
}

@end
