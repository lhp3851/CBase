//
//  ErrorDescription.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    errorNetWorkError         =-1009,//网络故障
    errorFaild                =-1, //操作失败
    errorSuccessed            =0,  //操作成功
    
    errorSystemError          =2,  //系统错误
    errorNoSuchRecord         =3,  //无此记录
    errorNoOperation          =4,  //没有权限
    errorNotExistAccout       =10, //用户不存在
    errorAccountOrPassword    =11, //帐号或密码错误
    errorSessionId            =15, //sessionId不匹配
    errorKnicedkOut           =16, //被挤掉，切换设备
    errorToken                =17, //loginToken, sToken失效
    
    errorNotEnoughTicket      =101,//该彩种库存不足
    
    errorServerInternalCode   =500,//服务器内部错误
    
    
    errorNoDataOperation      =10000000,//无数据权限
    
}ErrorDescriptionCode;


@interface ErrorDescription : NSString

/**
 故障描述

 @param errorCode 接口错误码
 @return 故障描述
 */
+(NSString *)errorCodeDescription:(NSError *)error;
@end
