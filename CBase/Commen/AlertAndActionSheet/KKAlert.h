//
//  KKAlert.h
//  TMKJ_Merchant
//
//  Created by mac on 2017/8/18.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, AlertControllerPriority){
    AlertControllerPriorityHeighest               =3,
    AlertControllerPriorityGenary                 =4,
    AlertControllerPriorityBad                    =5,
    AlertControllerPriorityLowest                 =6,
};

typedef void (^KKAlertClickBlock)(NSInteger buttonIndex);

@interface KKAlert : NSObject
@property (nonatomic, assign, readonly) NSUInteger buttonCount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger tag;
//用于判断是否需要加载show
@property (nonatomic, assign)  AlertControllerPriority priority;

- (instancetype)alertWithTitle:(NSString *)title mesage:(NSString *)message priority:(AlertControllerPriority)priority cancelButtonTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherTitle;
+ (instancetype)shareInstance;

- (void)showWithShowBlock:(KKAlertClickBlock)showBlock;
- (void)dismissWithClickedButtonIndex:(NSUInteger)index animated:(BOOL)animated;
@end
