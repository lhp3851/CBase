//
//  KKPromptTool.m
//  StarZone
//
//  Created by WS on 16/3/9.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "KKPromptTool.h"

static doSomeBlock doSome;

@implementation KKPromptTool


+ (void)tapLempthView:(id)gr{
    UITapGestureRecognizer *tap=(UITapGestureRecognizer *)gr;
    if (doSome) {
        if (tap.view&&([KKHttpTool getNetWorkStates]!=KKNetWorkStateTypeNone)) {
            [tap.view removeFromSuperview];
            doSome();
        }
        else
        {
            [KKStarPromptBox showPromptBoxWithWords:kTongMengNetWorkError];
        }
    }
}

/**
 没有数据视图界面
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @param image  图片或图片名
 @return 没有数据视图界面
 */
+ (UIView *)viewWith:(id)image text:(NSString *)text tap:(doSomeBlock)someBlock
{
    UIImage *tImage = nil;
    if ([image isKindOfClass:[UIImage class]]) {
        tImage = image;
    }
    else if([image isKindOfClass:[NSString class]])
    {
        tImage = kImageName(image);
    }
    
    UIView *lempty = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWINDOW_WIDTH, tImage.size.height*2)];
    lempty.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:tImage];
    CGRect frame = CGRectMake((kWINDOW_WIDTH - tImage.size.width)*0.5, 0, tImage.size.width, tImage.size.height);
    imageView.frame = frame;
    
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 20, kWINDOW_WIDTH, 20)];
    promptLabel.textColor = RGBAlphaHex(0x333336, 0.5);
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.text = text;
    
    [lempty addSubview:imageView];
    [lempty addSubview:promptLabel];
    
    if (someBlock) {
        doSome = someBlock;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLempthView:)];
        [lempty addGestureRecognizer:tap];
    }
    else
    {
        doSome = nil;
    }
    return lempty;
}

/**
 网络异常视图界面
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @return 网络异常视图界面
 */
+(UIView *)viewWith:(KKErrorType)type tap:(doSomeBlock)someBlock{
    NSString *imageName,*text;
    switch (type) {
        case KKErrorTypeNetworkError:{
            imageName = @"no_data_icon";
            text=@"网络无法连接，点击重新加载";
        }
            break;
        case KKErrorTypeServerError: // 服务器异常
        {
            imageName = @"no_data_icon";
            text=@"服务器无法连接，点击重新加载";
        }
            break;
        default:
            break;
    }
    return  [self viewWith:imageName text:text tap:someBlock];
}

/**
 显示没有数据视图界面
 
 @param view      添加网络异常视图的视图，一般为控制器的view
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @param image  图片或图片名
 @return 没有数据视图界面
 */
+(UIView *)showInView:(UIView *)view image:(id)image text:(NSString *)text tap:(doSomeBlock)someBlock
{
    if (!view) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
    bgView.backgroundColor = kBACKGROUND_COLOR;
    [view addSubview:bgView];
    UIView *subView = [self viewWith:image text:text tap:nil];
    subView.userInteractionEnabled = NO;
    subView.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [bgView addSubview:subView];
    if (someBlock) {
        doSome = someBlock;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLempthView:)];
        [bgView addGestureRecognizer:tap];
    }
    else
    {
        doSome = nil;
    }
    return bgView;
}


/**
 显示网络异常，点击重新加载
 
 @param view      添加网络异常视图的视图，一般为控制器的view
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @param image  图片或图片名
 @return 网络异常，点击刷新视图
 */
+(UIView *)showInView:(UIView *)view errorWithType:(KKErrorType)type tap:(doSomeBlock)someBlock
{
    if (!view) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
    bgView.backgroundColor = kBACKGROUND_COLOR;
    [view addSubview:bgView];
    UIView *subView = [self viewWith:type tap:nil];
    subView.userInteractionEnabled = NO;
    subView.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);;
    [bgView addSubview:subView];
    if (someBlock) {
        doSome = someBlock;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLempthView:)];
        [bgView addGestureRecognizer:tap];
    }
    else
    {
        doSome = nil;
    }
    return bgView;
}

@end
