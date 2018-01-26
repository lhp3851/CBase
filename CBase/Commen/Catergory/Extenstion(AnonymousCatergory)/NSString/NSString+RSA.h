//
//  NSString+RSA.h
//  IkanKan
//
//  Created by 朱国清 on 15/9/16.
//  Copyright (c) 2015年 shigu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(RSA)
- (NSString *)rsaEncrypt;
- (NSString *)sha1Encrypt;
- (NSString *)md5Encrypt;
- (NSString *)decodeUnicode;
@end
