//
//  NSString+RkyMd5.h
//  EasyJieApp
//
//  Created by easy011 on 15/3/31.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (RkyMd5)
-(NSString *)md5HexDigest;
@end
