//
//  UIAlertView+Priority.m
//  TMKJ_Merchant
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "UIAlertView+Priority.h"

static const void *priorityKey =&priorityKey;

@implementation UIAlertView (Priority)

- (NSString *)priority{
    return objc_getAssociatedObject(self, priorityKey);
};
- (void)setPriority:(NSString *)priority{
    objc_setAssociatedObject(self, priorityKey, priority, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
