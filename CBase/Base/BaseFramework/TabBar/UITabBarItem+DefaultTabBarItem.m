//
//  UITabBarItem+DefaultTabBarItem.m
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "UITabBarItem+DefaultTabBarItem.h"

@implementation UITabBarItem (DefaultTabBarItem)
-(__kindof UITabBarItem *)defaultTabBarItem:(NSString *)title WithImage:(NSString *)imageName AndSelectImage:(NSString *)selectImageImageName{
    UIImage *image=[kImageName(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage=[kImageName(selectImageImageName)imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self setTitle:title];
    [self setImage:image];
    [self setSelectedImage:selectImage];
    [self setTitleTextAttributes:@{ NSForegroundColorAttributeName:RGBHex(0x888888)} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{ NSForegroundColorAttributeName:kNORMAL_BUTTON_COLOR} forState:UIControlStateSelected];
    [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return self;
}
-(__kindof UITabBarItem *)defaultTabBarItem:(NSString *)title WithImage:(UIImage*)image selectImage:(UIImage*)selectImage{
    [self setTitle:title];
    [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self setSelectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self setTitleTextAttributes:@{ NSForegroundColorAttributeName:RGBHex(0x888888)} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{ NSForegroundColorAttributeName:RGBHex(0x333336)} forState:UIControlStateSelected];
    [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return self;
}
-(__kindof UITabBarItem *)specialTabBarItem:(NSString *)title WithImage:(NSString *)imageName{
    UIImage *image=[kImageName(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self setTitle:title];
    [self setImage:image];
    [self setSelectedImage:image];
    [self setTitleTextAttributes:@{ NSForegroundColorAttributeName:kNORMAL_BUTTON_COLOR} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{ NSForegroundColorAttributeName:kHILIGHT_BUTTON_COLOR} forState:UIControlStateSelected];
    [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return self;
}

@end
