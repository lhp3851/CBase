//
//  AbsoluntRequestUrl.m
//  KKStarZone
//
//  Created by kankanliu on 15/12/4.
//  Copyright © 2015年 kankan. All rights reserved.
//

#import "AbsoluntRequestUrl.h"

@implementation AbsoluntRequestUrl

+(NSString*)reqestWithLotteryService{

    return kSERVICE;

}

+(NSString*)reqestWithStarService:(NSString *)interface{
    NSString *baseURL=@"";
    baseURL=[baseURL stringByAppendingString:interface];
    return baseURL;
}

+(NSString*)reqestWithStarServiceHTTPS:(NSString *)interface{
    NSString *baseURL=@"";
    baseURL=[baseURL stringByAppendingString:interface];
    return baseURL;
}

+(NSString*)reqestWithUploadImageService:(NSString *)interface{
    NSString *baseURL=@"";
    baseURL=[baseURL stringByAppendingString:interface];
    return baseURL;
}

+(NSString*)reqestWithPaymentService:(NSString *)interface{
    NSString *baseURL=@"";
    baseURL=[baseURL stringByAppendingString:interface];
    return baseURL;
}
@end
