//
//  LineView.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/7.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "LineView.h"

@interface LineView ()



@end

@implementation LineView

+(instancetype)shareInstance{
    static LineView *line = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        line = [LineView new];
    });
    return line;
}


+(instancetype)getLineWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = {CGPointZero, size};
    UIView *line =  [[UIView alloc]initWithFrame:rect];
    line.backgroundColor = color;
    return (LineView *)line;
}



-(UIView *)verticalLine{
    _verticalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1.5f, 10.0f)];
    _verticalLine.backgroundColor = kNORMAL_BUTTON_COLOR;
    return _verticalLine;
}

-(UIView *)horizonLine{
    _horizonLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWINDOW_WIDTH-4*kHORIZONT_MARGIN, 0.5f)];
    _horizonLine.backgroundColor = kDISABLE_BUTTON_COLOR;
    return _horizonLine;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
