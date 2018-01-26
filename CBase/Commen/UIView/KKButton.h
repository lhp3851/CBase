//
//  KKButton.h
//  StarZone
//
//  Created by lhp3851 on 16/2/13.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"

typedef enum : NSUInteger {
    TerminalOperationButtonLock,        //锁定
    TerminalOperationButtonUnLock,      //解锁
    TerminalOperationButtonChangeTicket,//换票
    TerminalOperationButtonAddTicket,   //加票
    TerminalOperationButtondelTicket,   //减票
} TerminalOperationButton;

@interface KKButton : UIButton
/**
 *  性别单选框
 *
 *  @param Frame         Frame
 *  @param selectedImage selected Image
 *  @param normalImage   normal Image
 *  @param selector      button selector
 *
 *  @return 性别单选框
 */
-(instancetype)initWithFrame:(CGRect)Frame SelectedImage:(NSString *)selectedImage NormalImage:(NSString *)normalImage;


/**
 *Created by lfsong on  16/2/13.
 *
 *  UIButton 简单封装
 *
 *  @param frame         frame
 *  @param title         button text
 *  @param font          button text font
 *  @param norcolor      buttonTitile nor color
 *  @param hightcolor    buttonHightTitle color
 *
 *  @return KKButton
 */
-(instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title font:(UIFont *)font norcolor:(UIColor *)norcolor lightcolor:(UIColor *)hightcolor;

/**
 *
 *  UIButton 圆角、背景图
 *
 *  @param frame                frame
 *  @param title                title
 *  @param font                 title font
 *  @param norcolor             titile Normal color
 *  @param hightcolor           title  Hight color
 *  @param normalBackgroudColor normalBackgroudColor
 *  @param HilighBackgroudColor HilighBackgroudColor
 *  @param cornerRadius         cornerRadius
 *  @param borderWidth          borderWidth
 *  @param borderColor          borderColor
 *
 *  @return UIButton
 */
-(instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title font:(UIFont *)font  norTitlecolor:(UIColor *)norcolor hlightTitlecolor:(UIColor *)hightcolor normalBackgroudColor:(UIColor *)normalBackgroudColor HilighBackgroudColor:(UIColor *)HilighBackgroudColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;



/**
  带副标题的按钮

 @param frame frame
 @param title 主标题
 @param subTitle 副标题
 @param font 主标题字体
 @param subFont 副标题字体
 @param norcolor 主标题文字颜色
 @param hightcolor 主标题高亮文字颜色
 @param subTitleColor 副标题文字颜色
 @param normalBackgroudColor 按钮背景色
 @param HilighBackgroudColor 按钮高亮背景色
 @param cornerRadius 圆角
 @param borderWidth 边框宽度
 @param borderColor 边线颜色
 @return  带副标题的按钮
 */
-(instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title subTitle:(NSString *)subTitle font:(UIFont *)font subTitleFont:(UIFont *)subFont norTitlecolor:(UIColor *)norcolor hlightTitlecolor:(UIColor *)hightcolor subTitleColor:(UIColor *)subTitleColor  normalBackgroudColor:(UIColor *)normalBackgroudColor HilighBackgroudColor:(UIColor *)HilighBackgroudColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


-(instancetype)initWithFrame:(CGRect)frame leftFont:(UIFont *)leftFont rightFont:(UIFont *)rightFont leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor;

-(instancetype)initWithFrame:(CGRect)frame leftFont:(UIFont *)leftFont rightFont:(UIFont *)rightFont leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor isCenter:(BOOL)isCenter;

//考虑一个设置edgeInset的

//设置图片在button中的位置
-(void)setImageRectForBounds:(CGRect)rect;

//设置title在button中的位置
-(void)setTitleRectForBounds:(CGRect)rect;

-(void)setText:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

/**
 根据操作获取终端操作按钮

 @param type 操作类型
 @return 按钮
 */
+(KKButton *)getButtonWithButtonType:(TerminalOperationButton)type;
@end


@interface KKStarCustomButton : UIButton

@end

