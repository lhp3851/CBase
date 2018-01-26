//
//  KKSegmentScrollView.m
//  StarZone
//
//  Created by WS on 16/5/9.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "KKSegmentScrollView.h"
#import "BaseTableView.h"

@interface KKSegmentScrollView ()<UIScrollViewDelegate,KKStarSegControlDelegate>

@property (nonatomic ,strong) NSMutableArray *views;

@property (nonatomic ,strong) NSMutableArray *titles;

@property (nonatomic ,assign) id<KKSegmentScrollViewDelegate>delegate;

@property (nonatomic ,assign) NSInteger currentPage;

@property (nonatomic ,strong) UIColor *titleColor;

@end



@implementation KKSegmentScrollView


- (void)setTitleTextFont:(UIFont*)font{
    if (self.segControl && font) {
        if (self.titleColor == nil) {
            self.titleColor = [UIColor blackColor];
        }
        NSMutableDictionary *normalTextAttributes = [NSMutableDictionary dictionary];
        [normalTextAttributes setObject:font forKey:NSFontAttributeName];
        [normalTextAttributes setObject:RGBHex(0x888888) forKey:NSForegroundColorAttributeName];
        self.segControl.titleTextAttributes = [normalTextAttributes copy];
        
        NSMutableDictionary *selectTextAttributes = [NSMutableDictionary dictionary];
        [selectTextAttributes setObject:font forKey:NSFontAttributeName];
        [selectTextAttributes setObject:self.titleColor forKey:NSForegroundColorAttributeName];
        self.segControl.selectedTitleTextAttributes = [selectTextAttributes copy];
    }
}


- (instancetype)initWithTitles:(NSArray*)titles titleColor:(UIColor*)titleColor lineColor:(UIColor*)lineColor views:(NSArray*)views topFrame:(CGRect)topFrame viewFrame:(CGRect)viewFrame scrollHeight:(CGFloat)scrollHeight delegate:(id<KKSegmentScrollViewDelegate>)delegate{
    if (self = [super initWithFrame:viewFrame]) {
        self.delegate = delegate;
        self.titles   = [NSMutableArray arrayWithArray:titles];
        self.views    = [NSMutableArray arrayWithArray:views];
        self.currentPage = 0;
        self.titleColor = titleColor;
        self.segControl = [KKStartSegControl segmentedControl:titles titleColor:titleColor scrollHeight:scrollHeight scrollBackgroud:[UIColor clearColor] selectImage:nil];
        self.segControl.frame = topFrame;
        self.segControl.selectionIndicatorColor = lineColor;
        self.segControl.delegate = self;
        self.segControl.borderType = HMSegmentedControlBorderTypeBottom;
        self.segControl.borderColor = kDISABLE_BUTTON_COLOR;
        [self setup];
    }
    return self;
}
- (void)setViewFrameOffset:(CGFloat)height{
    CGRect viewFrame = self.frame;
    CGRect topFrame = self.segControl.frame;
    self.frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y - height, viewFrame.size.width, viewFrame.size.height + height);
    self.segControl.frame = CGRectMake(topFrame.origin.x, topFrame.origin.y - height, topFrame.size.width, topFrame.size.height);
}
- (void)setViewNomelWithViewFrame:(CGRect)viewFrame topFrame:(CGRect)topFrame{
    self.frame = viewFrame;
    self.segControl.frame = topFrame;
}
- (instancetype)initWithFrame:(CGRect)frame withViews:(NSArray*)views delegate:(id<KKSegmentScrollViewDelegate>)delegate{
    
    if (self = [super initWithFrame:frame]) {
        self.views = [NSMutableArray arrayWithArray:views];
        [self setup];
        
    }
    return self;
}

- (void)setNewViews:(NSMutableArray *)views{
    self.views = views;
    [self setup];
}

- (void)addViewes:(NSArray *)viewes WithTitle:(NSArray <NSString *>*)titles andDatas:(NSArray *)dataArray{
    if (!viewes || !titles) {
        return;
    }
    self.titles = [NSMutableArray arrayWithArray:self.segControl.sectionTitles];
    for (NSString *titel in titles) {
        [self.titles insertObject:titel atIndex:self.titles.count-1];
    }
    [self.segControl setSectionTitles:self.titles];
    
    //统一左移，再插入新的视图
//    for (UIView *view in self.views) {
//        CGRect frame = view.frame;
//        frame.origin.x = frame.origin.x - kWINDOW_WIDTH;
//        view.frame = frame;
//    }
    
    for (UIView *view in viewes) {
        [self.views addObject:view];
    }
    
    CGFloat x = 0;
    CGFloat maxH = 0;
    for (NSInteger i = 0; i < self.views.count; i++) {
        UIView *view = self.views[i];
        x += view.frame.size.width;
        [self.scrollView addSubview:view];
        if (CGRectGetMaxY(view.frame) > maxH) {
            maxH = view.frame.size.height;//最大的高度
        }
    }
   self.scrollView.contentSize = CGSizeMake(x, maxH);
}

- (void)removeSubViewesWithIndex:(NSInteger)index{
    self.views =  [NSMutableArray arrayWithArray:self.scrollView.subviews];
    self.titles = [NSMutableArray arrayWithArray:self.segControl.sectionTitles];
    NSInteger count = self.views.count;
    for (NSInteger i = count-1; i>=index; i--) {
        [self.titles removeObjectAtIndex:i];
        UIView *view = self.views[i];
        [view removeFromSuperview];
        [self.views removeObjectAtIndex:i];
    }
    [self.segControl setSectionTitles:self.titles];
    CGFloat x = 0;
    CGFloat maxH = 0;
    for (NSInteger i = 0; i < self.views.count; i++) {
        UIView *view = self.views[i];
        x += view.frame.size.width;
        if (CGRectGetMaxY(view.frame) > maxH) {
            maxH = view.frame.size.height;//最大的高度
        }
    }
    self.scrollView.contentSize = CGSizeMake(x, maxH);
}



-(void)setViewsTitles:(NSArray *)titles{
    self.titles = [NSMutableArray arrayWithArray:titles];
    [self.segControl setSectionTitles:self.titles];
}


- (void)setup{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.backgroundColor = kBACKGROUND_DEEP_COLOR;
    _scrollView.autoresizingMask = 0xff;
    _scrollView.contentMode = UIViewContentModeCenter;
    _scrollView.delegate = self;
    _scrollView.bounces=NO;
    _scrollView.directionalLockEnabled=YES;
    _scrollView.alwaysBounceVertical=NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.scrollsToTop  = NO;
    _segControl.clipsToBounds = NO;
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    
    CGFloat x = 0;
    CGFloat maxH = 0;
    for (int i = 0; i < self.views.count; i ++) {
        UIView *view = self.views[i];
        view.x = x;
        x += view.frame.size.width;
        [_scrollView addSubview:view];
        if (view.frame.size.height + view.frame.origin.y > maxH) {
            maxH = view.frame.size.height;
        }
    }
    _scrollView.contentSize = CGSizeMake(x, maxH);
    [self addSubview:_scrollView];
    [self addNotification];
}

- (void)nextPage{
    if (self.currentPage + 1 > self.views.count) {

    }else{
        self.currentPage++;
        self.segControl.selectedSegmentIndex = self.currentPage;
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentScrollScrollToIndex:)]){
            [self.delegate segmentScrollScrollToIndex:self.currentPage];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentScroll:didChangePageIndex:)]) {
            [self.delegate segmentScroll:self didChangePageIndex:self.currentPage];
        }
    }
}
- (void)lastPage{
    if (self.currentPage < 0) {
        
    }else{
        self.currentPage--;
        self.segControl.selectedSegmentIndex = self.currentPage;
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentScrollScrollToIndex:)]){
            [self.delegate segmentScrollScrollToIndex:self.currentPage];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentScroll:didChangePageIndex:)]) {
            [self.delegate segmentScroll:self didChangePageIndex:self.currentPage];
        }
    }
}

-(void)jumpToThePage:(NSInteger)pageNum{
    if (self.currentPage<0||self.currentPage + 1 > self.views.count) {
        
    }
    else{
        self.currentPage = pageNum;
        self.segControl.selectedSegmentIndex = self.currentPage;
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentScroll:didChangePageIndex:)]) {
            [self.delegate segmentScroll:self didChangePageIndex:self.currentPage];
        }
    }
}


- (id)getViewAtIndex:(NSInteger)index{
    return self.views[index];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    int contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX<=0) {//最左边了
        if (self.delegate&&[self.delegate conformsToProtocol:@protocol(KKSegmentScrollViewDelegate)]&&[self.delegate respondsToSelector:@selector(segmentScrollToReturnPreviousViewController)]) {
            [self.delegate segmentScrollToReturnPreviousViewController];
        }
        return;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    //偏移量为kWINDOWWIDTH的通知
    if (contentOffsetX == kWINDOW_WIDTH || contentOffsetX == 0) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"scrollViewOffsetX" object:@{@"OffsetX":[NSString stringWithFormat:@"%d",contentOffsetX]}];
    }
    if (![self capTurnPage:contentOffsetX]) {
        return;
    }
    if((contentOffsetX > self.currentPage * kWINDOW_WIDTH)&&(contentOffsetX<=(self.currentPage + 1) * kWINDOW_WIDTH)) {
        [self nextPage];
    }else if((contentOffsetX < self.currentPage * kWINDOW_WIDTH)&&(contentOffsetX>=(self.currentPage - 1) * kWINDOW_WIDTH)) {
        [self lastPage];
    }
    else{
        int screenWidth=kWINDOW_WIDTH;
        if (contentOffsetX%screenWidth!=0) {
            return;
        }
        NSInteger pageNum=[self getPageNumber:contentOffsetX];
        if (pageNum==self.currentPage) {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentScrollScrollToIndex:)]){
            [self.delegate segmentScrollScrollToIndex:pageNum];
        }
        [self jumpToThePage:pageNum];
    }
}

- (void)goIndex:(NSInteger)index{
    [self.segControl setSelectedSegmentIndex:index animated:YES];
    [self.scrollView setContentOffset:CGPointMake(index * kWINDOW_WIDTH, 0)];
    self.currentPage = index;
}

- (void)segControl:(KKStartSegControl *)segControl segControlShouldChangeSelectedIndex:(NSInteger)index{
    CGFloat offsetX = 0.0;
    for (int i = 0; i < index; i ++) {
        UIView *view  = self.views[i];
        offsetX += view.frame.size.width;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


- (void)switchToIndex:(NSInteger)index{
    [self.segControl setSelectedSegmentIndex:index animated:YES];
    CGFloat offsetX = 0.0;
    for (int i = 0; i < index; i ++) {
        UIView *view  = self.views[i];
        offsetX += view.frame.size.width;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


- (void)setScrollEnable:(BOOL)enable{
    self.scrollView.scrollEnabled = enable;
}

-(NSInteger)getPageNumber:(CGFloat)contentOffSetX{
    NSInteger pageNum=contentOffSetX/kWINDOW_WIDTH;
    return pageNum;
}

-(BOOL)capTurnPage:(int)contentOffsetX{
    int screenWidth=kWINDOW_WIDTH;
    if (contentOffsetX%screenWidth!=0) {
        return NO;
    }
    return YES;
}


-(void)changeTitles:(NSNotification *)noti{
    
}



-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTitles:) name:@"" object:nil];
}


-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dealloc{
    [self removeNotification];
}

@end
