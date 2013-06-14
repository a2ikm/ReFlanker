//
//  RFWindow.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFWindow.h"

@implementation RFWindow

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag {
    
    self = [super initWithContentRect:contentRect
                            styleMask:(NSBorderlessWindowMask | NSResizableWindowMask)
                              backing:NSBackingStoreBuffered defer:NO];
    if (self != nil) {
        [self setAlphaValue:1.0];
        [self setOpaque:NO];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow {
    
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent {
    initialLocation = [theEvent locationInWindow];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    
    NSRect windowFrame = [self frame];
    NSPoint newOrigin = windowFrame.origin;
    
    NSPoint currentLocation = [theEvent locationInWindow];
    newOrigin.x += (currentLocation.x - initialLocation.x);
    newOrigin.y += (currentLocation.y - initialLocation.y);

    [self setFrameOrigin:newOrigin];
}

@end
