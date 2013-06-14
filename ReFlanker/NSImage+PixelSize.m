//
//  NSImage+PixelSize.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "NSImage+PixelSize.h"

@implementation NSImage (PixelSize)

- (NSSize)pixelSize
{
    NSBitmapImageRep* imageRep = [NSBitmapImageRep imageRepWithData:[self TIFFRepresentation]];
    return NSMakeSize([imageRep pixelsWide], [imageRep pixelsHigh]);
}

@end
