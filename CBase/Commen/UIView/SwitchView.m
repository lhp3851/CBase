//
//  SwitchView.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/13.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "SwitchView.h"

@implementation SwitchView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.onTintColor = kNORMAL_BUTTON_COLOR;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andIndexPath:(NSIndexPath *)indexPath{
    self = [super initWithFrame:frame];
    if (self) {
        self.indexPath = indexPath;
    }
    return [self initWithFrame:frame];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
