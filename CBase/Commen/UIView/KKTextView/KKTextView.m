//
//  KKTextView.m
//  StarZone
//
//  Created by 熊梦飞 on 16/2/17.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "KKTextView.h"
#import "KKLabel.h"
#import "NSString+emoji.h"

@interface KKTextView ()

@property(nonatomic, strong)KKLabel *placeHolderLabel;
@property(nonatomic, strong)KKLabel *textCountLabel;
@property(nonatomic, assign)NSInteger textMaxCount;
@property(nonatomic, assign)NSInteger lastCount;
@end

@implementation KKTextView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text placeholder:(NSString *)placeholder textMaxCount:(NSInteger)textMaxCount
{
    if (self = [super initWithFrame:frame]) {
        _placeholder = placeholder;
        _textMaxCount = textMaxCount;
        [super setText:text];
        self.font = [KKFitTool fitWithTextHeight:14];
        self.backgroundColor = kBACKGROUND_COLOR;
        self.textColor = kSECOND_LEVEL_COLOR;
        [self setContentInset:UIEdgeInsetsMake(2.5, 5, 5, -5)];
        self.placeholderColor = kDISABLE_BUTTON_COLOR;
        self.textCountColor = kDISABLE_BUTTON_COLOR;
        if (textMaxCount>0) {
            self.height = self.height - [KKFitTool fitWithTextHeight:13].lineHeight;
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        [self performSelector:@selector(displayBackUI) withObject:nil afterDelay:0.1];
    }
    return self;
}


- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
    [self textMaxCountLabel];
    
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_textCountLabel) {
        UIFont *font = _textCountLabel.font;
        frame = CGRectMake(self.bounds.size.width-60, self.bounds.size.height+4, 60, font.lineHeight);
        _textCountLabel.frame = CGRectOffset(frame, self.frame.origin.x, self.frame.origin.y);
    }
}

-(void)setTextCountOffsetPonit:(CGPoint)textCountOffsetPonit
{
    _textCountOffsetPonit = textCountOffsetPonit;
    [self textMaxCountLabel];
}

-(void)showIn:(UIView *)view
{
    [view addSubview:self];
    [self displayBackUI];
}

-(void)textMaxCountLabel
{
    if (_textMaxCount>0) {
        UIFont *font = kFONT_13;
        if (_textCountLabel == nil) {
            _textCountLabel = [[KKLabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-60, self.bounds.size.height - font.lineHeight, 60, font.lineHeight) text:nil color:_textCountColor font:font alignment:NSTextAlignmentCenter];
            _textCountLabel.frame = CGRectOffset(_textCountLabel.frame, self.frame.origin.x, self.frame.origin.y);
            [[self superview] addSubview:_textCountLabel];
        }
        if (![_textCountLabel superview] && [self superview]) {
            [[self superview] addSubview:_textCountLabel];
        }
        
        NSInteger textCount = [NSString translateTextToEmojiCodeString:self.text].length;
        if(textCount > self.textMaxCount){
            self.text = [self.text substringToIndex:MIN(self.textMaxCount, _lastCount)];
        }
        self.lastCount = self.text.length;
        NSString *countStr = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)MIN(textCount, _textMaxCount),(long)self.textMaxCount];
        _textCountLabel.text = countStr;
        CGSize size = [countStr resizeWithFont:font adjustSize:CGSizeMake(100, 20)];
        CGRect frame = CGRectMake(self.bounds.size.width-size.width-4 + _textCountOffsetPonit.x, _textCountLabel.frame.origin.y + _textCountOffsetPonit.y, size.width, _textCountLabel.frame.size.height);
        _textCountLabel.frame = frame;
    }
}


-(void)displayBackUI
{
    if( [[self placeholder] length] > 0 )
    {
        UIFont *font = kFONT_12;
        if ( _placeHolderLabel == nil )
        {
            CGFloat margin = 5;
            CGSize size = [_placeholder resizeWithFont:font lineSpace:1.5f adjustSize:CGSizeMake(self.bounds.size.width - margin*2, CGFLOAT_MAX)];
            _placeHolderLabel = [[KKLabel alloc] initWithFrame:CGRectMake(margin,6,size.width,size.height) text:_placeholder color:_placeholderColor font:font alignment:NSTextAlignmentLeft];
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            _placeHolderLabel.numberOfLines = 0;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
    }
    
    [self textMaxCountLabel];
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
}

@end
