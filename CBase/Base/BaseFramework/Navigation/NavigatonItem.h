//
//  NavigatonItem.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBarItem.h"




@interface NavigatonItem : UINavigationItem

@property(nullable,nonatomic,copy) UIBarButtonItem *leftItem;

@property(nullable,nonatomic,copy) NSArray<UIBarButtonItem *> *rightItems;





@end
