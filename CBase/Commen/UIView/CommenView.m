//
//  CommenView.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/17.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "CommenView.h"

@implementation CommenView

+(instancetype)shareInstance{
    static CommenView *view = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        view = [CommenView new];
    });
    return view;
}


-(KKImageView *)arrowImageView{
    
    _arrowImageView = [[KKImageView alloc]initWithImage:kImageName(@"entry_icon")];
    
    return _arrowImageView;
}


-(KKButton *)longButton{
    CGRect frame = CGRectMake(kHORIZONT_MARGIN, [KKFitTool fitWithHeight:45], kWINDOW_WIDTH - 2*kHORIZONT_MARGIN, kDEFAULT_BUTTON_HEIGHT);
    _longButton = [[KKButton alloc]initWithFrame:frame title:@"" font:kFONT_16 norTitlecolor:kNORMAL_BUTTON_TITLE_COLOR hlightTitlecolor:kHILIGHT_BUTTON_TITLE_COLOR normalBackgroudColor:kNORMAL_BUTTON_COLOR HilighBackgroudColor:kHILIGHT_BUTTON_COLOR cornerRadius:3.0f borderWidth:0 borderColor:nil];
    return _longButton;
}

-(KKLabel *)longLabel{
    CGRect frame = CGRectMake(kHORIZONT_MARGIN, [KKFitTool fitWithHeight:45], kWINDOW_WIDTH - 2*kHORIZONT_MARGIN, kDEFAULT_BUTTON_HEIGHT);
    _longLabel = [[KKLabel alloc]initWithFrame:frame text:@"" color:kTHIRD_LEVEL_COLOR font:kFONT_12 alignment:NSTextAlignmentCenter];
    return  _longLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
