//
//  RFLoader.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/09/04.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RFLoader <NSObject>

- (id)initWithURL:(NSURL *)fileURL;
- (NSURL *)initialFileURL;

@end
