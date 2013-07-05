//
//  NSString+NaturalSort.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/07/06.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NaturalSort)

- (NSComparisonResult)naturalCompare:(NSString *)other;
- (NSComparisonResult)caseInsensitiveNaturalCompare:(NSString *)other;

@end
