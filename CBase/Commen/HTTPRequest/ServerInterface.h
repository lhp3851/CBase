//
//  ServerInterface.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#ifndef ServerInterface_h
#define ServerInterface_h

#pragma mark 服务器域名
#define kLOTTERY_SERVICE_IP              @"http://192.168.1.200:58802/clotteryService/?"
#define kLOTTERY_SERVICE_TEST            @"http://127.0.0.1:58802/clotteryService/?"

#if DEBUG
    #define HTML_URL                     @"http://static.zhaocaichina.com/test/operator"
    #define kLOTTERY_SERVICE             @"http://119.23.219.6:58802/clotteryService/?"
#else
    #define HTML_URL                     @"http://static.zhaocaichina.com/operator"
    #define kLOTTERY_SERVICE             @"http://s.zhaocaichina.com:58802/clotteryService/?" //http://lottery.service.tmkj.com:58802/
#endif

static NSString *kSERVICE_PROTOCOL       = @"http://www.zhaocaichina.com/merchantagrement.html";//服务协议

#pragma mark 服务器接口
// 公共接口
static NSString *kDEFAULT_PAGESIZE        = @"15";                       //分页默认每页数据条数
static NSString *kUSER_SERVER_TIME        = @"star/getCurrentTimeMillis";//服务器时间
static NSString *kLOGIN_API               = @"tmkj.user.auth.login";     //登录
static NSString *kAUTO_LOGIN_API          = @"tmkj.user.auth.logins";    //自动登录
static NSString *kLOGOUT_API              = @"tmkj.user.auth.logout";    //退出登录
static NSString *kCHANGE_ACCOUNT_PASSWORD = @"tmkj.user.auth.updatePwd"; //修改密码
static NSString *kGET_OPERATION_API       = @"tmkj.common.ops.get";      //查询用户权限
static NSString *kSEARCH_FLITER_PARAM_API = @"tmkj.common.combf.get";    //搜索参数：m - 运营商， l - 彩种， g - 网点
static NSString *kUPLOAD_DEVIECE_INFO_API = @"tmkj.common.bp.report";    //上报设备信息，用于推送
static NSString *kJOIN_MERCHANT_API       = @"tmkj.admin.joining.add";   //加盟信息登记
static NSString *KMESSAGE_LIST_API        = @"tmkj.admin.message.query"; //消息列表
// 首页接口
static NSString *kHOMEPAGE_API            = @"tmkj.order.appinformation.query";//首页

// 终端接口
static NSString *kTERMINAL_LIST_API       = @"tmkj.terminal.detail.query";//终端列表
static NSString *kTERMINAL_DETAIL_API     = @"tmkj.terminal.detail.get";   //终端详情
static NSString *kTERMINAL_SEARCH_API     = @"tmkj.terminal.detail.search";//终端列表查询
static NSString *kTERMINAL_SETTING_API    = @"tmkj.terminal.setting.setStatus";//终端设置
static NSString *kTERMINAL_GET_SETTING_API= @"tmkj.terminal.setting.getStatus";//获取终端设置
static NSString *kTERMINAL_LOCK_HEAD_API  = @"tmkj.terminal.setting.setHeadStatus";//终端机头解锁、锁定
static NSString *kTERMINAL_ADD_TICKET_API = @"tmkj.supply.terminal.lottery.addLottery";//加票
static NSString *kTERMINAL_CHANGE_TICKET_API = @"tmkj.supply.terminal.lottery.replaceLottery";//换票

// 销售接口
static NSString *kSALES_SUMMARY_API       = @"tmkj.order.appinformation.class.query";//销售-概况
static NSString *kSALES_TERMINAL_DATA_API = @"tmkj.order.appterminalInformationapi.query";//终端数据

// 订单接口
static NSString *kCOMPLETED_ORDER_API     = @"tmkj.order.appcompletedorder.class.query"; //已完成订单
static NSString *kTOBE_REFOUND_ORDER_API  = @"tmkj.order.appwaitrefundorder.query";      //待退款订单列表
static NSString *kDID_REFOUND_ORDDER_API  = @"tmkj.order.appalreadrefundorder.query";    //已退款订单列表
static NSString *kORDER_DETAIL_COMPLETED  = @"tmkj.order.appcompletedorder.class.queryDetail";//已完成订单详情
static NSString *kORDER_DETAIL_TOBE_REFOUND=@"tmkj.order.appwaitrefundorder.queryDetailByOrderId";//待退款订单详情
static NSString *kORDER_DETAIL_DID_REFOUND =@"tmkj.order.appalreadrefundorder.queryDetailByOrderId";//已退款订单详情
static NSString *kORDER_DETAIL_SERCH_API  = @"tmkj.order.appinformation.class.queryAllInfo";//订单搜索
static NSString *kORDER_DETAIL_REFUND     = @"tmkj.order.apprefundapi.class.refundCash"; //退款

// 我的接口
static NSString *kSETTING_TICKET_RECORD         = @"tmkj.terminal.lottery.query";   //票务记录
static NSString *kSETTING_SEARCH_TICKET_RECORD  = @"tmkj.terminal.lottery.search";  //搜索票务记录
static NSString *kSETTING_AWARD_RECORD          = @"tmkj.lottery.reward.search";    //兑奖记录
static NSString *kSETTING_AWARD_RECORD_DETAIL   = @"tmkj.lottery.reward.detail";    //兑奖记录详情

static NSString *kSETTING_FEEDBACK_UPLOAD       = @"tmkj.admin.feedback.add";       //意见反馈上报
static NSString *kSETTING_FEEDBACK_LIST_USER    = @"tmkj.admin.feedback.query";     //意见反馈列表
static NSString *kSETTING_FEEDBACK_DETAIL       = @"tmkj.admin.feedback.get";       //意见反馈详情

static NSString *kSETTING_JOIN_MERCHANT_LIST    = @"tmkj.admin.joining.query";      //加盟信息列表
static NSString *kSETTING_JOIN_MERCHANT_CALLBACK= @"tmkj.admin.joining.update";     //添加回访结果

static NSString *kSETTING_FEEDBACK_LIST_EXCEPTION= @"tmkj.order.terminal.exception.query";//异常反馈列表
static NSString *kSETTING_FEEDBACK_DETAIL_USER  = @"tmkj.order.terminal.exception.get";  //异常反馈详情
static NSString *kSETTING_FEEDBACK_HANDLED_USER = @"tmkj.order.terminal.exception.updateStatus";//异常反馈已解决

static NSString *KSETTING_EARNINGS_TOTAL = @"tmkj.order.appcommissionInfoapi.total";//我的收益总收益
static NSString *KSETTING_EARNINGS_DETAIL = @"tmkj.order.appcommissionInfoapi.detail";//我的收益详情
static NSString *KSETTING_EARNINGS_SEARCH = @"tmkj.order.appcommissionInfoapi.search";//我的收益总收益


#pragma mark 
//公共字段
static double   kDeltaTime            = 0;
#endif /* ServerInterface_h */
