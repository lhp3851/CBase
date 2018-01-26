//
//  UIViewController+JerryLiu.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/5/18.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "UIViewController+EventStatic.h"
#import "UIWindow+Extension.h"

#define ViewControllerName NSStringFromClass([self class])

@implementation UIViewController (EventStatic)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(swizzing_viewDidAppear:);
        if (originalSelector) {
            [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        }
        
        SEL originalDisSelector = @selector(viewDidDisappear:);
        SEL swizzledDisSelector = @selector(swizzing_viewDidDisppear:);
        if (originalDisSelector) {
            [HookUtility swizzlingInClass:[self class] originalSelector:originalDisSelector swizzledSelector:swizzledDisSelector];
        }
    });
}
/**
 当前试图控制器
 
 @return 当前试图控制器
 */
+(UIViewController *)topViewController{
    UIViewController *result = nil;
    UIWindow * keyWindow=[UIWindow topWindow];
    NSArray *viewes= [keyWindow subviews];
    UIView *frontView = [viewes objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = keyWindow.rootViewController;
    
    return result;
}

/**
 当前试图控制器(模态)
 
 @return 当前试图控制器(模态)
 */
+ (UIViewController *)presentedTopViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@dynamic statisticsType;
static const char KKEventTypeKey = '\0';
- (void)setStatisticsType:(NSString *)statisticsType {
    objc_setAssociatedObject(self, &KKEventTypeKey, statisticsType, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)statisticsType {
    return objc_getAssociatedObject(self, &KKEventTypeKey);
}

#pragma mark - Method Swizzling
- (void)swizzing_viewDidAppear:(BOOL)animated
{
    [self inject_ViewDidAppear];
    [self swizzing_viewDidAppear:animated];
}

-(void)swizzing_viewDidDisppear:(BOOL)animated{
    [self inject_ViewDidDisappear];
    [self swizzing_viewDidDisppear:animated];
}


/**
 viewDidAppear 注入的代码
 */
-(void)inject_ViewDidAppear{
    [[BaiduMobStat defaultStat] pageviewStartWithName:ViewControllerName];
}

/**
 viewDidDisappear 注入的代码
 */
-(void)inject_ViewDidDisappear{
    [[BaiduMobStat defaultStat] pageviewEndWithName:ViewControllerName];
}

#pragma mark 获取视图控制器事件变量
- (NSString *)eventPageViewController:(BOOL)EnterPage
{
    NSString *selfClassName = NSStringFromClass([self class]);
    NSString *pageEventID = nil;
    if ([selfClassName isEqualToString:@"ViewController"]) {
        pageEventID = EnterPage ? @"EVENT_HOMEPAGE" : @"LEAVE_HOME_PAGE";
    }
    else if ([selfClassName isEqualToString:@"FeedbackViewController"]) {
        pageEventID = EnterPage ? @"EVENT_DETAIL_PAGE" : @"LEAVE_DETAIL_PAGE";
    }
    else{
        pageEventID = EnterPage ?@"EVENT_NEWPAGEVC":@"LEAVE_NEWPAGEVC";
    }
    return pageEventID;
}

@end
