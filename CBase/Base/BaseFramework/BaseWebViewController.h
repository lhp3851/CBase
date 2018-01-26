//
//  BaseWebViewController.h
//  TMKJ_Merchant
//
//  Created by Jerry on 2017/12/5.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    TerminalTicketOperateTypeAdd,//加票
    TerminalTicketOperateTypeChange,//换票
    TerminalTicketOperateTypeOhter,//其他
} TerminalTicketOperateType;

@interface BaseWebViewController : BaseViewController
@property(nonatomic,strong)NSString *lotteryCode;////彩种编号
@property(nonatomic,assign)TerminalTicketOperateType type;

/**
 baseWebView 的定制构造函数

 @param fileName 文件名
 @param subDirectory 文件目录
 @return BaseWebViewController 实例
 */
-(instancetype)initWithFileName:(NSString *)fileName subDirectory:(NSString *)subDirectory lotteryCode:(NSString*)lotteryCode;

@end
