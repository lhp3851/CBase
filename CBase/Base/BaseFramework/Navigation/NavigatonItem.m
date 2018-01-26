//
//  NavigatonItem.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "NavigatonItem.h"


@implementation NavigatonItem

-(void)setLeftItem:(UIBarButtonItem *)leftItem{
    _leftItem = leftItem;
}

-(void)setRightItems:(NSArray<UIBarButtonItem *> *)rightItems{
    _rightItems = rightItems;
}


@end
