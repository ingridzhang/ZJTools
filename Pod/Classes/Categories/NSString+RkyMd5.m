//
//  NSString+RkyMd5.m
//  EasyJieApp
//
//  Created by easy011 on 15/3/31.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "NSString+RkyMd5.h"

@implementation NSString (RkyMd5)
-(NSString *)md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
@end
