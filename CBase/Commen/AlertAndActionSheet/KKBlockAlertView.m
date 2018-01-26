//
//  KKBlockAlertView.m
//  TMKJ_Merchant
//
//  Created by mac on 2017/8/18.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "KKBlockAlertView.h"

@interface KKBlockAlertView ()

@property (nonatomic, copy) CopletionBlock copletionBlock;

@end

@implementation KKBlockAlertView

- (void)showWithBlock:(CopletionBlock)copletionBlock {
    if (copletionBlock) {
        self.copletionBlock = copletionBlock;
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.copletionBlock) {
        self.copletionBlock(buttonIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
