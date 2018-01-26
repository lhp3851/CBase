//
//  UITabBar+KKStar.m
//  StarZone
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "UITabBar+KKStar.h"

@implementation UITabBar (KKStar)
-(instancetype)DefaultTabBar{
    UITabBarItem *shareTabBarItem=[UITabBarItem appearance];
    
    UITabBarItem *item =[shareTabBarItem defaultTabBarItem:@"默认标题"  WithImage:@"inCome" AndSelectImage:@"outgo"];
    
    UITabBarItem *item1=[shareTabBarItem defaultTabBarItem:@"默认标题1" WithImage:@"inCome" AndSelectImage:@"outgo"];
    
    UITabBarItem *item2=[shareTabBarItem defaultTabBarItem:@"默认标题2" WithImage:@"inCome" AndSelectImage:@"outgo"];
    
    UITabBar *defaultTabBar=[UITabBar appearance];
    defaultTabBar.items=@[item,item1,item2];
    
    return defaultTabBar;
}
@end
