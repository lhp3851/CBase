//
//  SearchParamModel.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/7/1.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "SearchParamModel.h"

@implementation SearchGridModel



@end


@implementation SearchMerchantModel



@end


@implementation SearchLotteryCalssesModel



@end




@implementation SearchParamModel

singleton_implementation(SearchParamModel)


//+(id)shareInstance{
//    static SearchParamModel *instance = nil;
//    static dispatch_once_t once_t;
//    dispatch_once(&once_t, ^{
//        instance = [SearchParamModel new];
//    });
//    return instance;
//}

+ (NSDictionary *)mj_objectClassInArray

{
    return @{@"grid" : [SearchGridModel class],
             @"merchant" : [SearchMerchantModel class],
             @"lotteryClasse" : [SearchLotteryCalssesModel class]};
    
}

@end
