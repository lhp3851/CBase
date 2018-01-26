//
//  KKBlankView.h
//  StarZone
//
//  Created by kankanliu on 2016/11/14.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^doSomeBlock)();

@interface KKBlankView : UIView

typedef void(^EmptyViewBlock)();

/**
 空页面
 @param frame  视图的frame
 @param string 显示的文字
 @param imageName 显示的图片
 @return 空数据视图
 */
+ (UIView*)blankViewWithFrame:(CGRect)frame  text:(NSString *)string imageName:(NSString *)imageName;

/**
 空页面
 @param frame  视图的frame
 @param string 显示的文字
 @param imageName 显示的图片
 @param clickBlock 页面按钮点击事件
 @return 空数据视图
 */
+ (UIView*)blankViewWithFrame:(CGRect)frame  text:(NSString *)string imageName:(NSString *)imageName block:(void(^)())clickBlock;


/**
 空页面

 @param frame 视图的frame
 @param string 显示的文字
 @param imageName 显示的图片的名字
 @param view 父视图
 @param clickBlock 操作的block
 @return 空数据视图
 */
+ (UIView*)blankViewWithFrame:(CGRect)frame  text:(NSString *)string imageName:(NSString *)imageName toView:(UIView *)view block:(void(^)())clickBlock;
@end
