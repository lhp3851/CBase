//
//  KKBlankView.m
//  StarZone
//
//  Created by kankanliu on 2016/11/14.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "KKBlankView.h"

#define kToolBarHeight 44
#define kNavigationBarHight 64

static  EmptyViewBlock block;


@implementation KKBlankView

+ (UIView*)blankViewWithFrame:(CGRect)frame  text:(NSString *)string imageName:(NSString *)imageName{
    UIImage *image = kImageName(imageName);
    UIView *lempty = [[UIView alloc]initWithFrame:frame];
    lempty.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect imageViewframe = CGRectMake((kWINDOW_WIDTH - image.size.width)*0.5, (kWINDOW_HEIGHT-kToolBarHeight-kNavigationBarHight-10)/2-image.size.width/2, image.size.width, image.size.height);
    imageView.frame = imageViewframe;
    imageView.center=CGPointMake(frame.size.width/2, (frame.size.height-image.size.height)/2+26);
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, kWINDOW_WIDTH, 42)];
    promptLabel.textColor = RGBAlphaHex(0x333336, 0.5);
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.lineBreakMode = NSLineBreakByCharWrapping;
    promptLabel.numberOfLines = 0;
    promptLabel.font = [UIFont systemFontOfSize:13];
    promptLabel.text = string;
    [lempty addSubview:imageView];
    [lempty addSubview:promptLabel];
    return lempty;
}

+ (UIView*)blankViewWithFrame:(CGRect)frame  text:(NSString *)string imageName:(NSString *)imageName block:(void(^)())clickBlock{
    UIView *view=nil;
    if (clickBlock) {
        block=clickBlock;
        view= [KKBlankView blankViewWithFrame:frame text:nil imageName:imageName];
        CGRect btnFrame=CGRectMake(15, frame.size.height/2+20, kWINDOW_WIDTH-30, kFitWithHeight(40));
        KKButton *button=[[KKButton alloc]initWithFrame:btnFrame title:string font:kFONT_16 norTitlecolor:kFOURTH_LEVEL_COLOR hlightTitlecolor:kFOURTH_LEVEL_COLOR normalBackgroudColor:kCLEAR_COLOR HilighBackgroudColor:kCLEAR_COLOR cornerRadius:btnFrame.size.height/2 borderWidth:0 borderColor:nil];
        [button addTarget:[KKBlankView class] action:@selector(emptyBlock:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    else{
        block=nil;
        view=[KKBlankView blankViewWithFrame:frame text:string imageName:imageName];
    }
    return view;
}


+ (UIView*)blankViewWithFrame:(CGRect)frame  text:(NSString *)string imageName:(NSString *)imageName toView:(UIView *)view block:(void(^)())clickBlock{
    if (clickBlock) {
        block = clickBlock;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLempthView:)];
        [view addGestureRecognizer:tap];
    }
    else
    {
        block = nil;
    }
    return [self blankViewWithFrame:frame text:string imageName:imageName block:clickBlock];
}


/**
 空视图时界面执行的block

 @param sender sender
 */
+(void)emptyBlock:(id)sender{
    if (block) {
        block();
    }
}


+ (void)tapLempthView:(id)gr{
    UITapGestureRecognizer *tap=(UITapGestureRecognizer *)gr;
    if (block) {
        if (tap.view&&([KKHttpTool getNetWorkStates]!=KKNetWorkStateTypeNone)) {
            [tap.view removeFromSuperview];
            block();
        }
        else
        {
            [KKStarPromptBox showPromptBoxWithWords:kTongMengNetWorkError];
        }
    }
}

@end
