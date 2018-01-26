//
//  UINavigationBar+UINavigationBar.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/8/22.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "UINavigationBar+UINavigationBar.h"

@implementation UINavigationBar (UINavigationBar)

//+(void)load{
//    [self initialize];
//}
//
//-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setBarTintColor:kNORMAL_BUTTON_COLOR];//设置导航栏颜色
//        self.titleTextAttributes = @{NSForegroundColorAttributeName:kBACKGROUND_COLOR,NSFontAttributeName:kFONT_17};
//        [self setTranslucent:NO];//不带透明度
//        [self setBarStyle:UIBarStyleBlack];//设置状态栏文字白色
//        
//        UIImage *backButtonImage = [[UIImage imageNamed:@"nav_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0) resizingMode:UIImageResizingModeTile];
//        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTarget:)];
//        tap.delegate = self;
//        [[UINavigationBar appearance] addGestureRecognizer:tap];
//    }
//    return self;
//}
//
//-(void)tapTarget:(id)sender{
//    Print(@"UINavigationBar category:%@",NSStringFromClass([self class]));
//}


@end
