//
//  AbsoluntRequestUrl.h
//  KKStarZone
//
//  Created by kankanliu on 15/12/4.
//  Copyright © 2015年 kankan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbsoluntRequestUrl : NSObject

+(NSString*)reqestWithLotteryService;

+(NSString*)reqestWithStarService:(NSString *)interface;

+(NSString*)reqestWithStarServiceHTTPS:(NSString *)interface;

+(NSString*)reqestWithUploadImageService:(NSString *)interface;

+(NSString*)reqestWithPaymentService:(NSString *)interface;

@end
