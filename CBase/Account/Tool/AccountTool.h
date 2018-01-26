//
//  AccountTool.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/24.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

@interface AccountTool : NSObject

/**
 账号管理工具单例

 @return 账号管理工具
 */
+(instancetype)shareInstance;

/**
 创建账号数据库，如果存在直接返回yes
 
  @return 创建结果
 */
-(BOOL)createAccountDatabase;

/**
 创建账户Table，如果存在直接返回yes

 @return 创建结果
 */
-(BOOL)createAccountTable;
/**
 保存用户账号信息

 @param model 账号信息
 @return 执行结果
 */
-(BOOL)saveAccountInfo:(AccountModel *)model;


/**
 根据accountId获取账号信息，如果accountId为nil，默认返回最后插入的账号信息

 @param accountId 账号accountId
 @return 账号信息
 */
-(AccountModel *)getAccountModelWithAccountId:(NSString *)accountId;


/**
 删除账号信息，如果accountId为nil，默认删除从数据库查找出来的

 @param accountId 账号accountId
 @return 执行结果
 */
-(BOOL)deleteAccountWithAccountId:(NSString *)accountId;


/**
 登录

 @param model 登录账号信息
 @param result 登录返回的结果
 */
-(void)loginWithAccountModle:(AccountModel *)model result:(void(^)(KUserInfo *userInfo))result;

/**
 自动登录

 @param result 登录返回的结果
 */
-(void)autoLoginWithBlock:(void(^)(KUserInfo *userInfo))result;


/**
 修改密码

 @param newPwd 新密码
 @param result 修改结果
 */
-(void)changePasswordWithNewPassword:(NSString *)newPwd andOldPassWord:(NSString *)oldPassWord reslut:(void(^)(NSError *error))result;


/**
 手动退出登录
 */
-(void)logOut;

/**
 被挤掉
 */
-(void)knickOut;
@end
