//
//  KKBlockAlertView.h
//  TMKJ_Merchant
//
//  Created by mac on 2017/8/18.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CopletionBlock)(NSInteger buttonIndex);

@interface KKBlockAlertView : UIAlertView

- (void)showWithBlock:(CopletionBlock)copletionBlock;

@end
