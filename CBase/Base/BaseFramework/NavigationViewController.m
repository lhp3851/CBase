//
//  NavigationViewController.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "NavigationViewController.h"
#import "NavigationBar.h"
#import "NavigationBarItem.h"
#import "UINavigationBar+UINavigationBar.h"

@interface NavigationViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSMutableArray *viewControlleres;

@end

@implementation NavigationViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPanel];
}

-(void)initPanel{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:kNORMAL_BUTTON_COLOR];//设置导航栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kBACKGROUND_COLOR,NSFontAttributeName:kFONT_17};
    [navigationBar setTranslucent:NO]; //不带透明度
    [navigationBar setBarStyle:UIBarStyleBlack];//设置状态栏文字白色
    
    
//    UIBarButtonItem *backItem = [UIBarButtonItem appearance];
//    UIImage *backButtonImage = [[UIImage imageNamed:@"nav_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
//    [backItem setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [backItem setBackButtonTitlePositionAdjustment:UIOffsetMake(2.5, 0) forBarMetrics:UIBarMetricsDefault];
    
}

-(void)popViewController{
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
