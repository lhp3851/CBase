//
//  KKContentFilterController.h
//  StarZone
//
//  Created by TinySail on 16/7/2.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKDynamicFilterPoper.h"
#import "KKArrowButton.h"
typedef enum {
    KKContentFilterControllerTypeNormalTitle,
    KKContentFilterControllerTypeCountTitle
} KKContentFilterControllerType;
typedef enum {
    KKContentFilterShowTypeLeft,
    KKContentFilterShowTypeMiddle,
    KKContentFilterShowTypeRight
} KKContentFilterShowType;
@protocol KKContentFilterControllerDelegate <NSObject>
@optional
- (void)contentFilterWillShow;
@required
- (void)contentFilterWillDismissWithIndex:(NSInteger)index tag:(NSInteger)tag;

@end
@interface KKContentFilterController : NSObject
@property (nonatomic, strong, readonly) KKArrowButton *titleBtn;
@property (nonatomic, weak) id<KKContentFilterControllerDelegate> delegate;

+ (KKContentFilterController *)contentFilterControllerWithTitles:(NSArray *)titles Type:(KKContentFilterControllerType)type showType:(KKContentFilterShowType)showType;
- (void)setTitle:(NSString *)title;//设置普通的title
- (void)setTitleCount:(NSInteger)count;//设置带数量的title的数量

- (NSArray *)getTitles;

- (void)goToNextWithIndex:(NSInteger)index title:(NSString *)title;
@end
