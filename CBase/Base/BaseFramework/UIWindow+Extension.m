
//
//  UIWindow+Extension.m


#import "UIWindow+Extension.h"
#import "BaseViewController.h"

#define kBundleV @"CFBundleVersion"
#define backGroundImageURL           @"backGroundImageURL"
#define expireDateOfHomePage         @"expireDate"
#define jumpOver                     @"jumpOver"
#define BizNo                        @"BizNo"
@implementation UIWindow (Extension)

+(UIWindow *)topWindow{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    NSArray *windowes = [[UIApplication sharedApplication] windows];
    
    if (window == nil &&windowes.count>0) {
        window = windowes.lastObject;
        return window;
    }
    
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

+(NSArray<__kindof UIWindow *>*)windows{
    return [[UIApplication sharedApplication] windows];
}

+ (void)changeRootViewControllerWithTabBarController:(TabBarViewController *)viewController{
    UIWindow *topWindow = [UIWindow topWindow];
    topWindow.rootViewController = viewController;
}

+ (void)changeRootViewControllerWithNavigationController:(NavigationViewController *)viewController{
    UIWindow *topWindow = [UIWindow topWindow];
    topWindow.rootViewController = viewController;
}

+ (void)changeRootViewControllerWithViewController:(BaseViewController *)viewController{
    UIWindow *topWindow = [UIWindow topWindow];
    topWindow.rootViewController = viewController;
}

@end
