//
//  NSString+RSA.m
//  IkanKan
//
//  Created by 朱国清 on 15/9/16.
//  Copyright (c) 2015年 shigu. All rights reserved.
//

#import "NSString+RSA.h"
#include "openssl_cryptoimp.h"


@implementation NSString(RSA)
- (NSString *)rsaEncrypt {
    const char *original_str = [self UTF8String];
    xlexternal::OpenSSLCrypto * openSSLCrypto = new xlexternal::OpenSSLCrypto();
    std::string str = openSSLCrypto->rsaEncode(original_str,[kPASSWORD_Rsa_MODULE UTF8String]);
    delete openSSLCrypto;
    return [NSString stringWithCString:str.c_str() encoding:NSUTF8StringEncoding];
}
- (NSString *)sha1Encrypt {
    const char *original_str = [self UTF8String];
    xlexternal::OpenSSLCrypto * openSSLCrypto = new xlexternal::OpenSSLCrypto();
    std::string str = openSSLCrypto->sha1(original_str);
    delete openSSLCrypto;
    return [NSString stringWithCString:str.c_str() encoding:NSUTF8StringEncoding];
}
- (NSString *)md5Encrypt {
    
    const char *original_str = [self UTF8String];
    xlexternal::OpenSSLCrypto * openSSLCrypto = new xlexternal::OpenSSLCrypto();
    std::string str = openSSLCrypto->md5(original_str);
    delete openSSLCrypto;
    return [NSString stringWithCString:str.c_str() encoding:NSUTF8StringEncoding];
}
-(NSString *)decodeUnicode{

    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData   *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr= [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
@end
