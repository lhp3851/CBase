//
//  UIWindow+Extension.h


#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "NavigationViewController.h"
#import "BaseViewController.h"

@interface UIWindow (Extension)
/**
 *  切换根视图控制器
 */
+ (void)changeRootViewControllerWithViewController:(BaseViewController *)viewController;

/**
 切换导航控制器

 @param viewController 目标导航控制器
 */
+ (void)changeRootViewControllerWithNavigationController:(NavigationViewController *)viewController;

/**
 *  切换根控制器
 */
+ (void)changeRootViewControllerWithTabBarController:(TabBarViewController *)viewController;

/**
 当前window

 @return 非模态的当前窗口
 */
+(UIWindow *)topWindow;


/**
 APP 的所有Windows

 @return Windows
 */
+(NSArray<__kindof UIWindow *>*)windows;
@end
