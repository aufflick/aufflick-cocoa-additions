//
//  NSData+Aufflick.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 29/09/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import "NSData+Aufflick.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Aufflick)

- (unsigned char *) MGA_md5CharStar
{
	unsigned char *result = malloc(16);
    
	CC_MD5( [self bytes], [self length], result );
    
    return result;
}

- (NSString *) MGA_md5NSString
{
    unsigned char *chars = [self MGA_md5CharStar];
    NSString *ret = [NSString 
                     stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     chars[0], chars[1], chars[2], chars[3],
                     chars[4], chars[5], chars[6], chars[7],
                     chars[8], chars[9], chars[10], chars[11],
                     chars[12], chars[13], chars[14], chars[15]
                     ];
    free(chars);
    
    return ret;
}


@end
