//
//  RFLoaderManager.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/09/04.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFLoader.h"

@interface RFLoaderManager : NSObject

+ (instancetype)sharedManager;
- (id<RFLoader>)loaderForURL:(NSURL *)fileURL;

@end
