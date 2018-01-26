//
//  KKTextField.m
//  StarZone
//
//  Created by 熊梦飞 on 16/2/17.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "KKTextField.h"

@interface KKTextField ()

@property(nonatomic,strong)UIView *sideBackView;

@property(nonatomic,strong)KKButton *leftButtonView;

@property(nonatomic,strong)KKButton *rightButtonView;

@property(nonatomic,strong)NSArray <NSString *>* sideImages;

@end


@implementation KKTextField

-(UIView *)sideBackView{
    CGPoint point = {0,0};
    CGSize  size  = {32,20};
    CGRect backViewRect = {point,size};
    _sideBackView = [[UIView alloc]initWithFrame:backViewRect];
    return _sideBackView;
}

-(KKButton *)leftButtonView{
    CGPoint point = {2,2};
    CGSize  size  = {16,16};
    CGRect  rect  = {point,size};
    _leftButtonView = [[KKButton alloc]initWithFrame:rect] ;
    return _leftButtonView;
}

-(KKButton *)rightButtonView{
    CGPoint point = {0,2};
    CGSize  size = {16,16};
    CGRect  rect = {point,size};
    _rightButtonView = [[KKButton alloc]initWithFrame:rect] ;
    [_rightButtonView addTarget:self action:@selector(passwordEncrypt:) forControlEvents:UIControlEventTouchUpInside];
    return _rightButtonView;
}

-(instancetype)initWithSideStyle:(UITextFieldSideViewStyle)style placeholder:(NSString *)placeholder sideImage:(NSArray <NSString *> *)imageNames{
    self.sideImages = imageNames;
    self.sideViewStyle = style;
    return [self initWithFrame:CGRectZero text:nil placeholder:placeholder];
}


-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text placeholder:(NSString *)placeholder
{
    return [self initWithFrame:frame text:text placeholder:placeholder font:[KKFitTool fitWithTextHeight:13.0f] color:kPLACEHOLDER_TEXT_COLOR borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault returnKey:UIReturnKeyDone];
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text placeholder:(NSString *)placeholder font:(UIFont *)font color:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle keyboardType:(UIKeyboardType)keyBoardType returnKey:(UIReturnKeyType)returnKey
{
    if (self = [super initWithFrame:frame]) {
        self.text = [text copy];
        self.placeholder = [placeholder copy];
        self.font = font;
        self.textColor = color;
        self.borderStyle = borderStyle;
        self.returnKeyType = returnKey;
        self.keyboardType = keyBoardType;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setValue:kPLACEHOLDER_TEXT_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

-(void)setSideViewStyle:(UITextFieldSideViewStyle)sideViewStyle{
    _sideViewStyle = sideViewStyle;
    if (_sideViewStyle == UITextFieldSideViewStyleLeft) {
        UIView *view = self.sideBackView;
        KKButton *leftView = self.leftButtonView;
        [leftView setImage:kImageName(self.sideImages[0]) forState:UIControlStateNormal];
        [view addSubview:leftView];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    else if (_sideViewStyle == UITextFieldSideViewStyleRight){
        UIView *view = self.sideBackView;
        NSString *image = nil;
        if (self.sideImages.count>1) {
            image = self.sideImages[1];
        }
        else
            image = self.sideImages[0];
        KKButton *rightView = self.rightButtonView;
        [rightView setImage:kImageName(self.sideImages[1]) forState:UIControlStateNormal];
        [view addSubview:rightView];
        self.rightView = view;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    else if (_sideViewStyle == UITextFieldSideViewStyleLeftAndRight){
        UIView *leftView = self.sideBackView;
        KKButton *leftSideView = self.leftButtonView;
        [leftSideView setImage:kImageName(self.sideImages[0]) forState:UIControlStateNormal];
        [leftView addSubview:leftSideView];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *rightView = self.sideBackView;
        KKButton *rightSideView = self.rightButtonView;
        [rightSideView setImage:kImageName(self.sideImages[1]) forState:UIControlStateNormal];
        [rightView addSubview:rightSideView];
        self.rightView = rightView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    else{
        //默认不加
    }
}

-(UILabel *)placeHolderLabel{
    UILabel *label = [self valueForKeyPath:@"_placeholderLabel"];
    [label setFrame:self.frame];
    label.textColor = [UIColor orangeColor];
    label.textAlignment=NSTextAlignmentRight;
    return label;
}


-(void)setNumberKeyBoard
{
    //默认值 UIKeyboardTypeDecimalPad
    [self setNumberKeyBoardType:UIKeyboardTypeDecimalPad];
}


-(void)setNumberKeyBoardType:(UIKeyboardType)boardType
{
    self.keyboardType = boardType;
    
    //只有是数字键盘时，才加入toolBar
    if (boardType == UIKeyboardTypeNumberPad || boardType == UIKeyboardTypePhonePad || boardType == UIKeyboardTypeDecimalPad) {
        // tool bar 工具条
        UIToolbar *Toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 216.0f, [UIScreen mainScreen].bounds.size.width, 44.0f)];
        NSMutableArray *ItemArray = [NSMutableArray array];
        //    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target:self action:@selector(buttonClik:)];
        //    itemCancel.tag = 1;
        //    [ItemArray addObject: itemCancel];
        
        //tool bar左 中 右显示按键，（此处左中为空，以占位形式存在）
        UIBarButtonItem *flexibleSpaceItem_l = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [ItemArray addObject: flexibleSpaceItem_l];
        
        UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [ItemArray addObject: flexibleSpaceItem];
        
        UIBarButtonItem *itemConfirm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(buttonClik:)];
        itemConfirm.tag = 2;
        [ItemArray addObject: itemConfirm];
        
        [Toolbar setItems: ItemArray animated: YES];
        Toolbar.barStyle = UIBarStyleDefault;
        
        self.inputAccessoryView = Toolbar;
    }
}

-(void)buttonClik:(UIBarButtonItem *)btn
{
    if (btn.tag==1) {
        [self resignFirstResponder];
        return;
    }
    if (btn.tag==2) {
        [self resignFirstResponder];
        return;
    }
}



#pragma mark Delegate
-(void)passwordEncrypt:(KKButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:kImageName(self.sideImages[2]) forState:UIControlStateSelected];
    }
    else{
        [button setImage:kImageName(self.sideImages[1]) forState:UIControlStateNormal];
    }
    
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(passwordEncrypt:)]) {
        [self.textDelegate passwordEncrypt:button];
    }
}



@end
