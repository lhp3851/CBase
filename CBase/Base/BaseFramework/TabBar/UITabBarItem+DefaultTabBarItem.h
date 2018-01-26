//
//  UITabBarItem+DefaultTabBarItem.h
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITabBarItem (DefaultTabBarItem)
-(__kindof UITabBarItem *)defaultTabBarItem:(NSString *)title WithImage:(NSString *)imageName AndSelectImage:(NSString *)selectImageImageName;
-(__kindof UITabBarItem *)specialTabBarItem:(NSString *)title WithImage:(NSString *)imageName;
-(__kindof UITabBarItem *)defaultTabBarItem:(NSString *)title WithImage:(UIImage*)image selectImage:(UIImage*)selectImage;
@end
