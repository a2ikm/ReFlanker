//
//  NSString+NaturalSort.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/07/06.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "NSString+NaturalSort.h"
#import "strnatcmp.h"

@implementation NSString (NaturalSort)

- (NSComparisonResult)naturalCompare:(NSString *)other
{
    nat_char const *string1 = (nat_char *)[self UTF8String];
    nat_char const *string2 = (nat_char *)[other UTF8String];
    
    int result = strnatcasecmp(string1, string2);
    
    if (result < 0) {
        return NSOrderedAscending;
    } else if (result > 0) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

- (NSComparisonResult)caseInsensitiveNaturalCompare:(NSString *)other
{
    nat_char const *string1 = (nat_char *)[self UTF8String];
    nat_char const *string2 = (nat_char *)[other UTF8String];
    
    int result = strnatcmp(string1, string2);
    
    if (result < 0) {
        return NSOrderedAscending;
    } else if (result > 0) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

@end
