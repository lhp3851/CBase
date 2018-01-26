//
//  KKDynamicFilterPoper.m
//  FFMTest
//
//  Created by TinySail on 16/2/23.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "KKDynamicFilterPoper.h"
#define kDynamicFilterPoperBoundWith 5.0
#define kDynamicFilterTitleWidth 125.0
#define kDynamicFilterTitleHeight 40.0

@interface KKDynamicFilterPoperCell : UITableViewCell
{
    UILabel *_titleLab;
}
+ (KKDynamicFilterPoperCell *)cellWithTableView:(UITableView *)tableView andReuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, strong) NSString *btnTitle;
@property (nonatomic, assign) BOOL showSeperatorLine;
@property (nonatomic, assign) BOOL showLine;
@property (nonatomic, strong) UIView *seperatorLine;
@end

@implementation KKDynamicFilterPoperCell
+ (KKDynamicFilterPoperCell *)cellWithTableView:(UITableView *)tableView andReuseIdentifier:(NSString *)reuseIdentifier
{
    KKDynamicFilterPoperCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[KKDynamicFilterPoperCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView *cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDynamicFilterTitleWidth, kDynamicFilterTitleHeight)];
        cellBackView.backgroundColor = kBACK_TABLE_COLOR;//[UIColor colorWithRGBValue:0xFED22D alpha:1.0];
        cellBackView.layer.cornerRadius = 8.0;
        cell.selectedBackgroundView = cellBackView;
    }
    return cell;
}
- (void)setBtnTitle:(NSString *)btnTitle
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDynamicFilterTitleWidth, kDynamicFilterTitleHeight)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = kFIRST_LEVEL_COLOR;//[UIColor colorWithRGBValue:0x333336 alpha:1.0];
        _titleLab.font = [UIFont systemFontOfSize:14.0];
    }
    _titleLab.text = btnTitle;
    _btnTitle = btnTitle;
}

- (UIView *)seperatorLine
{
    if (!_seperatorLine) {
        _seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(kDynamicFilterPoperBoundWith, kDynamicFilterTitleHeight - 0.5, kDynamicFilterTitleWidth - kDynamicFilterPoperBoundWith * 2.0, 0.5)];
        _seperatorLine.backgroundColor = [UIColor colorWithRGBValue:0x333336 alpha:0.1];
    }
    return _seperatorLine;
}
- (void)setShowSeperatorLine:(BOOL)showSeperatorLine
{
    if (_showSeperatorLine == showSeperatorLine || (!_showLine)) {
        return;
    }
    _showSeperatorLine = showSeperatorLine;
    self.seperatorLine.hidden = !showSeperatorLine;
    
}
- (void)setShowLine:(BOOL)showLine
{
    if (showLine) {
        [self addSubview:self.seperatorLine];
    }
    else
        [self.seperatorLine removeFromSuperview];
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.showSeperatorLine = NO;
    }
    else
    {
        self.showSeperatorLine = YES;
    }
}

@end

@interface KKDynamicFilterPoper ()<KKPopoverDelegate, UITableViewDataSource, UITableViewDelegate>
{
    KKPopover *_popover;
    UITableView *_contentTableView;
}
@end
@implementation KKDynamicFilterPoper
static NSString *cellReuseIdentifier = @"cellReuseIdentifier";
- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithTitles:(NSMutableArray *)titles
{
    if (self = [super init]) {
        [self commonInit];
        self.titles = titles;
    }
    return self;
}
- (void)commonInit
{
    _popover = [KKPopover popover];
    _arrowSize = CGSizeMake(20, 5);
    _popover.arrowSize = _arrowSize;
    _popover.contentInset = UIEdgeInsetsMake(kDynamicFilterPoperBoundWith, kDynamicFilterPoperBoundWith, kDynamicFilterPoperBoundWith, kDynamicFilterPoperBoundWith);
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDynamicFilterTitleWidth, kDynamicFilterTitleHeight) style:UITableViewStylePlain];
    _contentTableView.backgroundColor = [UIColor clearColor];
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.scrollEnabled = NO;
    _contentTableView.bounces = NO;
    _contentTableView.dataSource = self;
    _contentTableView.delegate = self;
}
- (void)setArrowSize:(CGSize)arrawSize
{
    _arrowSize = arrawSize;
    _popover.arrowSize = arrawSize;
}
- (void)setTitles:(NSMutableArray *)titles
{
    _titles = titles;
    _contentTableView.bounds = CGRectMake(0, 0, kDynamicFilterTitleWidth, kDynamicFilterTitleHeight * _titles.count);
    [_contentTableView reloadData];
}
#pragma mark - mark poperViewDelegate
- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(dynamicFilterPoper:willDismissWithIndex:title:)]) {
        [self.delegate dynamicFilterPoper:self willDismissWithIndex:-1 title:nil];
    }
}
#pragma mark - mark tableView degate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKDynamicFilterPoperCell *cell = [KKDynamicFilterPoperCell cellWithTableView:tableView andReuseIdentifier:cellReuseIdentifier];
    cell.btnTitle = _titles[indexPath.row];
    if (indexPath.row == (_titles.count - 1)) {
        cell.showLine = NO;
    }
    else
        cell.showLine = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDynamicFilterTitleHeight;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKDynamicFilterPoperCell *cell = [_contentTableView cellForRowAtIndexPath:indexPath];
  
    cell.selected = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKDynamicFilterPoperCell *cell = [_contentTableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    _popover.delegate = nil;
    [_popover dismiss];
    if ([self.delegate respondsToSelector:@selector(dynamicFilterPoper:willDismissWithIndex:title:)]) {
        [self.delegate dynamicFilterPoper:self willDismissWithIndex:indexPath.row title:_titles[indexPath.row]];
    }
}
- (void)showAtPoint:(CGPoint)point
            Postion:(KKPopoverPosition)position
             inView:(UIView *)containerView
{
    _popover.delegate = self;
    [_popover showAtPoint:point popoverPostion:position withContentView:_contentTableView inView:containerView];
}
- (void)setSelectedRow:(NSInteger)index
{
    [_contentTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
- (void)dismissPoperView
{
    [_popover dismiss];
}
@end
