//
//  NSData+MD5Digest.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/09/05.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "NSData+MD5Digest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5Digest)

- (NSString *)MD5Digest
{
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (unsigned int)self.length, md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return (NSString *)output;
}

@end
