//
//  RFWindowController.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFWindowController.h"

@interface RFWindowController (PRIVATE)
-(void)setImage:(NSImage *)anImage;
@end

@implementation RFWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Init imageView
    [[self imageView] setImageScaling:NSScaleToFit];
    
    NSImage *image = [[NSImage alloc] initByReferencingFile:@"/path/to/image"];
    [self setImage:image];
}

- (void)setImage:(NSImage *)anImage
{
    [[self imageView] setImage:anImage];
    [[self window] setAspectRatio:[anImage size]];
    
    NSRect frameRect = NSMakeRect(self.window.frame.origin.x, self.window.frame.origin.y,
                                  anImage.size.width, anImage.size.height);
    [[self window] setFrame:frameRect display:YES];
}

@end
