//
//  BaseTableView.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        _datas = [NSMutableArray array];
    }
    return self;
}

-(void)setDatas:(NSMutableArray *)datas{
    _datas = datas;
}

-(void)setNeedRefreshControl:(NeedRefreshControl)needRefreshControl{
    __weak typeof (self) weakself = self;
    if (needRefreshControl == NeedRefreshControlAll) {
        _needRefreshControl = needRefreshControl;
        self.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRefreshOperate:refreshOperationRefresh];
        }];
        self.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRefreshOperate:refreshOperationLoad];
        }];
    }
    else if (needRefreshControl == NeedRefreshControlRefresh){
        self.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRefreshOperate:refreshOperationRefresh];
        }];
    }
    else if (needRefreshControl == NeedRefreshControlLoad){
        self.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRefreshOperate:refreshOperationLoad];
        }];
    }
    else{
        self.mj_header = nil;
        self.mj_footer = nil;
    }
}

-(void)loadDataWithRefreshOperate:(RefreshOperation)refreshState{
    __weak typeof(self) weakself = self;
    if (self.params ==nil) {
        return;
    }
    if (refreshState == refreshOperationNormal) {
        Print(@"进入页面");
        if (self.mj_header) {
            self.refrshAction(weakself.params);
        }
    }
    else if (refreshState == refreshOperationLoad) {
        Print(@"加载页面");
        if (self.mj_footer ) {
            self.loadAction(weakself.params);
        }
    }
    else{
        Print(@"刷新页面");
        if (self.mj_header ) {
            self.refrshAction(weakself.params);
        }
    }
}



@end
