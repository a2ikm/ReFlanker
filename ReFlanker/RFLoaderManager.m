//
//  RFLoaderManager.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/09/04.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFLoaderManager.h"
#import "RFImageLoader.h"

@implementation RFLoaderManager

static id _sharedManager = nil;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (id<RFLoader>)loaderForURL:(NSURL *)fileURL;
{
    return [[RFImageLoader alloc] initWithURL:fileURL];
}

@end
