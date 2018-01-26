//
//  LineView.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/7.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LineViewStyleVertical,
    LineViewStyleHorizon,
} LineViewStyle;

@interface LineView : UIView

@property(nonatomic,strong)UIView *verticalLine;
@property(nonatomic,strong)UIView *horizonLine;

+(instancetype)shareInstance;

/**
 线条

 @param style 线条样式
 @param color 线条颜色
 @param size  线条size
 @return 线条
 */
+(instancetype)getLineWithColor:(UIColor *)color size:(CGSize)size;

@end
