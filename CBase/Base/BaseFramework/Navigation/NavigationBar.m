//
//  NavigationBar.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:kNORMAL_BUTTON_COLOR];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
