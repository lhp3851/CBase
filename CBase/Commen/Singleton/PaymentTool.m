//
//  KKStarAlipay.m
//  StarZone
//
//  Created by zhangyongbing on 16/4/22.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "PaymentTool.h"
#import "MJExtension.h"

@implementation PaymentTool


-(void)request
{
    NSInteger ran = random();
    NSDictionary *params = @{@"bizNo":@"000001032",
                             @"payType":@"N1",
                             @"needAmount":@(1200),
                             @"month":@(1),
                             @"balance":@0,
                             @"starUserId":@"1006935846",
                             @"rand":@"2406642773681167261",
                             @"refId":@"ios_test"};
    [KKHttpTool post:@"http://svr.mall.vip.kankan.com/pay/submit" params:params cookied: YES needLogin:YES success:^(id json) {
        NSString *orderString = json[@"data"][@"ext"];
        if (orderString) {
//            [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"com.xiangchao.StarZone" callback:^(NSDictionary *resultDic) {
//                Print(@"reslut ====== %@",resultDic);
//            }];

        }
        
    } failure:^(NSError *error) {
        
    }];
}
@end
