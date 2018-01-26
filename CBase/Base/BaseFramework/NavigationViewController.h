//
//  NavigationViewController.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popViewDelegate <NSObject>

-(void)popViewController;

@end

@interface NavigationViewController : UINavigationController

@property(nonatomic,assign)id<popViewDelegate> popDelegate;

@end
