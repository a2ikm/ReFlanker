//
//  RFImageLoader.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/09/04.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFImageLoader.h"

@interface RFImageLoader ()
@property (nonatomic, retain) NSURL *fileURL;
@end

@implementation RFImageLoader

- (id)initWithURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        self.fileURL = fileURL;
    }
    return self;
}

- (NSURL *)initialFileURL
{
    return self.fileURL;
}

@end
