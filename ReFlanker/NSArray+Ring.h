//
//  NSArray+Ring.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/19.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Ring)
- (NSUInteger)lastIndex;
- (id)nextObjectOf:(id)object;
- (id)previousObjectOf:(id)object;
@end
