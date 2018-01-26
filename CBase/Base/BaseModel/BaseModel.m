//
//  BaseModel.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (void)initialize{
    cellClassNameAndModel = @{
                              @"MertchantModelItem"     :@"JoinMerchantTableViewCell",
                              @"TermianlModel"          :@"TermianlTableViewCell",
                              @"TerminalHeadModel"      :@"TermianlDetailCell",
                              @"AddTicketRecordModel"   :@"AddTicketRecordCell",
                              @"ChangeTicketRecordModel":@"ChangeTicketRecordCell",
                              @"AwardRecordModel"       :@"AwardRecordCell",
                              @"AwardDetailModel"       :@"AwardRecordDetailCell",
                              @"AwardListModel"         :@"AwardRecordOperateListCell",
                              @"SalesTrendModel"        :@"SalesTrendCell",
                              @"SalesStaticModel"       :@"SalesStaticsCell",
                              @"SalesTerminalModel"     :@"SalesStaticsCell",
                              @"FirstSectionModel"      :@"FirstSectionCell",
                              @"SecondSectionModel"     :@"SecondSectionCell",
                              @"ThirdSectionMoel"       :@"ThirdSectionCell",
                              @"OrderListModel"         :@"OrderListCell",
                              @"orderListToBeRefoundModel":@"OrderListCell",
                              @"orderListDidRefoundModle" :@"OrderListCell",
                              @"OrderDetailModel"       :@"OrderDetailCell",
                              @"LotteryInfoModel"       :@"OrderLotteryInfoDetailCell",
                              @"OrderPaymmentInfoModel" :@"OrderPaymentDetailCell",
                              @"FeedbackExceptionModel" :@"FeedBackCell",
                              @"FeedbackUserModel"      :@"FeedBackUserFeedBackCell",
                              @"FeedbackJoinMerchantModel":@"FeedBackJoinMerchantCell",
                              @"MessageModel"           :@"MessageTableViewCell",
                              @"IncomeDetailModel"      :@"IncomeDetailCell"
                              };
    

}

/**
 根据模型返回类名

 @param model 数据模型
 @return 模型名
 */
+(NSString *)modelNameWithModel:(BaseModel *)model{
    return NSStringFromClass([model class]);
}



/**
 根据model返回cell名

 @param model 数据模型
 @return cell名字
 */
+(NSString *)cellNameWithModel:(BaseModel *)model{
    NSString *cellName = [BaseModel modelNameWithModel:model];
    return [cellClassNameAndModel valueForKey:cellName];
}





@end
