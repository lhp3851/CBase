//
//  ErrorDescription.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "ErrorDescription.h"

@implementation ErrorDescription
+(NSString *)errorCodeDescription:(NSError *)error{
    NSInteger errorCode =error.code;
    NSString *api = error.userInfo[@"api"];
    NSString *domain = error.domain;
    NSString *errorDescription=[NSString stringWithFormat:@"%@%@",domain,api];
    Print(@"错误原因：%@",error.localizedDescription);
#if defined(DEBUG)
    
#else
    errorDescription = @"";
#endif
    switch (errorCode) {
        case errorNetWorkError:{
            errorDescription = kTongMengNetWorkError;
        }
            break;
        case errorFaild:{
            errorDescription = [errorDescription stringByAppendingString:@""];
        }
            break;
        case errorSuccessed:{
            errorDescription=@"";
        }
            break;
        case errorSystemError:{
            errorDescription=[errorDescription stringByAppendingString:@"系统错误"];
        }
            break;
        case errorNoSuchRecord:{
            errorDescription=[errorDescription stringByAppendingString:@"无此记录"];
        }
            break;
        case errorNoOperation:{
            errorDescription=[errorDescription stringByAppendingString:@"无权限"];
        }
            break;
        case errorNotExistAccout:{
            errorDescription= [errorDescription stringByAppendingString:@"用户不存在"];
        }
            break;
        case errorAccountOrPassword:{
            errorDescription= [errorDescription stringByAppendingString:@"帐号或密码不匹配" ];
        }
            break;
        case errorSessionId:{
            errorDescription=[errorDescription stringByAppendingString:@""];
        }
            break;
        case errorKnicedkOut:{
            errorDescription=[errorDescription stringByAppendingString:@"被挤掉"];
        }
            break;
        case errorToken:{
            errorDescription= [errorDescription stringByAppendingString:@""];
        }
            break;
            
        case errorNotEnoughTicket:{
            errorDescription= [errorDescription stringByAppendingString:@"该彩种库存不足"];
        }
            break;
            
        case errorNoDataOperation:{
            errorDescription= [errorDescription stringByAppendingString:@"您没有查看此数据的权限"];
        }
            break;
        default:
        {
            errorDescription = [errorDescription stringByAppendingString:@":未知错误"];
        }
            break;
    }
    return errorDescription;
}
@end
