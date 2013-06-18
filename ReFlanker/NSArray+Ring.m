//
//  NSArray+Ring.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/19.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "NSArray+Ring.h"

@implementation NSArray (Ring)

- (NSUInteger)lastIndex
{
    if ([self count] > 0) {
        return [self count] - 1;
    } else {
        return NSNotFound;
    }
}

- (id)nextObjectOf:(id)object
{
    if ([self count] == 0) return nil;
    
    NSUInteger i = [self indexOfObject:object];
    NSUInteger nextIndex = (i < [self lastIndex]) ? i + 1 : 0;
    return [self objectAtIndex:nextIndex];
}

- (id)previousObjectOf:(id)object
{
    if ([self count] == 0) return nil;
    
    NSUInteger i = [self indexOfObject:object];
    NSUInteger previousIndex = (i > 0) ? i - 1 : [self lastIndex];
    return [self objectAtIndex:previousIndex];
}

@end
