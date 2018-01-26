//
//  KKStartSegControl.h
//  StarZone
//
//  Created by 宋林峰 on 16/2/16.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "HMSegmentedControl.h"


@class KKStartSegControl;
@protocol KKStarSegControlDelegate<NSObject>

- (void)segControl:(KKStartSegControl *)segControl segControlShouldChangeSelectedIndex:(NSInteger)index;

@end




@interface KKStartSegControl : HMSegmentedControl

@property (nonatomic, weak) id<KKStarSegControlDelegate> delegate;

+ (instancetype)segmentedControl:(NSArray *)titles;

/**
 *  有滚动底色， 限制，此片只的菜单不过滚动
 *
 *  @param titles       菜单
 *  @param scrollHeight 底部滚动的高
 *  @param image        选中图片
 *
 *  @return class
 */
+ (instancetype)segmentedControl:(NSArray *)titles titleColor:(UIColor *)titleColor scrollHeight:(CGFloat)scrollHeight scrollBackgroud:(UIColor *)color selectImage:(NSString *)imageName;

@end
