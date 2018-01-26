//
//  Selector.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/13.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "SelectorView.h"
#import "KKSegmentScrollView.h"
#import "LineView.h"
#import "SearchParamModel.h"
#import "AddressManager.h"
#import "DateTool.h"

@interface SelectorView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,KKSegmentScrollViewDelegate>

@property(nonatomic,strong)UIView  *backView;//背景透明层

@property(nonatomic,assign)CGRect floatViewFrame;//背景图frame

@property(nonatomic,strong)KKLabel *titleLabel;//上面的标题

@property(nonatomic,strong)KKButton *cancleButton;//取消按钮

@property(nonatomic,strong)BaseTableView *datasTableView;

@property(nonatomic,strong)NSMutableArray *datas;//数据

@property(nonatomic,assign)selectorType type;//当前选则的数据类型：日期，地区

@property(nonatomic,strong)KKSegmentScrollView *segmentScrollView;//用来装载滑动视图

@property(nonatomic,strong)NSMutableArray *selectedItems;//已选择的数据，用来返回给视图

@property(nonatomic,strong)LineView *lineView;//标题与数据视图的分割线

@property(nonatomic,strong)SearchParamModel *model;//搜索的参数

@property(nonatomic,strong)AddressManager *addressManager;

@property(nonatomic,assign)BOOL shouldAddSubView;     //添加子视图或者刷新子视图

@property(nonatomic,assign)NSInteger cunrrentSeletItem;//当前选则的数据类型的具体选项：日期的月份、地区的省市区等

@property(nonatomic,strong)NSIndexPath *selectedIndexPath;//当前选中的行

@property(nonatomic,strong)UIWindow *topWindow;

@property(nonatomic,strong)KKImageView *selectedStatusImageView;//选中状态的显示标识

@property(nonatomic,strong)NSString *startDate;//开始时间

@property(nonatomic,strong)NSString *endDate;//结束时间

@property(nonatomic,assign)BOOL isStartDate;//是否正在筛选开始日期：1筛选开始日期，0筛选结束日期

@property(nonatomic,strong)NSString *currentSelectedYear;//当前选择的年份，用来过滤月份

@property(nonatomic,strong)NSString *currentSelectedMonth;//当前选择的月份，用来过滤日

@end

@implementation SelectorView

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame selectorType:(selectorType)type delegate:(id<ClearSelectorViewDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.type  = type;
        self.delegate = delegate;
        self.floatViewFrame = frame;
        [self initDatas];
        [self initView];
        [self addNoti];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame datas:(NSMutableArray *)data selectorType:(selectorType)type delegate:(id<ClearSelectorViewDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.type  = type;
        self.delegate = delegate;
        self.floatViewFrame = frame;
        [self initDatas];
        [self initViewWithDatas:data];
        [self addNoti];
    }
    return self;
}


/**
 不带初始数据初始化筛选器
 */
-(void)initView{
    [self.topWindow makeKeyAndVisible];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.cancleButton];
    [self.backView addSubview:self.segmentScrollView];
    [self.backView addSubview:self.segmentScrollView.segControl];
    [self setConstraint];
    [self.topWindow addSubview:self.backView];
}


/**
 带初始数据初始化筛选器

 @param datas 已选择的初始数据
 */
-(void)initViewWithDatas:(NSArray *)datas{
    [self.topWindow makeKeyAndVisible];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.cancleButton];
    
    NSArray *titles = [self getTitlesFromSelectedDatas:datas andType:self.type];
    NSArray *selectedDatas = [self generateDataWithData:datas andType:self.type];
    if (self.type == selectorTypeTerminalStatus) {//终端状态传过来的数据是字符化的，要转为可认识的状态
        datas = [self getStatusDataWithStatus:datas.firstObject];
    }
    self.selectedItems = [NSMutableArray arrayWithArray:datas];//设置已选的
    NSMutableArray *subView = [NSMutableArray array];
    for (NSInteger i=0; i<titles.count; i++) {
        BaseTableView *tableView =self.datasTableView;
        if (self.type == selectorTypeDistric || self.type == selectorTypeCleander) {
            tableView.datas = selectedDatas[i];
            NSInteger index = [self getSelectedIndexWithObject:titles[i] andDatas:tableView.datas type:self.type];
            tableView.selectedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
            self.datas = tableView.datas;
        }
        else{
            tableView.datas = [NSMutableArray arrayWithArray:selectedDatas];
            NSInteger index = [self getSelectedIndexWithObject:titles[i] andDatas:tableView.datas type:self.type];
            tableView.selectedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
            self.datas = tableView.datas;
            [tableView scrollToRowAtIndexPath:tableView.selectedIndexPath  atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
        
        [subView addObject:tableView];
    }
    
    CGRect topFrame  = CGRectMake(0, [KKFitTool fitWithHeight:275] + kDEFAULT_BUTTON_HEIGHT, kWINDOW_WIDTH, kFitWithHeight(30));
    CGRect viewFrame = CGRectMake(0, CGRectGetMaxY(topFrame), kWINDOW_WIDTH,kWINDOW_HEIGHT - [KKFitTool fitWithHeight:220] - kDEFAULT_BUTTON_HEIGHT);
    
    self.segmentScrollView =  [[KKSegmentScrollView alloc]initWithTitles:titles titleColor:kNORMAL_BUTTON_COLOR lineColor:kNORMAL_BUTTON_COLOR views:subView topFrame:topFrame viewFrame:viewFrame scrollHeight:kDEFAULT_BUTTON_HEIGHT delegate:self];
    [self.segmentScrollView.segControl setSelectedSegmentIndex:titles.count-1];
    self.cunrrentSeletItem = selectedDatas.count-1;
    self.segmentScrollView.segControl.backgroundColor = kBACKGROUND_COLOR;
    self.segmentScrollView.segControl.borderType = HMSegmentedControlBorderTypeBottom;
    self.segmentScrollView.segControl.borderColor = kDISABLE_BUTTON_COLOR;
    [self.segmentScrollView.scrollView setContentOffset:CGPointMake(kWINDOW_WIDTH*(titles.count-1), 0) animated:YES];
    [self.backView addSubview:self.segmentScrollView];
    [self.backView addSubview:self.segmentScrollView.segControl];
    [self setConstraint];
    [self.topWindow addSubview:self.backView];
}

/**
 初始化数据
 */
-(void)initDatas{
    self.shouldAddSubView = NO;
    self.model = [SearchParamModel sharedSearchParamModel];
    self.cunrrentSeletItem = 0;
    _selectedItems =[NSMutableArray array];
    switch (self.type) {
        case selectorTypeDistric:
        {
            self.addressManager = [AddressManager shareInstance];
            self.titleLabel.text =@"所在地区";
            self.datas     =[self.addressManager querryProvincesInfo];
        }
            break;
        case selectorTypeCleander:
        {
            self.titleLabel.text =@"选择日期";
            self.datas = [NSMutableArray arrayWithArray:[self fliterDateWithDatas:[Date yeares]]];
        }
            break;
        case selectorTypeLotteryClass:
        {
            self.titleLabel.text =@"选择彩票种类";
            self.datas = [NSMutableArray arrayWithArray:self.model.lotteryClasse];
        }
            break;
        case selectorTypeTerminalStatus:
        {
            self.titleLabel.text =@"选择状态";
            self.datas =[NSMutableArray arrayWithObjects:@"断网",@"机头锁定",@"机头无票",@"机头缺票",@"熄屏维护",@"熄屏",@"亮屏维护",@"正常",nil];
        }
            break;
        case selectorTypeMerchant:{
            self.titleLabel.text =@"选择运营商";
            self.datas = [NSMutableArray arrayWithArray:self.model.merchant];
        }
            break;
        case selectorTypeGrid:{
            self.titleLabel.text =@"选择网点";
            self.datas = [NSMutableArray arrayWithArray:self.model.grid];
        }
            break;
        case selectorTypePayment:{
            self.titleLabel.text =@"选择支付方式";
            self.datas = [NSMutableArray arrayWithObjects:@"微信支付",@"奖金支付",@"微信+奖金支付",nil];
        }
            break;
        default:
            break;
    }
}


/**
 根据已选数据获取列表显示数据

 @param data 已选数据
 @param type 筛选的类型
 */
-(NSMutableArray *)generateDataWithData:(NSArray *)data andType:(selectorType)type{
    NSMutableArray *datas = [NSMutableArray array];
    switch (type) {
        case selectorTypeDistric:
        {
            self.titleLabel.text =@"所在地区";
            NSArray *provinces = [[AddressManager shareInstance] querryProvincesInfo];
            NSArray *cities = [NSArray array];
            NSArray *districtes = [NSArray array];
            for (NSInteger i=0; i<data.count; i++) {
                AddressDBDetailModel *model = data[i];
                if (i==0) {
                    cities = [[AddressManager shareInstance] querryCitiesInfoWithProvinceId:model.code];
                }
                else if (i==1){
                    districtes=[[AddressManager shareInstance] querryDistrictsInfoWithCityId:model.code];
                }
            }
            if (provinces.count) {
                [datas addObject:provinces];
            }
            if (cities.count) {
                [datas addObject:cities];
            }
            if (districtes.count) {
                [datas addObject:districtes];
            }
        }
            break;
        case selectorTypeCleander:
        {
            self.titleLabel.text =@"选择日期";
            NSArray *years = [NSArray array];
            NSArray *monthes = [NSArray array];
            NSArray *days = [NSArray array];
            self.currentSelectedYear = data[0];
            self.currentSelectedMonth = data[1];
            for (NSInteger i=0; i<data.count; i++) {
                if (i==0) {
                    years = [self fliterDateWithDatas:[Date yeares]];
                }
                else if (i==1){
                    
                    monthes = [self fliterDateWithDatas:[Date monthesWithYear:data[0]]];
                }
                else{
                    days = [self fliterDateWithDatas:[Date dayesWithMoth:data[1] andYear:data[0]]];
                }
            }
            
            if (years) {
                [datas addObject:years];
            }
            
            if (monthes) {
                [datas addObject:monthes];
            }
            
            if (days) {
                [datas addObject:days];
            }
            
        }
            break;
        case selectorTypeLotteryClass:
        {
            self.titleLabel.text =@"选择彩票种类";
            datas = [NSMutableArray arrayWithArray:self.model.lotteryClasse];
        }
            break;
        case selectorTypeTerminalStatus:
        {
            self.titleLabel.text =@"选择状态";
            datas =[NSMutableArray arrayWithObjects:@"断网",@"机头锁定",@"机头无票",@"机头缺票",@"熄屏维护",@"熄屏",@"亮屏维护",@"正常",nil];
        }
            break;
        case selectorTypeMerchant:
        {
            self.titleLabel.text =@"选择运营商";
            datas = [NSMutableArray arrayWithArray:self.model.merchant];
        }
            break;
        case selectorTypeGrid:
        {
            self.titleLabel.text =@"选择网点";
            datas = [NSMutableArray arrayWithArray:self.model.grid];
        }
            break;
        case selectorTypePayment:
        {
            self.titleLabel.text =@"选择支付方式";
            datas = [NSMutableArray arrayWithObjects:@"微信支付",@"奖金支付",@"微信+奖金支付",nil];
        }
            break;
        default:
            break;
    }
    return datas;
}

/**
 只有日期和地理位置信息才需要标题

 @param datas 已选择的条件
 @param type 选择的条件类型
 @return 已选的条件作为标题
 */
-(NSArray *)getTitlesFromSelectedDatas:(NSArray *)datas andType:(selectorType)type{
    NSMutableArray *titles = [NSMutableArray array];
    switch (type) {
        case selectorTypeDistric:
        {
            for (AddressDBDetailModel *model in datas) {
                [titles addObject:model.name];
            }
        }
            break;
        case selectorTypeCleander:
        {
            for (NSInteger i=0; i<datas.count; i++) {
                NSString *component = datas[i];
                [titles addObject:component];
            }
        }
            break;
        case selectorTypeLotteryClass:
        {
            SearchLotteryCalssesModel *lottery = datas.lastObject;
            [titles addObject:lottery.lotteryClassName];
        }
            break;
        case selectorTypeTerminalStatus:
        {
            NSString *title = datas.lastObject;
            title = [self statusFromStatusString:title];
            [titles addObject:title];
        }
            break;
        case selectorTypeMerchant:
        {
            SearchMerchantModel *merchant = datas.lastObject;
            [titles addObject:merchant.merchantName];

        }
            break;
        case selectorTypeGrid:
        {
            SearchGridModel *grid = datas.lastObject;
            [titles addObject:grid.gridName];

        }
            break;
        case selectorTypePayment:
        {
            
        }
            break;
        default:
            break;
    }
    return titles;
}


-(LineView *)lineView{
    if (!_lineView) {
        _lineView = (LineView *)[LineView shareInstance].horizonLine;
    }
    return _lineView;
}

-(KKSegmentScrollView *)segmentScrollView{
    if (!_segmentScrollView) {
        CGRect topFrame  = CGRectMake(0, [KKFitTool fitWithHeight:275] + kDEFAULT_BUTTON_HEIGHT, kWINDOW_WIDTH, kFitWithHeight(30));
        
        CGRect viewFrame = CGRectMake(0, CGRectGetMaxY(topFrame), kWINDOW_WIDTH,kWINDOW_HEIGHT - [KKFitTool fitWithHeight:220] - kDEFAULT_BUTTON_HEIGHT);
        
        NSArray *titles = @[@"请选择"];
        
        BaseTableView *tableView = self.datasTableView;
        tableView.datas = self.datas;
        
        NSArray *viewes = @[tableView];
        
        _segmentScrollView = [[KKSegmentScrollView alloc]initWithTitles:titles titleColor:kNORMAL_BUTTON_COLOR lineColor:kNORMAL_BUTTON_COLOR views:viewes topFrame:topFrame viewFrame:viewFrame scrollHeight:kDEFAULT_BUTTON_HEIGHT delegate:self];
        _segmentScrollView.segControl.backgroundColor = kBACKGROUND_COLOR;
        _segmentScrollView.segControl.borderType = HMSegmentedControlBorderTypeBottom;
        _segmentScrollView.segControl.borderColor = kDISABLE_BUTTON_COLOR;
    }
    return _segmentScrollView;
}


-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = kBACKGROUND_BLACK_COLOR;
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

-(UIWindow *)topWindow{
    if (!_topWindow) {
        _topWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _topWindow.backgroundColor = kBACKGROUND_BLACK_COLOR;
        _topWindow.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearSlef:)];
        tap.delegate =self;
        [_topWindow addGestureRecognizer:tap];
    }
    return _topWindow;
}

-(BaseTableView *)datasTableView{
    CGRect frame = CGRectMake(0, 0, kWINDOW_WIDTH, kWINDOW_HEIGHT - [KKFitTool fitWithHeight:345]);
    _datasTableView = [[BaseTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    _datasTableView.dataSource =self;
    _datasTableView.delegate   = self;
    _datasTableView.backgroundColor =kBACKGROUND_COLOR;
    _datasTableView.needRefreshControl = NeedRefreshControlNonoe;
    _datasTableView.separatorColor = kDISABLE_BUTTON_COLOR;
    _datasTableView.separatorInset = UIEdgeInsetsZero;
    return _datasTableView;
}

-(KKLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[KKLabel alloc]initWithFrame:CGRectZero text:@"标题" color:kFIRST_LEVEL_COLOR font:kFONT_14 alignment:NSTextAlignmentCenter];
        _titleLabel.backgroundColor = kBACKGROUND_COLOR;
        _titleLabel.userInteractionEnabled = NO ;
    }
    return _titleLabel;
}

-(KKButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [[KKButton alloc]initWithFrame:CGRectMake(kWINDOW_WIDTH - kFitWithWidth(31), [KKFitTool fitWithHeight:290], kFitWithWidth(30), kFitWithHeight(30)) SelectedImage:@"cancel_icon" NormalImage:@"cancel_icon"];
        [_cancleButton addTarget:self action:@selector(cancelToSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(KKImageView *)selectedStatusImageView{
    CGRect frame = [KKFitTool fitWithRect:CGRectMake(kHORIZONT_MARGIN, (kFitWithHeight(40) - kFitWithHeight(12))/2, 12, 12)];
    _selectedStatusImageView = [[KKImageView alloc]initWithFrame:frame];
    _selectedStatusImageView.image = kImageName(@"check_icon");
    _selectedStatusImageView.tag = 1111;
    _selectedStatusImageView.hidden = YES;
    return _selectedStatusImageView;
}


-(void)setConstraint{
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([KKFitTool fitWithHeight:285]);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kFitWithHeight(30));
    }];
}

#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   BaseTableView *currentTableView =(BaseTableView *) tableView;
    return currentTableView.datas.count;
//    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [KKFitTool fitWithHeight:40];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifiler=@"cellIdentifiler";
    BaseTableView *currentTableView =(BaseTableView *) tableView;
    BaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifiler];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKImageView *imageView = self.selectedStatusImageView;
    
    if (cell==nil) {
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    NSString *content = [NSString string];
    if (self.type == selectorTypeDistric) {
        AddressDBDetailModel *model = currentTableView.datas[indexPath.row];
        content = model.name;
    }
    else if (self.type == selectorTypeCleander){
        content = currentTableView.datas[indexPath.row];
    }
    else if (self.type == selectorTypeMerchant){
        SearchMerchantModel *model = currentTableView.datas[indexPath.row];
        content = model.merchantName;
    }
    else if (self.type == selectorTypeGrid){
        SearchGridModel *model = currentTableView.datas[indexPath.row];
        content = model.gridName;
    }
    else if (self.type == selectorTypeLotteryClass){
        SearchLotteryCalssesModel *model = currentTableView.datas[indexPath.row];
        content = model.lotteryClassName;
    }
    else if(self.type == selectorTypeTerminalStatus){
        content = currentTableView.datas[indexPath.row];
    }
    else if (self.type == selectorTypePayment){
        content = currentTableView.datas[indexPath.row];
    }
    cell.textLabel.text = content;
    cell.textLabel.font = kFONT_14;
    cell.textLabel.textColor = kFIRST_LEVEL_COLOR;
    [cell.contentView addSubview:imageView];
    [self setSelectedImageViewFramWithContent:cell.textLabel.text imageView:imageView];
    if (currentTableView.selectedIndexPath == indexPath) {
        imageView.hidden = NO;
    }
    else{
        imageView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseTableView *currentTableView =(BaseTableView *) tableView;
    [self setSelectedStatusWithTableView:currentTableView indexPath:indexPath];
    currentTableView.selectedIndexPath = indexPath;
    
    NSString *title = [NSString string];
    if (self.type == selectorTypeDistric) {
        AddressDBDetailModel *addressModel = currentTableView.datas[indexPath.row];
        title = addressModel.name;
        [self setSelectedItemsWithTableView:currentTableView currentSelectedItem:addressModel indexPath:indexPath];
    }
    else if (self.type == selectorTypeCleander){
        title = currentTableView.datas[indexPath.row];
        [self currentSelectedDateComponent:title];//记录下当前选择的日期成分，便于过滤无效日期
        [self setSelectedItemsWithTableView:currentTableView currentSelectedItem:title indexPath:indexPath];
    }
    else if (self.type == selectorTypeMerchant){
        SearchMerchantModel *model = currentTableView.datas[indexPath.row];
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:model];
        title = model.merchantName;
    }
    else if (self.type == selectorTypeGrid){
        SearchGridModel *model = currentTableView.datas[indexPath.row];
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:model];
        title = model.gridName;
    }
    else if (self.type == selectorTypePayment){
        title = currentTableView.datas[indexPath.row];
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:title];
    }
    else if (self.type == selectorTypeLotteryClass){
        SearchLotteryCalssesModel *model = currentTableView.datas[indexPath.row];
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:model];
        title = model.lotteryClassName;
    }
    else if (self.type == selectorTypeTerminalStatus){
        title = currentTableView.datas[indexPath.row];
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:title];
    }
    [self setSubDataWithSelectedData:self.selectedItems title:title tableView:currentTableView andIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableView *currentTableView =(BaseTableView *) tableView;
    [self setSelectedStatusWithTableView:currentTableView indexPath:indexPath];
}


/**
 多个选择条件的时候，设置选中的条件

 @param tableView tableview
 @param object 选中的对象
 */
-(void)setSelectedItemsWithTableView:(BaseTableView *)tableView currentSelectedItem:(id)object indexPath:(NSIndexPath *)indexPath{
    if (self.cunrrentSeletItem+1>self.selectedItems.count) {// && self.segmentScrollView.scrollView.subviews.count<3  || self.cunrrentSeletItem==0
        [self.selectedItems addObject:object];
        self.shouldAddSubView = YES;
    }
    else{
        self.shouldAddSubView = NO;
        [self resetConditionWithObject:object withTableView:tableView andIndex:indexPath];
    }
}


/**
 如果重选,一般只接受两级数据

 @param object 重选的数据模型对象
 @param title 重选模型对象的条件
 */
-(void)resetConditionWithObject:(id)object withTableView:(BaseTableView *)tableView andIndex:(NSIndexPath *)indexPath{
    NSString *title = [self getTitleWithObject:object];
    NSMutableArray *selectedItemes = [NSMutableArray array];
    if (self.cunrrentSeletItem==0) {
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:object];
        [self.segmentScrollView removeSubViewesWithIndex:1];//先把旧的视图及标题删掉
        BaseTableView *subTableView = self.datasTableView;  //在加上一个新的
        subTableView.frame = CGRectMake(kWINDOW_WIDTH*self.segmentScrollView.segControl.sectionTitles.count, 0, kWINDOW_WIDTH, subTableView.frame.size.height);
        [self.segmentScrollView addViewes:@[subTableView] WithTitle:@[@"请选择"] andDatas:nil];
        NSMutableArray *titles = [NSMutableArray arrayWithArray:self.segmentScrollView.segControl.sectionTitles];
        [titles exchangeObjectAtIndex:0 withObjectAtIndex:1];//为了让请选择放在后面，交换一下位置
        [self.segmentScrollView.segControl setSectionTitles:titles];
    }
    else if (self.cunrrentSeletItem == 1 && self.selectedItems.count > 2){
        [self.selectedItems removeLastObject];
        [self.selectedItems removeLastObject];
        [self.selectedItems addObject:object];
        
        [self.segmentScrollView removeSubViewesWithIndex:2];
        BaseTableView *subTableView = self.datasTableView;  //在加上一个新的
        subTableView.frame = CGRectMake(kWINDOW_WIDTH*self.segmentScrollView.segControl.sectionTitles.count, 0, kWINDOW_WIDTH, subTableView.frame.size.height);
        [self.segmentScrollView addViewes:@[subTableView] WithTitle:@[@"请选择"] andDatas:nil];
        NSMutableArray *titles = [NSMutableArray arrayWithArray:self.segmentScrollView.segControl.sectionTitles];
        [titles exchangeObjectAtIndex:1 withObjectAtIndex:2];//为了让请选择放在后面，交换一下位置
        [self.segmentScrollView.segControl setSectionTitles:titles];
    }
    else{
        [self.selectedItems replaceObjectAtIndex:self.cunrrentSeletItem withObject:object];
    }
    selectedItemes = [NSMutableArray arrayWithArray:self.segmentScrollView.segControl.sectionTitles];
    [selectedItemes replaceObjectAtIndex:self.cunrrentSeletItem withObject:title];
    [self.segmentScrollView.segControl setSectionTitles:selectedItemes];
    [self setSubDataWithSelectedData:self.selectedItems title:object tableView:tableView andIndexPath:indexPath];
}

/**
 根据选择的数据模型查找选择的具体条件

 @param object 选择的数据
 @return 具体的条件
 */
-(NSString *)getTitleWithObject:(id)object{
    NSString *title = @"";
    if (self.type == selectorTypeDistric) {
        AddressDBDetailModel *addressModel = object;//tableView.datas[indexPath.row];
        title = addressModel.name;
    }
    else if (self.type == selectorTypeCleander){
        title = object;
    }
    return title;
}

/**
 添加子视图及标题

 @param title 标题
 @param subDatas 子视图数据
 */
-(void)addSubLayerViewWithTitle:(NSString *)title AndData:(NSArray *)subDatas{
    if ((self.type == selectorTypeCleander) || (self.type == selectorTypeDistric)) {//返回选择，只刷新数据，不添加视图
        if (self.shouldAddSubView) {
            BaseTableView *subTableView = self.datasTableView;
            subTableView.frame = CGRectMake(kWINDOW_WIDTH*self.segmentScrollView.segControl.sectionTitles.count, 0, kWINDOW_WIDTH, subTableView.frame.size.height);
            subTableView.backgroundColor = kBACKGROUND_COLOR;
            subTableView.datas = [NSMutableArray arrayWithArray:subDatas];
            [self.segmentScrollView.segControl setSelectedSegmentIndex:self.segmentScrollView.segControl.sectionTitles.count];
            [self.segmentScrollView addViewes:@[subTableView] WithTitle:@[title] andDatas:subDatas];
            [self.segmentScrollView switchToIndex:self.segmentScrollView.segControl.sectionTitles.count-1];
            [subTableView reloadData];
        }
        else{
            NSMutableArray *titleArray =  [NSMutableArray arrayWithArray:self.segmentScrollView.segControl.sectionTitles];
            [titleArray replaceObjectAtIndex:self.cunrrentSeletItem withObject:title];
            [self.segmentScrollView.segControl setSectionTitles:titleArray];
            [self.segmentScrollView switchToIndex:self.cunrrentSeletItem+1];
            BaseTableView *tableView = self.segmentScrollView.scrollView.subviews[self.cunrrentSeletItem+1];
            tableView.datas = [NSMutableArray arrayWithArray:subDatas];
            tableView.selectedIndexPath = nil;
            [tableView reloadData];
        }
    }
}

/**
 根据已经选择了的数据设置子级数据

 @param selectedData 已经选择了的数据
 */
-(void)setSubDataWithSelectedData:(NSMutableArray *)selectedData title:(NSString *)title tableView:(BaseTableView *)currentTableView andIndexPath:(NSIndexPath *)indexPath{
    if (self.type == selectorTypeDistric) {//地区
        AddressDBDetailModel *addressModel = currentTableView.datas[indexPath.row];
        if (selectedData.count == 1) {
            self.datas     = [self.addressManager querryCitiesInfoWithProvinceId:addressModel.code];
            [self addSubLayerViewWithTitle:title AndData:self.datas];
        }
        else if (selectedData.count == 2){
            self.datas= [self.addressManager querryDistrictsInfoWithCityId:addressModel.code];
            if (self.datas.count>0) {//非直辖市，还有下一级
                [self addSubLayerViewWithTitle:title AndData:self.datas];
            }
            else{
                [self clearSlef:nil];//直辖市清理并回调数据
            }
        }
        else{
            [self clearSlef:nil];//清理并回调数据
        }
    }
    else if (self.type == selectorTypeCleander){//日期
        if (selectedData.count == 1) {
            self.datas = [NSMutableArray arrayWithArray:[self fliterDateWithDatas:[Date monthesWithYear:self.currentSelectedYear]]];
            [self addSubLayerViewWithTitle:title AndData:self.datas];
        }
        else if (selectedData.count == 2){
            NSString *yearItem = self.segmentScrollView.segControl.sectionTitles.firstObject;//xxx年
            NSString *year =[yearItem substringWithRange:NSMakeRange(0, 4)];
            self.datas = [NSMutableArray arrayWithArray:[self fliterDateWithDatas:[Date dayesWithMoth:title andYear:year]]];
            [self addSubLayerViewWithTitle:title AndData:self.datas];
        }
        else{
            [self clearSlef:nil];
        }
    }
    else{
        [self clearSlef:nil];
    }
}

/**
 设置选中标识的frame

 @param content 文字内筒
 @param imageView 选中标识
 */
-(void)setSelectedImageViewFramWithContent:(NSString *)content imageView:(KKImageView *)imageView{
    CGSize size = [content resizeWithFont:kFONT_14 adjustSize:CGSizeMake(kWINDOW_WIDTH - 2*kHORIZONT_MARGIN, kFitWithHeight(40))];
    CGRect frame = imageView.frame;
    frame.origin.x = size.width + kHORIZONT_MARGIN + 10;
    imageView.frame = frame;
}



/**
 设置选中状态的cell

 @param tableView tableview
 @param indexPath indexpath
 */
-(void)setSelectedStatusWithTableView:(BaseTableView *)tableView indexPath:(NSIndexPath *)indexPath{
    if (tableView.selectedIndexPath) {
        BaseTableViewCell *seletedCell = [tableView cellForRowAtIndexPath:tableView.selectedIndexPath];
        KKImageView *selectedImageView = [seletedCell.contentView viewWithTag:1111];
        seletedCell.textLabel.textColor = kFIRST_LEVEL_COLOR;
        selectedImageView.hidden = YES;
    }
    
    BaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    KKImageView *imageView = [cell.contentView viewWithTag:1111];
    [self setSelectedImageViewFramWithContent:cell.textLabel.text imageView:imageView];
    cell.textLabel.textColor = kNORMAL_BUTTON_COLOR;
    imageView.hidden = NO;
}


/**
 设置选中的条件的标题

 @param title 标题
 */
-(void)segMentChangeSeletedTitle:(NSString *)title{
    NSMutableArray *titles = [NSMutableArray arrayWithArray:self.segmentScrollView.segControl.sectionTitles];
    [titles replaceObjectAtIndex:self.segmentScrollView.segControl.sectionTitles.count-1 withObject:title];
    [self.segmentScrollView.segControl setSectionTitles:titles];
    [self.segmentScrollView.segControl setSelectedSegmentIndex:self.segmentScrollView.segControl.sectionTitles.count-1];
}


#pragma mark KKStarSegControlDelegate
- (void)segmentScroll:(KKSegmentScrollView*)scroll didChangePageIndex:(NSInteger)index{
    self.cunrrentSeletItem = index;
    BaseTableView *tableView = self.segmentScrollView.scrollView.subviews[index];
    self.datas = tableView.datas;
    [tableView reloadData];
    [tableView scrollToRowAtIndexPath:tableView.selectedIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];//滑动到已选择条件附近，默认0
    Print(@"self.cunrrentSeletItem:%ld-tableView:%@",self.cunrrentSeletItem,tableView);
}

/**
 重选条件，更新条件

 @param index 当前选择事件的具体项
 @param content 新选的条件
 */
-(void)reSelecteConditionWithIndex:(NSInteger)index content:(id)content{
    NSMutableArray *selectedDatas = [NSMutableArray arrayWithArray:self.segmentScrollView.segControl.sectionTitles];
    [selectedDatas replaceObjectAtIndex:index withObject:content];     //更新显示已选择的条件
    [self.selectedItems replaceObjectAtIndex:index withObject:content];//更新选择的条件
    [self.segmentScrollView.segControl setSectionTitles:selectedDatas];
}


-(void)clearSlef:(id)sender{
    NSMutableArray *selectedItem = [NSMutableArray array];
    if (self.type == selectorTypeLotteryClass || self.type == selectorTypeMerchant || self.type == selectorTypeGrid) {
        selectedItem = self.selectedItems;
    }
    else if (self.type == selectorTypeDistric){
        selectedItem = [NSMutableArray arrayWithArray:self.selectedItems];
    }
    else if (self.type == selectorTypeCleander){
        if (self.selectedItems.count>2 || self.selectedItems.count<=0) {
            selectedItem = [NSMutableArray arrayWithArray:self.selectedItems];
            self.currentSelectedYear = nil;
            self.currentSelectedMonth = nil;
        }
        else{
            [KKStarPromptBox showPromptBoxWithWords:@"日期格式不正确" toView:self];
            return;
        }
    }
    else if (self.type == selectorTypePayment){
        selectedItem = [NSMutableArray arrayWithArray:self.selectedItems];
    }
    else if (self.type == selectorTypeTerminalStatus){
        selectedItem = [NSMutableArray arrayWithArray:self.selectedItems];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clearSelectViewDelegateWithDatas:andSelectorType:)]) {
        if (![self.delegate clearSelectViewDelegateWithDatas:selectedItem andSelectorType:self.type]) {
            
        }
    }

    self.topWindow = nil;
    self.hidden = YES;
    self.backView = nil;
    [self removeFromSuperview];
}

//解决tableview点击时，事件被手势捕获的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(touch.view == self.backView){
        return YES;
    }else
        return NO;
}

-(void)cancelToSelectedItem:(id)sender{
    [self clearSlef:nil];
}


/**
 过滤日期

 @param date 已选择的日期，日期数据里面已经过滤了今天日期之后的数据
 @param isStartDate 是否为开始日期
 */
-(NSArray *)fliterDateWithDatas:(NSArray *)datas{
    NSString *year  = @"";
    NSString *month = @"";
    NSString *day   = @"";
    
    NSMutableArray *newData = [NSMutableArray array];
    self.startDate = [[NSUserDefaults standardUserDefaults] stringForKey:@"startDate"];
    self.endDate   = [[NSUserDefaults standardUserDefaults] stringForKey:@"endDate"];
    self.isStartDate = [[NSUserDefaults standardUserDefaults] boolForKey:@"isStartDate"];
    if (self.isStartDate && [NSString isBlank:self.endDate]){
        return datas;
    }
    else if(!self.isStartDate){//此时正在选择结束日期 ![NSString isBlank:self.startDate]
        year  = [self.startDate substringWithRange:NSMakeRange(0, 4)];
        month = self.startDate.length>=7? [self.startDate substringWithRange:NSMakeRange(5, 2)]:nil;
        day   = self.startDate.length>=10?[self.startDate substringWithRange:NSMakeRange(8, 2)]:nil;
        
        NSString *subject = datas.firstObject;
        if ([subject hasSuffix:@"年"]) {//正在选择年份
            for (NSInteger i= 0 ; i<datas.count; i++) {
                NSString *yearDataString = datas[i];//2017年
                NSString *yearData = [yearDataString substringToIndex:4];
                if (yearData.integerValue>=year.integerValue) {
                    [newData addObject:yearDataString];
                }
            }
        }
        else if ([subject hasSuffix:@"月"]){//正在选择月份
            if (year.integerValue < self.currentSelectedYear.integerValue) {
                return datas;//开始年份小于结束年份，则返回全部的月份数据
            }
            if ([NSString isBlank:month]) {
                return datas;
            }
            
            for (NSInteger i= 0 ; i<datas.count; i++) {
                NSString *montString = datas[i];//07月
                NSString *monthData = [montString substringToIndex:2];
                if (monthData.integerValue<=month.integerValue) {
                    [newData addObject:montString];
                }
            }
        }
        else{//正在选择日
            if(year.integerValue < self.currentSelectedYear.integerValue){
                return datas;
            }
            else if (year.integerValue == self.currentSelectedYear.integerValue && month.integerValue < self.currentSelectedMonth.integerValue) {
                return datas;
            }
            //开始月份等于结束月份，则返回全部的日子数据
            for (NSInteger i= 0 ; i<datas.count; i++) {
                NSString *dayString = datas[i];//07日
                NSString *dates = [dayString substringToIndex:2];
                if (dates.integerValue>=day.integerValue) {
                    [newData addObject:dayString];
                }
            }
        }
    }
    else if(self.isStartDate){//此时正在选择开始日期
        year  = [self.endDate substringWithRange:NSMakeRange(0, 4)];
        month = self.endDate.length>=7?[self.endDate substringWithRange:NSMakeRange(5, 2)]:nil;
        day   = self.endDate.length>=10?[self.endDate substringWithRange:NSMakeRange(8, 2)]:nil;
        NSString *subject = datas.firstObject;
        if ([subject hasSuffix:@"年"]) {//正在选择年份
            for (NSInteger i= 0 ; i<datas.count; i++) {
                NSString *yearDataString = datas[i];//2017年
                NSString *yearData = [yearDataString substringToIndex:4];
                if (yearData.integerValue<=year.integerValue) {
                    [newData addObject:yearDataString];
                }
            }
        }
        else if ([subject hasSuffix:@"月"]){//正在选择月份
            if (year.integerValue >= self.currentSelectedYear.integerValue) {
                return datas;//开始年份大于结束年份，则返回全部的月份数据
            }
            if ([NSString isBlank:month]) {
                return datas;
            }
            
            
            for (NSInteger i= 0 ; i<datas.count; i++) {
                NSString *montString = datas[i];//07月
                NSString *monthData = [montString substringToIndex:2];
                if (monthData.integerValue<=month.integerValue) {
                    [newData addObject:montString];
                }
            }
        }
        else{//正在选择日
            if (year.integerValue>self.currentSelectedYear.integerValue) {
                 return datas;
            }
            else if (year.integerValue == self.currentSelectedYear.integerValue && month.integerValue > self.currentSelectedMonth.integerValue){
                return datas;
            }
            else if ([NSString isBlank:day]){
                return datas;
            }
            //开始月份等于结束月份，则返回全部的日子数据
            for (NSInteger i= 0 ; i<datas.count; i++) {
                NSString *dayString = datas[i];//07日
                NSString *dates = [dayString substringToIndex:2];
                if (dates.integerValue<=day.integerValue) {
                    [newData addObject:dayString];
                }
            }
        }
    }
    return newData;
}


-(void)addNoti{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedDate:) name:kCHANGE_START_DATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedDate:) name:kCHANGE_END_DATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldClearDateCondition:) name:kRESET_DATE_CONDITION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFromSearch:) name:kBACK_FROM_SEARCH object:nil];
}


-(void)removeNoti{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)changeSelectedDate:(NSNotification *)noti{
    NSDictionary *dic = [noti valueForKey:@"object"];
    if ([dic.allKeys.firstObject isEqualToString:@"isStartDate"]) {
        NSString *object = dic.allValues.firstObject;
        self.isStartDate = object.integerValue;
        [[NSUserDefaults standardUserDefaults] setBool:self.isStartDate forKey:@"isStartDate"];
    }
    
    if ([dic.allKeys.firstObject isEqualToString:@"startDate"]) {
        Print(@"开始时间：%@",dic.allValues.firstObject);
        self.startDate = dic.allValues.firstObject;
        self.startDate = [Date convertDateStringToFriendDateString:self.startDate];
        [[NSUserDefaults standardUserDefaults] setObject:self.endDate forKey:@"endDate"];
        [[NSUserDefaults standardUserDefaults] setObject:self.startDate forKey:@"startDate"];
    }
    else if ([dic.allKeys.firstObject isEqualToString:@"endDate"]) {
       Print(@"结束时间：%@",dic.allValues.firstObject);
        self.endDate = dic.allValues.firstObject;
        self.endDate = [Date convertDateStringToFriendDateString:self.endDate];
        [[NSUserDefaults standardUserDefaults] setObject:self.startDate forKey:@"startDate"];
        [[NSUserDefaults standardUserDefaults] setObject:self.endDate forKey:@"endDate"];
    }
}

-(void)shouldClearDateCondition:(NSNotification *)noti{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"startDate"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"endDate"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isStartDate"];
}

-(void)backFromSearch:(NSNotification *)noti{
    self.currentSelectedYear = nil;
    self.currentSelectedMonth = nil;
    [SelectorView clearData];
}

-(void)currentSelectedDateComponent:(NSString *)title{
    if ([title hasSuffix:@"年"]) {
        self.currentSelectedYear = title;
    }
    else if ([title hasSuffix:@"月"]){
        self.currentSelectedMonth = title;
    }
}

+(void)clearData{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"startDate"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"endDate"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isStartDate"];
}


//终端状态 n-0 断网； h-21 机头锁定； h-3 机头无票； h-2 机头缺票； t-1 熄屏维护； t-0 熄屏； t-3亮屏维护；s-1 正常；
-(NSString *)statusFromStatusString:(NSString *)statusString{
    if ([statusString isEqualToString:@"n-0"]) {
        return @"断网";
    }
    else if ([statusString isEqualToString:@"h-21"]){
        return @"机头锁定";
    }
    else if ([statusString isEqualToString:@"h-3"]){
        return @"机头无票";
    }
    else if ([statusString isEqualToString:@"h-2"]){
        return @"机头缺票";
    }
    else if ([statusString isEqualToString:@"t-1"]){
        return @"熄屏维护";
    }
    else if ([statusString isEqualToString:@"t-0"]){
        return @"熄屏";
    }
    else if ([statusString isEqualToString:@"t-3"]){
        return @"亮屏维护";
    }
    else if ([statusString isEqualToString:@"s-1"]){
        return @"正常";
    }
    else{
        return @"";
    }
}

/**
 获取已选择条件的索引

 @param object 已选择的条件
 @param datas 条件集合
 @param type 当前筛选器的类型
 @return 已选择条件的索引
 */
-(NSInteger)getSelectedIndexWithObject:(id)object andDatas:(NSArray *)datas type:(selectorType)type{
    NSInteger index = -1;
    if (type == selectorTypeDistric) {
        for (NSInteger i=0; i<datas.count; i++) {
            AddressDBDetailModel *addressModel = datas[i];
            if ([addressModel.name isEqualToString:object]) {
                index = i;
                break;
            }
        }
    }
    else if (type == selectorTypeCleander){
        for (NSInteger i=0; i<datas.count; i++) {
            NSString *dateComponent = datas[i];
            if ([dateComponent isEqualToString:object]) {
                index = i;
                break;
            }
        }
    }
    else if (type == selectorTypeLotteryClass){
        for (NSInteger i=0; i<datas.count; i++) {
            SearchLotteryCalssesModel *subModel = datas[i];
            if ([subModel.lotteryClassName isEqualToString:object]) {
                index = i;
                break;
            }
        }
    }
    else if (type == selectorTypeTerminalStatus){
        index = [datas indexOfObject:object];
    }
    else if (type == selectorTypeGrid){
        for (NSInteger i=0; i<datas.count; i++) {
            SearchGridModel *subModel = datas[i];
            if ([subModel.gridName isEqualToString:object]) {
                index = i;
                break;
            }
        }
    }
    else if (type == selectorTypeMerchant){
        for (NSInteger i=0; i<datas.count; i++) {
            SearchMerchantModel *subModel = datas[i];
            if ([subModel.merchantName isEqualToString:object]) {
                index = i;
                break;
            }
        }
    }
    else if (type == selectorTypePayment){
        
    }
    return index;
}

-(NSMutableArray *)getStatusDataWithStatus:(NSString *)status{
    NSMutableArray *array = [NSMutableArray array];
    NSString *statusString = [self statusFromStatusString:status];
    [array addObject:statusString];
    return array;
}

-(void)dealloc{
    self.currentSelectedYear = nil;
    self.currentSelectedMonth = nil;
}

@end
