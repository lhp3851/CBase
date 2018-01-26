//
//  KKPromptTool.h
//  StarZone
//
//  Created by WS on 16/3/9.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,KKErrorType) {
    KKErrorTypeNetworkError,
    KKErrorTypeServerError,
};

typedef void(^doSomeBlock)();

@interface KKPromptTool : NSObject

/**
 没有数据视图界面
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @param image  图片或图片名
 @return 没有数据视图界面
 */
+ (UIView *)viewWith:(id)image text:(NSString *)text tap:(doSomeBlock)someBlock;

/**
 网络异常视图界面
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @return 网络异常视图界面
 */
+ (UIView *)viewWith:(KKErrorType)type tap:(doSomeBlock)someBlock;

/**
 显示没有数据视图界面
 
 @param view      添加网络异常视图的视图，一般为控制器的view
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @param image  图片或图片名
 @return 没有数据视图界面
 */
+(UIView *)showInView:(UIView *)view image:(id)image text:(NSString *)text tap:(doSomeBlock)someBlock;


/**
 显示网络异常，点击重新加载
 
 @param view      添加网络异常视图的视图，一般为控制器的view
 @param type      错误类型：KKErrorType
 @param someBlock 触摸/点击事件的block
 @param image  图片或图片名
 @return 网络异常，点击刷新视图
 */
+(UIView *)showInView:(UIView *)view errorWithType:(KKErrorType)type tap:(doSomeBlock)someBlock;


@end
