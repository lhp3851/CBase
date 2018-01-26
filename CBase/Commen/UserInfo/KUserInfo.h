//
//  KKStarUserInfo.h
//  KKStarZone
//
//  Created by TinySail on 15/11/21.
//  Copyright (c) 2015年 kankan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AccountModel.h"
#import "BaseModel.h"

@interface KUserInfo : BaseModel



//账户类型
//**********************************************
//用户类型可以组合，比如明星可以是会员，也是普通用户，也是明星类型
//判断是否为会员（type&KKUserTypeMember==1）,表示是会员，
//**********************************************
typedef NS_ENUM(NSInteger, KKUserType) {
    KKUserTypeOther         =-1,//其它
    
    KKUserTypeNormal        = 0,//普通用户
    KKUserTypeStar          = 1,//明星
    KKUserTypeEditor        = 2,//小编
    KKUserTypeMember        = 3,//会员
    KKUserTypeOnlineStar    = 4,//网红
    KKUserTypeAdministrator = 10,//超级管理员
};


//用户性别
typedef NS_OPTIONS(NSInteger, Gender) {
    
    userSex_No    = 0,
    
    userSex_Men   = 1,//男
    
    userSex_Women = 2//女
    
};


//用户账户来源  明星空间账号 / QQ账号 / 微信账号 / 微博账号
typedef NS_OPTIONS(int, userFromType) {
    //QQ账号
    userFromType_QQ = 43,
    
    //看看账号
    userFromType_KK = 20,
    
    //说说账号
    userFromType_SS = 3,
    
    //微博账号
    userFromType_WB = 44,
    
    //微信账号
    userFromType_WX = 42
};

singleton_interface(KUserInfo);

@property(nonatomic,strong)NSString *address;

@property(nonatomic,strong)NSString *avartar;

@property(nonatomic,strong)AccountModel *loginInfo;

@property(nonatomic,strong)NSString *merchantId;//运营商或者运营商维护员的时候有效

@property(nonatomic,strong)NSString *merchantUserId;

@property(nonatomic,strong)NSString *merchantUserName;

@property(nonatomic,assign)Gender sex;

@property(nonatomic,strong)NSString *tel;


/**
 退出登录销毁登录信息
 */
+ (void)attemptDealloc;


- (id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
