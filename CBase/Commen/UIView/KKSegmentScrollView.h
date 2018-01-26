//
//  KKSegmentScrollView.h
//  StarZone
//
//  Created by WS on 16/5/9.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKStartSegControl.h"
@class KKSegmentScrollView;
@protocol KKSegmentScrollViewDelegate <NSObject>

- (void)segmentScroll:(KKSegmentScrollView*)scroll didChangePageIndex:(NSInteger)index;

@optional

- (void)segmentScrollToReturnPreviousViewController;

- (void)segmentScrollScrollToIndex:(NSInteger)index;

@end



@interface KKSegmentScrollView : UIView


@property (nonatomic ,strong) KKStartSegControl *segControl;

@property (nonatomic ,strong) UIScrollView *scrollView;


- (void)setTitleTextFont:(UIFont*)font;


- (instancetype)initWithFrame:(CGRect)frame withViews:(NSArray*)views delegate:(id<KKSegmentScrollViewDelegate>)delegate;



- (instancetype)initWithTitles:(NSArray*)titles titleColor:(UIColor*)titleColor lineColor:(UIColor*)lineColor views:(NSArray*)views topFrame:(CGRect)topFrame viewFrame:(CGRect)viewFrame scrollHeight:(CGFloat)scrollHeight delegate:(id<KKSegmentScrollViewDelegate>)delegate;



- (void)switchToIndex:(NSInteger)index;


- (void)addViewes:(NSArray *)viewes WithTitle:(NSArray <NSString *>*)titles andDatas:(NSArray *)dataArray;

-(void)setViewsTitles:(NSArray *)titles;
/**
 移除子视图

 @param index index
 */
- (void)removeSubViewesWithIndex:(NSInteger)index;


/**
 返回index所在的视图
 
 @param index 索引
 @return 视图
 */
- (id)getViewAtIndex:(NSInteger)index;

/**
 设置新的view数组

 @param views views数组
 */
- (void)setNewViews:(NSMutableArray *)views;

- (void)goIndex:(NSInteger)index;

- (void)setViewFrameOffset:(CGFloat)height;

- (void)setViewNomelWithViewFrame:(CGRect)viewFrame topFrame:(CGRect)topFrame;
@end
