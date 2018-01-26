//
//  UIAlertController+Priority.h
//  TMKJ_Merchant
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef NS_ENUM(NSInteger, AlertControllerPriority){
//    AlertControllerPriorityHeighest               =3,
//    AlertControllerPriorityGenary                 =4,
//    AlertControllerPriorityLowest                 =5,
//};
@interface UIAlertController (Priority)

@property (nonatomic,strong)NSString * priority;

- (void)presentHeighViewControllerWithPriority:(AlertControllerPriority)priority;

@end
