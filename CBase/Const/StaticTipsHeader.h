//
//  StaticTipsHeader.h
//  CBase
//
//  Created by Jerry on 26/01/2018.
//  Copyright © 2018 Jerry. All rights reserved.
//

#ifndef StaticTipsHeader_h
#define StaticTipsHeader_h

#import <Foundation/Foundation.h>

#define kTONG_MENG_NET_BUSINESS_TYPE_iPHONE  21
#define kUSER_RANDOM_KYE                     @"9E57A029-7E4A-4250-B887-E0B10F836D4B"
#define kPASSWORD_Rsa_MODULE @"BB443A08EDD52D9EE4FA3204C61FD8692472D617E4834DFE3756ED8261AF0E0BE9E8D61BF67E8E168F6ED61A105EAD6BC6B774A3877625EADE5DB994C3061CEEAB4020563E8A9711842A70948815D0F685410D8D78BA81CCECE40DB287891E866AB7D0B44DECEF0B49D4443C53DDF391DCBA772ECDF9CED8096D5B41ECB43B89"

static NSString *kKKNetworkStatusChangedNotification = @"kNetworkStatusChangedNotification";
static NSString *kTongMengNetWorkError               = @"网络错误，请检查您的网络设置";
static NSString *kTongMengServerError                = @"服务器无法连接";
static NSString *kTongMengEmptyData                  = @"空空如也，啥都木有~";
static NSString *kTongMengNoSearchData               = @"没有搜索到相关数据~";


static NSString *kBundle_Name                        = @"com.tmkj.CBase";

//model.name = "深圳市"//默认当前城市：
//model.addressId = 2165
//model.code = 440300
//model.pcode = 440000
static NSInteger kAll_Dictrict_Code                  = 0;//china
static NSInteger kDELTA_TIME                         = 0;//本地时间与服务器时间差



static NSString *kNICKED_OUT_NOTI_NAME               = @"knicked_out_noti_name";
static NSString *kCHANGE_START_DATE                  = @"kchange_start_date";
static NSString *kCHANGE_END_DATE                    = @"kchange_end_date";
static NSString *kRESET_DATE_CONDITION               = @"kreset_date_condition";
static NSString *kBACK_FROM_SEARCH                   = @"kback_from_search";



#endif /* StaticTipsHeader_h */
