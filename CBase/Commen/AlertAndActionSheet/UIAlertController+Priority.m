//
//  UIAlertController+Priority.m
//  TMKJ_Merchant
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "UIAlertController+Priority.h"
static const void *priorityKey =&priorityKey;

@implementation UIAlertController (Priority)

@dynamic priority;

- (NSString *)priority{
    return objc_getAssociatedObject(self, priorityKey);
};
- (void)setPriority:(NSString *)priority{
    objc_setAssociatedObject(self, priorityKey, priority, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)presentHeighViewControllerWithPriority:(AlertControllerPriority)priority{
    self.priority =[NSString stringWithFormat:@"%ld",priority];
    if ([[self topViewController] isKindOfClass:[self class]]) {
        UIAlertController * alertController = (UIAlertController *)[self topViewController];
        if (priority != AlertControllerPriorityHeighest && priority >= [alertController.priority integerValue]) {
            return;
        }
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }
    [[self topViewController] presentViewController:self animated:YES completion:nil];
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
