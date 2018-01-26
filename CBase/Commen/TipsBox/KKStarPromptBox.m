//
//  KKStarPromptBox.m
//  KKStarZone
//
//  Created by TinySail on 16/1/12.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "KKStarPromptBox.h"
#define kPromptBoxCornerRadius 0.0
#define kPromptWordFontSize 15.0
#define kPromptWordMargin   0.0
#define kPromptBoxBackGroundColor [UIColor colorWithRGBValue:0x000000 alpha:0.7]
#ifndef kTopWindow
#define kTopWindow [[UIApplication sharedApplication].windows lastObject]
#endif
@interface KKStarPromptBox ()



@end

static BOOL isPrompting=NO;

@implementation KKStarPromptBox
+ (void)showPromptBoxWithWords:(NSString *)words
{
    [self showPromptBoxWithWords:words toView:nil];
}
+ (void)showPromptBoxWithWords:(NSString *)words toView:(UIView *)view
{
//    [self showPromptBoxWithWords:words icon:nil toView:view];
    [self showTMWLPromptBoxWithWords:words icon:nil toView:view];
}
+ (void)showPromptBoxWithWords:(NSString *)words icon:(UIImage *)icon
{
//    [self showPromptBoxWithWords:words icon:icon toView:nil];
    [self showTMWLPromptBoxWithWords:words icon:icon toView:nil];
}
+ (void)showPromptBoxWithWords:(NSString *)words icon:(UIImage *)icon toView:(UIView *)view
{
    if (!words.length) return;
    if (![[NSThread currentThread] isMainThread]) {
        return;
    }
    isPrompting=YES;
    if (view == nil) view = kApp_Window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    [self rotateHud:hud];
    
    hud.detailsLabelText = words;
    hud.detailsLabelFont = [KKFitTool fitWithTextHeight:kPromptWordFontSize];
    hud.detailsLabelColor = kBACKGROUND_COLOR;
    hud.color = kWARNING_COLOR;
    hud.yOffset = -kWINDOW_HEIGHT/2+ kSTATUS_BAR_HEIGHT*2;
    hud.xOffset = 0;
    hud.cornerRadius = kPromptBoxCornerRadius;
    hud.margin = [KKFitTool fitWithWidth:kPromptWordMargin];

    // 设置图片
//    hud.customView =[[UIImageView alloc] initWithImage:icon];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
//    [hud hide:YES afterDelay:kPromptBoxRemainTime];
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kPromptBoxRemainTime*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       isPrompting=NO;
   });
}


+ (void)showTMWLPromptBoxWithWords:(NSString *)words icon:(UIImage *)icon toView:(UIView *)view
{
    if (!words.length) return;
    if (![[NSThread currentThread] isMainThread]) {
        return;
    }
    isPrompting=YES;
    if (view == nil) view = kApp_Window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.margin = [KKFitTool fitWithWidth:kPromptWordMargin];
    
    
    [self rotateHud:hud];
    
    KKLabel *label = [[KKLabel alloc]init];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 2.5f;
    style.headIndent = style.firstLineHeadIndent = 10;
    NSDictionary *attrDic = @{NSForegroundColorAttributeName:kBACKGROUND_COLOR,
                              NSFontAttributeName           :kFONT_15,
                              NSParagraphStyleAttributeName :style
                              };
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:words attributes:attrDic];
    
    CGSize wordSize = [words resizeWithFont:kFONT_15 lineSpace:2.5f adjustSize:CGSizeMake(kWINDOW_WIDTH -2*kHORIZONT_MARGIN, kWINDOW_HEIGHT - 2*kSTATUS_BAR_HEIGHT)];
    CGFloat verticalMargin = 15.0f;
    [label setFrame:CGRectMake(0, 0, kWINDOW_WIDTH, wordSize.height+verticalMargin)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByClipping;
    label.backgroundColor = kWARNING_COLOR;
    label.attributedText = attrString;
    hud.customView =label;
    hud.yOffset    = -view.frame.size.height/2+ label.frame.size.height/2 + ([view isEqual:kApp_Window]?kSTATUS_BAR_HEIGHT:0);//相对于父视图的中心的偏移量
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:kPromptBoxRemainTime];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kPromptBoxRemainTime*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        isPrompting=NO;
    });
}



+ (void)rotateHud:(MBProgressHUD *)hud
{
    UIInterfaceOrientation interfaceO = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat rotateAngle = 0;
    switch (interfaceO) {
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI_2;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI;
            break;
        default:
            break;
    }
    if (rotateAngle != 0) {
        hud.transform = CGAffineTransformMakeRotation(rotateAngle);
    }
}

+ (KKStarPromptBox *)showPrompttingBoxWithWords:(NSString *)words
{
    return [self showPrompttingBoxWithWords:words toView:nil];
}
+ (KKStarPromptBox *)showPrompttingBoxWithWords:(NSString *)words toView:(UIView *)view
{
    //if (!words.length) return nil;
    if (![[NSThread currentThread] isMainThread]) {
        return nil;
    }
    if (view == nil) view = kApp_Window;
    isPrompting=YES;
    // 快速显示一个提示信息
    KKStarPromptBox *hud = [KKStarPromptBox showHUDAddedTo:view animated:YES];
    [self rotateHud:hud];
    hud.labelText = words;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    hud.color = kPromptBoxBackGroundColor;
    hud.margin = [KKFitTool fitWithWidth:kPromptWordMargin];
    //    hud.activityIndicatorColor = [UIColor redColor];
    return hud;
}

- (void)hidePrompttingBox
{
    [self hide:YES];
    isPrompting=NO;
}

+ (void)hidePrompttingBoxs
{
    [self hidePrompttingBoxsForView:nil];
    isPrompting=NO;
}

+ (void)hidePrompttingBoxsForView:(UIView *)view
{
    if (view == nil) view = kApp_Window;
    [self hideAllHUDsForView:view animated:YES];
    isPrompting=NO;
}

+ (BOOL)isPrompting{
    return isPrompting;
}

@end
