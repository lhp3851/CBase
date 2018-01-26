//
//  KKTextField.h
//  StarZone
//
//  Created by 宋林峰 on 16/2/17.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, UITextFieldSideViewStyle){
    UITextFieldSideViewStyleLeft = 1 << 0, //左边
    
    UITextFieldSideViewStyleRight = 1 << 1, //右边
    
    UITextFieldSideViewStyleLeftAndRight =UITextFieldSideViewStyleLeft|UITextFieldSideViewStyleRight //两边
};



@protocol KKTextFieldDelegate <NSObject>

-(void)passwordEncrypt:(KKButton *)button;

@end


@interface KKTextField : UITextField

@property (nonatomic,strong)id <KKTextFieldDelegate> textDelegate;

@property (nonatomic,assign)UITextFieldSideViewStyle sideViewStyle;


-(instancetype)initWithSideStyle:(UITextFieldSideViewStyle)style placeholder:(NSString *)placeholder sideImage:(NSArray <NSString *> *)imageNames;




/**
 *  KKTextField 简单封装
 *
 *  @param frame         frame
 *  @param text          text
 *  @param placeholder          placeholder
 *  其它属性为产品的默认值
 *
 *  @return KKTextField
 */
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text placeholder:(NSString *)placeholder;

/**
 *  KKTextField 简单封装
 *
 *  @param frame         frame
 *  @param text          text
 *  @param placeholder          placeholder
 *  @param color         text color
 *  @param font          text font
 *  @param borderStyle     输入框边框类型
 *  @param keyBoardType    键盘类型
 *  @param returnKey      键盘返回类型
 *
 *  @return KKTextField
 */
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text placeholder:(NSString *)placeholder font:(UIFont *)font color:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle keyboardType:(UIKeyboardType)keyBoardType returnKey:(UIReturnKeyType)returnKey;


/**
 *  设置默认的数字键盘
 *  黑认值类型为UIKeyboardTypeDecimalPad
 */
-(void)setNumberKeyBoard;


/**
 *  设置数字键盘
 *
 *  @param boardType    键盘类型
 *
 */
-(void)setNumberKeyBoardType:(UIKeyboardType)boardType;

@end
