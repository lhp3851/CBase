//
//  TabBarViewController.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/5.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TabViewControllerHomePage,  //首页
    TabViewControllerTerminal,  //终端
    TabViewControllerSales,     //销售
    TabViewControllerOrder,     //订单
    TabViewControllerSetting    //我的-设置
} TabViewController;


//-(void)shouldRefreshTabBarController;

@interface TabBarViewController : UITabBarController

@end
