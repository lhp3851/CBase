//
//  AccountTool.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/24.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "AccountTool.h"
#import "UIWindow+Extension.h"
#import "TabBarViewController.h"
#import "LoginViewController.h"
#import "FMDB.h"
#import "KKCryptTool.h"
#import "KKKeyChainManager.h"
#import "NavigationViewController.h"


static FMDatabase *db;

@interface AccountTool ()

@end

@implementation AccountTool

+(instancetype)shareInstance{
    static AccountTool *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [AccountTool new];
        [instance createAccountDatabase];
    });
    return instance;
}

BOOL isExistTable(FMDatabase *db,NSString * tableName)
{
    NSString *name =nil;
    BOOL isExistTable =false;
    if ([db open]) {
        NSString * sql = [[NSString alloc]initWithFormat:@"select name from sqlite_master where type = 'table' and name = '%@'",tableName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            name = [rs stringForColumn:@"name"];
            if ([name isEqualToString:tableName])
            {
                isExistTable =true;
            }
        }
        [db close];
    }
    return isExistTable;
}


BOOL isDBExist(NSString * dbPath){
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:dbPath]) {
        return YES;
    }else{
        return NO;
    }
}


-(BOOL)createAccountDatabase{
    NSString *docPath = [FileOperationManager getSandBoxDocumentPath];
    NSString *path = [docPath stringByAppendingPathComponent:@"account.db"];
    db = [FMDatabase databaseWithPath:path];
    if (db) {
        return YES;
    }
    return NO;
}

-(BOOL)createAccountTable{
    BOOL exsit = isExistTable(db, @"Account");
    if (exsit) {
        return YES;
    }
    else{
        if (db) {
            [db open];
            NSString *personSql = @"CREATE TABLE 'Account' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'account_id' VARCHAR(255),'account_name' VARCHAR(255),'account_password' VARCHAR(255),'account_role' VARCHAR(255),'longins' VARCHAR(255),'sessionId' VARCHAR(255),'staffId' VARCHAR(255),'staffName' VARCHAR(255))";
            if ([db executeStatements:personSql]) {
                [db close];
                return YES;
            }
            else{
                if (isExistTable(db, @"Account")) {
                    [db close];
                    return YES;
                }
                [db close];
                return false;
            }
        }
        else{
            [db close];
            return false;
        }
    }
}


-(BOOL)saveAccountInfo:(AccountModel *)model{
    AccountTool *tool = [AccountTool shareInstance];
    BOOL createdTB = [tool createAccountTable];
    if (createdTB) {
        if ([db open]) {
            if ([db executeUpdate:@"INSERT INTO 'Account'(account_id,account_name,account_password,account_role,longins,sessionId,staffId,staffName)VALUES(?,?,?,?,?,?,?,?)", model.loginId,model.loginName,model.password,model.roleId,model.logins,model.sessionId,model.staffId,model.staffName]) {
                [db close];
                Print(@"保存账号成功");
                return true;
            }
            [db close];
            return false;
        }
        else{
            [db close];
            return false;
        }
    }
    else{
        Print(@"保存账号失败");
        [db close];
        return false;
    }
}

-(BOOL)updateAccountModel:(AccountModel *)newModel{
    if ([db open]) {//UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
        if ([db executeUpdate:@"UPDATE 'Account' SET account_password = ? WHERE account_id = ?",newModel.password,newModel.loginId]) {
            [db close];
            return YES;
        }
        else{
            return NO;
        }
    }
    [db close];
    return NO;
}

-(AccountModel *)getAccountModelWithAccountId:(NSString *)accountId{
    if ([db open]) {
        NSString *statement = [NSString stringWithFormat:@"SELECT * FROM 'Account' where own_id = %@",accountId];
        
        if ([NSString isBlank:accountId]) {
            statement = [NSString stringWithFormat:@"SELECT * FROM 'Account'"];
        }
        
        FMResultSet *set=  [db executeQuery:statement];
        AccountModel *model = [AccountModel new];
        while ([set next]) {
            model.loginId  = [set stringForColumn:@"account_id"];
            model.loginName= [set stringForColumn:@"account_name"];
            model.password = [set stringForColumn:@"account_password"];
            model.sessionId= [set stringForColumn:@"sessionId"];
            model.logins   = [set stringForColumn:@"longins"];
            model.staffId  = [set stringForColumn:@"staffId"];
            model.staffName= [set stringForColumn:@"staffName"];
            model.roleId   = [set stringForColumn:@"account_role"];
        }
        [db close];
        return model;
    }
    else{
        [db close];
        return nil;
    }
}

-(BOOL)deleteAccountWithAccountId:(NSString *)accountId{
    if ([db open]) {
        if ([NSString isBlank:accountId]) {
            AccountModel *model = [self getAccountModelWithAccountId:accountId];
            accountId = model.loginId;
        }

        if ([db open] && [db executeUpdate:@"DELETE FROM 'Account' where account_id = ?",accountId]) {
            [db close];
            return YES;
        }
        [db close];
        return NO;
    }
    else{
        [db close];
        return NO;
    }
}

-(void)loginWithAccountModle:(AccountModel *)model result:(void(^)(KUserInfo *userInfo))result{
    NSString *URL = [AbsoluntRequestUrl reqestWithLotteryService];
    NSString *loginName = [NSString stringWithFormat:@"[l]%@[l]",model.loginName];
    NSString *pwd       = [NSString stringWithFormat:@"[p]%@[p]",model.password];
    NSString *deviceid  = [NSString stringWithFormat:@"[d]%@[d]",[KKKeyChainManager getUUIDString]];
    
    NSString *content   = [NSString stringWithFormat:@"%@%@%@",loginName,pwd,deviceid];
    content = [KKCryptTool encryptWithContent:content time_stamp:nil];
    NSDictionary *param =@{@"api"    :kLOGIN_API,
                           @"logins" :content};
    [KKHttpTool post:URL params:param success:^(id object) {
       NSString *code = object[@"code"];
       NSError *error  = [NSError errorWithDomain:URL code:code.integerValue userInfo:param];
       if (code.integerValue == errorSuccessed) {
          KUserInfo *userInfo = [KUserInfo mj_objectWithKeyValues:object[@"data"]];
          userInfo.loginInfo.password = model.password;
          NSTimeInterval currentTimeInterval = [NSDate date].timeIntervalSince1970;
          kDELTA_TIME = userInfo.loginInfo.ts - currentTimeInterval*1000;
          result(userInfo);
           [self saveAccountInfo:userInfo.loginInfo];
           [self loginSuccess];
       }
      else{
          result(nil);
          [KKStarPromptBox showPromptBoxWithWords:[ErrorDescription errorCodeDescription:error]];
      }
    } failure:^(NSError *error) {
        result(nil);
        [KKStarPromptBox showPromptBoxWithWords:[ErrorDescription errorCodeDescription:error] ];
    }];
}

-(void)autoLoginWithBlock:(void(^)(KUserInfo *userInfo))result{
    AccountModel *model = [[AccountTool shareInstance] getAccountModelWithAccountId:0];
    if (model.logins) {
        NSString *URL = [AbsoluntRequestUrl reqestWithLotteryService];
        NSDictionary *param = @{@"api"    :kAUTO_LOGIN_API,
                                @"logins" :model.logins};
        [KKHttpTool post:URL params:param success:^(id object) {
          NSString *code = object[@"code"];
          NSError *error  = [NSError errorWithDomain:URL code:code.integerValue userInfo:param];
          if (code.integerValue == errorSuccessed) {
              KUserInfo *userInfo = [KUserInfo mj_objectWithKeyValues:object[@"data"]];
              userInfo.loginInfo.password = model.password;
              NSTimeInterval currentTimeInterval = [NSDate date].timeIntervalSince1970;
              kDELTA_TIME = userInfo.loginInfo.ts - currentTimeInterval*1000;
              result(userInfo);
              [self saveAccountInfo:userInfo.loginInfo];
              [self loginSuccess];
          }
          else{
              [self loginFaild];
              [KKStarPromptBox showPromptBoxWithWords:[ErrorDescription errorCodeDescription:error]];
          }
        } failure:^(NSError *error) {
            result(nil);
            [self loginFaild];
        }];
    }
    else{
        result(nil);
        [self loginFaild];
    }
}


/**
 登录失败
 */
-(void)loginFaild{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    NavigationViewController *loginNav = [[NavigationViewController alloc]initWithRootViewController:loginVC];
    [UIWindow changeRootViewControllerWithNavigationController:loginNav];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"mannul_logout"];
//    [self deleteAccountWithAccountId:nil];
}

/**
 登录成功
 */
-(void)loginSuccess{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"mannul_logout"];
    TabBarViewController *tabBarVC = [TabBarViewController new];
    [UIWindow changeRootViewControllerWithTabBarController:tabBarVC];
    [self requestToUploadDeviceInfo];
}


-(void)changePasswordWithNewPassword:(NSString *)newPwd andOldPassWord:(NSString *)oldPassWord reslut:(void(^)(NSError *error))result{
    NSString *oldPassword = [NSString stringWithFormat:@"[p]%@[p]",oldPassWord];//[KUserInfo sharedKUserInfo].loginInfo.password
    NSString *newPassword = [NSString stringWithFormat:@"[m]%@[m]",newPwd];
    NSString *deviceid    = [NSString stringWithFormat:@"[d]%@[d]",[KKKeyChainManager getUUIDString]];
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterVal = date.timeIntervalSince1970*1000 + kDELTA_TIME;
    NSString *timeInterValString = [NSString stringWithFormat:@"[t]%.0f[t]",timeInterVal];
    NSString *pContentRaw =[NSString stringWithFormat:@"%@%@%@%@",oldPassword,newPassword,deviceid,timeInterValString];
    NSString *pContent = [KKCryptTool encryptWithContent:pContentRaw time_stamp:nil];
    
    NSString *URL = [AbsoluntRequestUrl reqestWithLotteryService];
    NSDictionary *param = @{@"api"      :kCHANGE_ACCOUNT_PASSWORD,
                            @"autoLogin":@"",
                            @"pContent" :pContent};

    [KKHttpTool post:URL params:param cookied:NO needLogin:YES  success:^(id object) {
          NSString *code = object[@"code"];
          NSError *error  = [NSError errorWithDomain:URL code:code.integerValue userInfo:param];
          if (code.integerValue == errorSuccessed) {
              result(error);
              AccountModel *model = [KUserInfo sharedKUserInfo].loginInfo;
              model.password = newPwd;
              [self updateAccountModel:model];
              [self loginWithAccountModle:model result:^(KUserInfo *userInfo) {//修改密码登录后自动登录
                  if (userInfo) {
                      Print(@"修改密码自动登录成功");
                  }
                  else{
                      Print(@"修改密码自动登录失败");
                  }
              }];
          }
          else{
              result(error);
          }
        
    } failure:^(NSError *error) {
        result(error);
    }];
}

-(void)logOut{
    if ([KUserInfo sharedKUserInfo].loginInfo.loginId == nil) {
        return;
    }
    NSString *URL = [AbsoluntRequestUrl reqestWithLotteryService];
    NSDictionary *param = @{@"api":kLOGOUT_API,@"loginId":[KUserInfo sharedKUserInfo].loginInfo.loginId};
    [KKHttpTool post:URL params:param cookied:NO needLogin:YES  success:^(id object) {
        NSString *code = object[@"code"];
        NSError *error  = [NSError errorWithDomain:URL code:code.integerValue userInfo:param];
        if (code.integerValue ==errorSuccessed) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            NavigationViewController *loginNav = [[NavigationViewController alloc]initWithRootViewController:loginVC];
            
//            [self deleteAccountWithAccountId:[KUserInfo sharedKUserInfo].loginInfo.loginId];
            [KUserInfo attemptDealloc];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kOOPERATIONS_USER"];//退出登录的时候清理，登录失败的时候不要清理
            
            NSArray *windows = [UIApplication sharedApplication].windows;
            UIWindow *window = windows[1];
            window.rootViewController = loginNav;
        }
        else{
            [KKStarPromptBox showPromptBoxWithWords:[ErrorDescription errorCodeDescription:error]];
        }
    } failure:^(NSError *error) {
        [KKStarPromptBox showPromptBoxWithWords:[ErrorDescription errorCodeDescription:error]];
    }];
}

-(void)knickOut{
    [KUserInfo attemptDealloc];
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    NavigationViewController *loginNav = [[NavigationViewController alloc]initWithRootViewController:loginVC];
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *window = windows[1];
    window.rootViewController = loginNav;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kOOPERATIONS_USER"];//退出登录的时候清理，登录失败的时候不要清理
}

#pragma mark 百度推送上报数据
-(void)requestToUploadDeviceInfo{
#warning 设备ID，需要另外获取
    NSString *channled = @"65646466666";
    NSString *URL = [AbsoluntRequestUrl reqestWithLotteryService];
    NSDictionary *param = @{@"api":kUPLOAD_DEVIECE_INFO_API,
                            @"bChannelId":channled==nil?@"":channled,
                            @"os":@"1"};
    [KKHttpTool post:URL
              params:param
             cookied:NO
           needLogin:YES
     success:^(id object) {
         NSString *codeString = object[@"code"];
         NSError *error  = [NSError errorWithDomain:URL code:codeString.integerValue userInfo:param];
         if (codeString.integerValue == errorSuccessed) {
             Print(@"上报设备结果：%@",object[@"data"]);
         }
         else{
             [KKStarPromptBox showPromptBoxWithWords:[ErrorDescription errorCodeDescription:error]];
         }
     } failure:^(NSError *error) {
         [KKStarPromptBox showPromptBoxWithWords:[ErrorDescription errorCodeDescription:error]];
     }];
}


@end
