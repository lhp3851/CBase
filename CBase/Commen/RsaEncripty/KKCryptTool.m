//
//  KKCryptTool.m
//  StarZone
//
//  Created by WS on 16/6/28.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#include <openssl/md5.h>
#include <openssl/aes.h>
#import "KKCryptTool.h"
#import "NSData+CommonCrypto.h"
#import "NSData+Base64.h"

#define kSeparator @""
#define kProjectName @"com.tmkj.Merchant"
#define kAES_Key @"CleYWzMFuKt749BV"

@implementation KKCryptTool

+ (NSString*)md5EncryptWithContent:(NSString*)content{
    
    const char *data = [content cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char md[16];
    NSMutableString *result = [NSMutableString stringWithCapacity:32];
    MD5((const unsigned char*)data,strlen(data),md);
    for (int i = 0; i < 16; i++){
        [result appendFormat:@"%2.2x",md[i]];
    }
    return [result copy];
    
}

+(NSData*)encryptText:(NSString*)text {
    CCCryptorStatus status = kCCSuccess;
    NSData* result = [[text dataUsingEncoding:NSUTF8StringEncoding]
                      dataEncryptedUsingAlgorithm:kCCAlgorithmAES128
                      key:kAES_Key
                      initializationVector:nil   // ECB加密不会用到iv
                      options:(kCCOptionPKCS7Padding|kCCOptionECBMode)
                      error:&status];
    if (status != kCCSuccess) {
        return nil;
    }
    
    return result;
}

+ (NSData *)aesEncryptWithContent:(NSString*)content{
    
    AES_KEY key;
    
    const char *aesKey = [kAES_Key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *data   = [content cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned long len  = (strlen(data)+15)/16 * 16;
    const char outData[len] ;
    AES_set_encrypt_key((const unsigned char *)aesKey,128,&key);
    
    AES_ecb_encrypt((const unsigned char *)data, (unsigned char *)outData, &key, AES_ENCRYPT);

    NSData *ooutData = [NSData dataWithBytes:outData length:len * sizeof(char)];

    return ooutData;
}


+ (NSString*)encryptWithContent:(NSString *)contents time_stamp:(NSString*)time{
    NSData *encodeData = [self encryptText:contents];
    NSString *base64   = [encodeData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    NSString *url      = [NSString encodeToURLString:base64];
    return url;
}

+ (NSString *)getEncryptCode{
    NSString *userId = [KUserInfo sharedKUserInfo].loginInfo.loginId ? [KUserInfo sharedKUserInfo].loginInfo.loginId : @"";
    NSString *timeStamp = [[NSDate date] timestamp];
    NSString *code = [KKCryptTool encryptWithContent:userId time_stamp:timeStamp];
    return code;
}




@end
