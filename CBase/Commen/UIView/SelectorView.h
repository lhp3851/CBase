//
//  Selector.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/13.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"


typedef enum : NSUInteger {
    selectorTypeDistric,       //地区
    selectorTypeCleander,      //日历
    selectorTypeLotteryClass,  //彩票种类
    selectorTypeTerminalStatus,//终端状态
    selectorTypeGrid,          //网点
    selectorTypeMerchant,      //运营商
    selectorTypePayment,       //支付方式
    selectorTypeNone,          //未知类型
} selectorType;

@protocol ClearSelectorViewDelegate <NSObject>

-(BOOL)clearSelectViewDelegateWithDatas:(NSArray *)datas andSelectorType:(selectorType)type;

@end

@interface SelectorView : UIView

@property(nonatomic,assign)id<ClearSelectorViewDelegate> delegate;

/**
 不带数据的初始化
 
 @param frame frame
 @param type selectorType
 @param delegate delegate
 @return 筛选器
 */
-(instancetype)initWithFrame:(CGRect)frame selectorType:(selectorType)type delegate:(id<ClearSelectorViewDelegate>)delegate;


/**
 初始化筛选器

 @param frame frame
 @param data 初始数据
 @param type selectorType
 @param delegate delegate
 @return 筛选器
 */
-(instancetype)initWithFrame:(CGRect)frame datas:(NSMutableArray *)data selectorType:(selectorType)type delegate:(id<ClearSelectorViewDelegate>)delegate;



/**
 清理条件数据
 */
+(void)clearData;
@end
