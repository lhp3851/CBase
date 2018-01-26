//
//  BaseViewController.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBarItem.h"

@interface BaseViewController : UIViewController


/**
 跳转页面

 @param sourceViewController 开始跳转的页面
 @param toViewController 跳转的目的页面
 */
+(void)jumpFromSourceViewController:(UIViewController *)sourceViewController  ToViewController:(UIViewController *)toViewController;


-(void)popViewController;

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;

@end
