//
//  KKAlert.m
//  TMKJ_Merchant
//
//  Created by mac on 2017/8/18.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "KKAlert.h"
#import "UIAlertView+Priority.h"
#import "KKBlockAlertView.h"
@interface KKAlert ()<UIAlertViewDelegate>

@property (nonatomic, strong) KKBlockAlertView *alertView;
@property (nonatomic, strong) NSMutableArray *blocks;
@property (nonatomic, strong) NSMutableArray *alertViews;

@end

@implementation KKAlert
- (instancetype)alertWithTitle:(NSString *)title mesage:(NSString *)message priority:(AlertControllerPriority)priority cancelButtonTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherTitle
{
    self.priority = priority;
    if (_alertView) {
        //优先级低 直接跳过不弹窗
        if (priority > [_alertView.priority integerValue]) {
            return self;
        }
        //优先级相同 去除上一个alertView
        else if(priority == [_alertView.priority integerValue]){
            [_alertViews removeLastObject];
            [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        }
        //优先级高于
        else{
            [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        }
    }
    _alertView = [[KKBlockAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    _alertView.priority = [NSString stringWithFormat:@"%ld",priority];
    _alertView.tintColor = kNORMAL_BUTTON_COLOR;
    _blocks = [NSMutableArray array];
    _buttonCount = 0;
    _tag = 0;
    self.message = message;
    self.title = title;
    
    [_alertViews addObject:_alertView];
    
    return self;
}

+ (instancetype)shareInstance{
    static KKAlert *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[KKAlert alloc]init];
    });
    return shareInstance;
}
- (id)init{
    if (self = [super init]) {
        
    }
    _alertViews = [NSMutableArray array];
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    if (_alertView) {
        _alertView.title = title;
    }
}
- (void)setMessage:(NSString *)message
{
    _message = message;
    if (_alertView) {
        _alertView.message = message;
    }
}

- (void)showWithShowBlock:(KKAlertClickBlock)showBlock
{
    if (_alertView) {
        if (self.priority == [_alertView.priority integerValue]) {
            __weak typeof(self) weakself = self;
            [_alertView showWithBlock:^(NSInteger buttonIndex) {
                weakself.alertView = nil;
                weakself.priority = 0;
                showBlock(buttonIndex);
            }];
        }
    }
}
- (void)dismissWithClickedButtonIndex:(NSUInteger)index animated:(BOOL)animated
{
    [_alertView dismissWithClickedButtonIndex:index animated:animated];
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
