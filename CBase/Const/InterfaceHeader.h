//
//  InterfaceHeader.h
//  CBase
//
//  Created by Jerry on 26/01/2018.
//  Copyright © 2018 Jerry. All rights reserved.
//

#ifndef InterfaceHeader_h
#define InterfaceHeader_h


#if DEBUG
    #define HTML_URL                     @"http://static.zhaocaichina.com/test/operator"
    #define kSERVICE                     @"http://119.23.219.6:58802/clotteryService/?"
#else
    #define HTML_URL                     @"http://static.zhaocaichina.com/operator"
    #define kSERVICE                     @"http://s.zhaocaichina.com:58802/clotteryService/?"
#endif

static NSInteger kDEFAULT_PAGESIZE        = 15;                          //分页默认每页数据条数

static NSString *kUSER_SERVER_TIME_API    = @"star/getCurrentTimeMillis";//服务器时间
static NSString *kUPLOAD_DEVIECE_INFO_API = @"";//上传设备ID

static NSString *kAUTO_LOGIN_API          =@"";
static NSString *kLOGIN_API               =@"";
static NSString *kLOGOUT_API              =@"";
static NSString *kCHANGE_ACCOUNT_PASSWORD =@"";


#endif /* InterfaceHeader_h */
