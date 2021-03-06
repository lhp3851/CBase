//
//  UIApplication+App.m
//  StarZone
//
//  Created by LiuXuan on 2017/2/8.
//  Copyright © 2017年 xiangChaoKanKan. All rights reserved.
//

#import "UIApplication+App.h"
#import <objc/runtime.h>

@implementation UIApplication (App)

@dynamic appName,appVersion;

static void *appNameKey=&appNameKey;


-(NSString *)appName{
    NSDictionary *infoDic=[[NSBundle mainBundle]infoDictionary];
    NSString *appName=infoDic[@"CFBundleDisplayName"];
    objc_setAssociatedObject(self, &appNameKey, appName, OBJC_ASSOCIATION_COPY);

    return objc_getAssociatedObject(self, &appNameKey);
}

//一般不能调用
static void *appVersionKey=&appVersionKey;


-(NSString *)appVersion{
    NSDictionary *infoDic=[[NSBundle mainBundle]infoDictionary];
    NSString *appVer=infoDic[@"CFBundleShortVersionString"];
    objc_setAssociatedObject(self, &appVersionKey, appVer, OBJC_ASSOCIATION_COPY);

    return objc_getAssociatedObject(self, &appVersionKey);
}
@end
