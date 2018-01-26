//
//  TabBarViewController.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/5.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationViewController.h"
#import "HomePageViewController.h"
#import "StudyViewController.h"
#import "NewsViewController.h"
#import "CommercialViewController.h"
#import "SettingViewController.h"

#import "UITabBar+KKStar.h"
#import "NavigationBarItem.h"

#import "QRCodeViewController.h"
#import "MessageViewController.h"
#import "SearchViewController.h"
#import "AccountModel.h"

@interface TabBarViewController ()<NavigationBardelegate,popViewDelegate,UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setContr];
    [self setDefaultTabBar];
}

-(void)setContr{
    MessageViewController *homePageVC = [MessageViewController new];
    NavigationViewController *homePageNav = [[NavigationViewController alloc]initWithRootViewController:homePageVC];
    homePageNav.popDelegate = homePageVC;

    StudyViewController *studyVC = [StudyViewController new];
    NavigationViewController *studyNav = [[NavigationViewController alloc]initWithRootViewController:studyVC];
   
    
    NewsViewController *newsVC = [NewsViewController new];
    NavigationViewController *NewsNav = [[NavigationViewController alloc]initWithRootViewController:newsVC];
   
    
    CommercialViewController *commerceVC = [CommercialViewController new];
    NavigationViewController *commerceNav = [[NavigationViewController alloc]initWithRootViewController:commerceVC];
   
    
    SettingViewController *settingVC = [SettingViewController new];
    NavigationViewController *settingNav = [[NavigationViewController alloc]initWithRootViewController:settingVC];
   
    self.viewControllers = @[homePageNav, studyNav, NewsNav, commerceNav,settingNav];
}

-(void)setDefaultTabBar{
    UITabBar *defaultTabBar=self.tabBar;
    defaultTabBar.barTintColor=[UIColor whiteColor];
    defaultTabBar.translucent = NO;
    
    defaultTabBar.shadowImage = [UIImage solidImageWithColor:[UIColor colorWithRGBValue:0xe5e5e5 alpha:1.0] size:CGSizeMake(1, 1 / [UIScreen mainScreen].scale)];
    defaultTabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    UITabBarItem *headLineItem=defaultTabBar.items[0];
    [headLineItem defaultTabBarItem:NSLocalizedString(@"首页",nil) WithImage:@"home_icon_normal" AndSelectImage:@"home_icon_select"];
    
    
    UITabBarItem *liveItem    =defaultTabBar.items[1];
    [liveItem defaultTabBarItem:NSLocalizedString(@"学习",nil) WithImage:@"terminal_icon_normal" AndSelectImage:@"terminal_icon_select"];
    
    UITabBarItem *homePageItem=defaultTabBar.items[2];
    [homePageItem defaultTabBarItem:NSLocalizedString(@"资讯",nil) WithImage:@"sell_icon_normal" AndSelectImage:@"sell_icon_select"];
    
    
    UITabBarItem *feedBackItem=defaultTabBar.items[3];
    [feedBackItem defaultTabBarItem:NSLocalizedString(@"商业",nil) WithImage:@"order_icon_normal" AndSelectImage:@"order_icon_select"];
    
    UITabBarItem *userInfoItem=defaultTabBar.items[4];
    [userInfoItem defaultTabBarItem:NSLocalizedString(@"我的",nil) WithImage:@"mine_icon_normal" AndSelectImage:@"mine_icon_select"];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NavigationViewController *navVC = (NavigationViewController*)viewController;
    BaseViewController *baseVC = (BaseViewController *)navVC.topViewController;
    if (baseVC && [baseVC respondsToSelector:@selector(shouldRefreshTabBarController)]) {
        [baseVC performSelector:@selector(shouldRefreshTabBarController)];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
