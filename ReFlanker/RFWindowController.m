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

- (id)initWithWindowNibName:(NSString *)windowNibName initialFileURL:(NSURL *)fileURL
{
    if (self = [super initWithWindowNibName:windowNibName]) {
        initialFileURL = fileURL;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    maxSize = self.window.screen.visibleFrame.size;
    
    // Init imageView
    [[self imageView] setImageScaling:NSScaleToFit];
    
    NSImage *image = [[NSImage alloc] initByReferencingURL:initialFileURL];
    [self setImage:image];
}

- (void)setImage:(NSImage *)anImage
{
    [[self imageView] setImage:anImage];
    [[self window] setAspectRatio:[anImage size]];
    
    CGFloat x = self.window.frame.origin.x;
    CGFloat y = self.window.frame.origin.y;
    CGFloat w = anImage.size.width;
    CGFloat h = anImage.size.height;
    if (w > maxSize.width)  { h = h * maxSize.width / w;  w = maxSize.width; }
    if (h > maxSize.height) { w = w * maxSize.height / h; h = maxSize.height; }
    [[self window] setFrame:NSMakeRect(x, y, w, h) display:YES];
}

@end
