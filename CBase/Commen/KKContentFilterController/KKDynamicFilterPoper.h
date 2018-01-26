//
//  KKDynamicFilterPoper.h
//  FFMTest
//
//  Created by TinySail on 16/2/23.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKPopover.h"
@class KKDynamicFilterPoper;
@protocol KKDynamicFilterPoperDelegate <NSObject>
/**
 *  @brief
 *
 *  @param poper <#poper description#>
 *  @param index -1表示点击poperView之外的区域
 */
- (void)dynamicFilterPoper:(KKDynamicFilterPoper *)poper willDismissWithIndex:(NSInteger)index title:(NSString *)title;
@end
@interface KKDynamicFilterPoper : NSObject
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) CGSize arrowSize;  //默认为(20, 5)
@property (nonatomic, weak) id<KKDynamicFilterPoperDelegate> delegate;
- (instancetype)initWithTitles:(NSMutableArray *)titles;
- (void)showAtPoint:(CGPoint)point
            Postion:(KKPopoverPosition)position
             inView:(UIView *)containerView;
- (void)setSelectedRow:(NSInteger)index;
- (void)dismissPoperView;
@end
