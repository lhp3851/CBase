//
//  KKArrowButton.m
//  FFMTest
//
//  Created by TinySail on 16/2/24.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "KKArrowButton.h"
#import "NSString+Extension.h"
@interface KKArrowButton ()
@property (nonatomic, assign) BOOL mySelected;
@end
@implementation KKArrowButton
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit
{
    _enableAnimation = YES;
    _mySelected = NO;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint point = self.titleLabel.center;
    point.x = self.bounds.size.width/2;
    self.titleLabel.center = point;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+3;
    // [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.width*0.95, 0, 0)];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state
{
    [super setAttributedTitle:title forState:state];
    [self sizeToFit];
}
- (void)reLayoutSubView
{
    [self sizeToFit];
    UIEdgeInsets titleSE = self.titleEdgeInsets;
    UIEdgeInsets imageSE = self.imageEdgeInsets;
    CGFloat imageW = self.currentImage.size.width;//xiangsu
    titleSE.left = - imageW * 2.0;
    imageSE.left = self.bounds.size.width - imageW;
    self.titleEdgeInsets = titleSE;
    self.imageEdgeInsets = imageSE;
}
- (BOOL)isSelected
{
    if (KIOS_VERSION < 8.0) {
        return _mySelected;
    }else
        return [super isSelected];
}
- (void)setSelected:(BOOL)selected
{
    if (KIOS_VERSION < 8.0) {
        _mySelected = selected;
    }else
        [super setSelected:selected];
    if (!_enableAnimation) {
        return;
    }
    if (selected) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(- M_PI + 0.001);
//            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, - M_PI + 0.001);
        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.1 animations:^{
//              self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, 0.001);
//            }];
        }];
    }
    else
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
}
@end
