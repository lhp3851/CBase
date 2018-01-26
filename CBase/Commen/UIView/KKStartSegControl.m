//
//  KKStartSegControl.m
//  StarZone
//
//  Created by 宋林峰 on 16/2/16.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "KKStartSegControl.h"

#import <UIKit/UIKit.h>
#define kSegmentedControlFontSize 12.0
@interface KKStartSegControl ()
@property(nonatomic, strong)UIImageView *selectImageView;
@property(nonatomic, strong)UIView *scrollBgView; //滚动底
@property(nonatomic, assign)CGFloat itemWith;
@property(nonatomic, assign)CGFloat scrollHeight;
@end
@implementation KKStartSegControl

+ (instancetype)segmentedControl:(NSArray *)titles
{
    KKStartSegControl *segment = [[KKStartSegControl alloc] initWithSectionTitles:titles titleColor:nil scrollHeight:0.0f scrollBackgroud:nil selectImage:nil];
    return segment;
}

+ (instancetype)segmentedControl:(NSArray *)titles titleColor:(UIColor *)titleColor scrollHeight:(CGFloat)scrollHeight scrollBackgroud:(UIColor *)color selectImage:(NSString *)imageName
{
    KKStartSegControl *segment = [[KKStartSegControl alloc] initWithSectionTitles:titles titleColor:titleColor scrollHeight:scrollHeight scrollBackgroud:color selectImage:imageName];
    return segment;
}




-(id)initWithSectionTitles:(NSArray *)sectiontitles
{
    return [self initWithSectionTitles:sectiontitles titleColor:nil scrollHeight:0 scrollBackgroud:nil selectImage:nil];
}

-(id)initWithSectionTitles:(NSArray *)sectiontitles titleColor:(UIColor *)titleColor scrollHeight:(CGFloat)scrollHeight scrollBackgroud:(UIColor *)color selectImage:(NSString *)imageName
{
    if (self = [super initWithSectionTitles:sectiontitles]) {
        [super setFrame:CGRectMake(0, 0, kWINDOW_WIDTH, [KKFitTool fitWithHeight:44.0f])];
        self.backgroundColor = color;
        self.verticalDividerEnabled = NO;
        self.verticalDividerColor = [UIColor whiteColor];
        self.verticalDividerWidth = 1.0f;
        
//        self.verticalDividerHeight = [KKFitTool fitWithHeight:20.0f];
        
        
        self.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        
        self.selectionIndicatorBoxOpacity = 0;
        self.selectionIndicatorColor = kNORMAL_BUTTON_COLOR;
        self.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        
        self.selectionIndicatorHeight = 2;
        NSMutableDictionary *selectedTextAttr = [NSMutableDictionary dictionary];
        selectedTextAttr[NSForegroundColorAttributeName] = titleColor==nil? kNORMAL_BUTTON_COLOR :titleColor;
        selectedTextAttr[NSFontAttributeName] = [KKFitTool fitWithTextHeight:kSegmentedControlFontSize];
        self.selectedTitleTextAttributes = selectedTextAttr;
        
        NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
        
        textAttr[NSForegroundColorAttributeName] = kTHIRD_LEVEL_COLOR;
        textAttr[NSFontAttributeName] = [KKFitTool fitWithTextHeight:kSegmentedControlFontSize];;
        self.titleTextAttributes = textAttr;
        [self addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        
        if (scrollHeight>0 && imageName.length>0) {
            self.selectionIndicatorHeight = 0;
            self.selectionIndicatorColor = [UIColor clearColor];
            self.itemWith = self.width/sectiontitles.count;
            self.scrollHeight = scrollHeight;
            self.scrollBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, scrollHeight)];
            self.scrollBgView.backgroundColor = color;
            [self addSubview:_scrollBgView];
            UIImage *image = [FileOperationManager imageWithPath:imageName];
            self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_itemWith - image.size.width)/2, scrollHeight-image.size.height, image.size.width, image.size.height)];
            self.selectImageView.image = image;
            [self.scrollBgView addSubview:_selectImageView];
        }
    }
    return self;
}


-(void)setFrame:(CGRect)frame
{
    if (self.scrollBgView==nil) {
        [super setFrame:frame];
        return;
    }
    CGRect rect = frame;
    rect.size.height = rect.size.height - self.scrollHeight;
    [super setFrame:rect];
    
    self.itemWith = self.width/self.sectionTitles.count;
    self.scrollBgView.frame = CGRectMake(0, self.height, self.width, _scrollHeight);
    CGFloat x_offset = self.selectedSegmentIndex *_itemWith;
    self.selectImageView.x = x_offset + (_itemWith - self.selectImageView.width)/2;
}

-(void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    [super setSelectedSegmentIndex:selectedSegmentIndex];
    if (self.scrollBgView==nil) {
        return;
    }
    [UIView animateWithDuration:0.2f animations:^{
        CGFloat x_offset = self.selectedSegmentIndex *_itemWith;
        self.selectImageView.x = x_offset + (_itemWith - self.selectImageView.width)/2;
    }];;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentC
{
    if ([self.delegate respondsToSelector:@selector(segControl:segControlShouldChangeSelectedIndex:)]) {
        [self.delegate segControl:self segControlShouldChangeSelectedIndex:self.selectedSegmentIndex];
    }
}

@end
