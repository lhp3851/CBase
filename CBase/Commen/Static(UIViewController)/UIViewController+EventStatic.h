//
//  UIViewController+JerryLiu.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/5/20.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduMobStat.h"
#import "HookUtility.h"

@interface UIViewController (EventStatic)

+ (nullable UIViewController *)topViewController;

+ (nullable UIViewController *)presentedTopViewController;

/** 统计类型 */
@property (nullable,nonatomic, copy) NSString *statisticsType;



@end
