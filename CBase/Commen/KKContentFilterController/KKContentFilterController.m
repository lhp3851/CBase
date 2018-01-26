//
//  KKContentFilterController.m
//  StarZone
//
//  Created by TinySail on 16/7/2.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "KKContentFilterController.h"
@interface KKContentFilterController()<KKDynamicFilterPoperDelegate>
@property (nonatomic, strong) KKDynamicFilterPoper *filterPoper;
@property (nonatomic, strong) KKArrowButton *titleBtn;
@property (nonatomic, assign) KKContentFilterControllerType titleType;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy)   NSString *selectedTitle;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableDictionary *countDict;
@end
@implementation KKContentFilterController
- (instancetype)initWithTitles:(NSArray *)titles type:(KKContentFilterControllerType)type showType:(KKContentFilterShowType)showType
{
    if (self = [super init]) {
        _titleType = type;
        _titles = [titles mutableCopy];
        [self commonInitWithBtnShowType:showType];
    }
    return self;
}

- (void)commonInitWithBtnShowType:(KKContentFilterShowType)showType
{
    //初始化poper
    _filterPoper = [[KKDynamicFilterPoper alloc] initWithTitles:[NSMutableArray arrayWithArray:_titles]];
    _filterPoper.delegate = self;
    _filterPoper.arrowSize = CGSizeMake(20, 10);
    _selectedIndex = 0;
    _selectedTitle = _titles[0];
    
    
    _titleBtn = [[KKArrowButton alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [self setTitleBtnWithTitle:_titles[0] andCount:0];
    
    [_titleBtn setImage:[UIImage imageNamed:@"down_icon"] forState:UIControlStateNormal];
    [_titleBtn addTarget:self action:@selector(arrowBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.tag = showType;
    _countDict = [NSMutableDictionary dictionary];
}

- (NSArray *)getTitles{
    return self.titles;
}

- (void)arrowBtnDidTap:(KKArrowButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        UIView *showView = kKey_Window;
        if ([self.delegate respondsToSelector:@selector(contentFilterWillShow)]) {
            [self.delegate contentFilterWillShow];
        }
        if (btn.tag == KKContentFilterShowTypeRight) {
            [_filterPoper showAtPoint:CGPointMake(showView.frame.size.width, 64.0 - _filterPoper.arrowSize.height) Postion:KKPopoverPositionDown inView:showView];
        }else if (btn.tag == KKContentFilterShowTypeMiddle){
            [_filterPoper showAtPoint:CGPointMake(showView.frame.size.width / 2.0, 64.0 - _filterPoper.arrowSize.height) Postion:KKPopoverPositionDown inView:showView];
        }else{
            [_filterPoper showAtPoint:CGPointMake(0, 64.0 - _filterPoper.arrowSize.height) Postion:KKPopoverPositionDown inView:showView];
        }
        [self.filterPoper setSelectedRow:_selectedIndex];
    }
}
- (void)setTitleBtnWithTitle:(NSString *)title andCount:(NSInteger)count
{
    if (_titleType == KKContentFilterControllerTypeNormalTitle) {
        [_titleBtn setTitle:title forState:UIControlStateNormal];
    }else{
        NSMutableAttributedString *comTitle = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : kBACKGROUND_COLOR}]];
        [_titleBtn setAttributedTitle:comTitle forState:UIControlStateNormal];
    }
}
- (void)dynamicFilterPoper:(KKDynamicFilterPoper *)poper willDismissWithIndex:(NSInteger)index title:(NSString *)title
{
    [self arrowBtnDidTap:_titleBtn];
    if (index < 0 || index == _selectedIndex) {
        return;
    }
    _selectedIndex = index;
    _selectedTitle = title;
    [self.delegate contentFilterWillDismissWithIndex:index tag:self.titleBtn.tag];
    
    NSInteger count = 0;
    NSNumber *countNumber = [_countDict valueForKey:title];
    if (countNumber) {
        count = [countNumber integerValue];
    }
    [self setTitleBtnWithTitle:title andCount:count];
}
- (void)goToNextWithIndex:(NSInteger)index title:(NSString *)title{
    _selectedIndex = index;
    _selectedTitle = title;
    NSInteger count = 0;
    NSNumber *countNumber = [_countDict valueForKey:title];
    if (countNumber) {
        count = [countNumber integerValue];
    }
   [self setTitleBtnWithTitle:title andCount:count];
}
- (void)setTitle:(NSString *)title
{
    [self setTitleBtnWithTitle:title andCount:0];
}
- (void)setTitleCount:(NSInteger)count
{
    [_countDict setValue:[NSNumber numberWithInteger:count] forKey:_selectedTitle];
    [self setTitleBtnWithTitle:_selectedTitle andCount:count];
}
+ (KKContentFilterController *)contentFilterControllerWithTitles:(NSArray *)titles Type:(KKContentFilterControllerType)type showType:(KKContentFilterShowType)showType
{
    return [[self alloc] initWithTitles:titles type:type showType:showType];
}
@end
