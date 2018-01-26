//
//  BaseTableView.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import "BaseTableViewCell.h"


typedef NS_ENUM(NSInteger,cellType){
    cellTypeNormal,
    
};


typedef enum : NSUInteger {
    NeedRefreshControlNonoe,  //都不需要
    NeedRefreshControlRefresh,//需要下拉刷新
    NeedRefreshControlLoad,   //需要上拉加载
    NeedRefreshControlAll,    //都需要
} NeedRefreshControl;

typedef enum : NSUInteger {
    refreshOperationRefresh,//下拉刷新
    refreshOperationLoad,   //上拉加载
    refreshOperationNormal  //beginRefresh
} RefreshOperation;

typedef void(^RefreshControlAction)(NSDictionary *parames);

@interface BaseTableView : UITableView 

@property (nonatomic,assign)NeedRefreshControl needRefreshControl;//需要的刷新控件类型

@property (nonatomic,strong)NSMutableArray *datas;

@property (nonatomic,strong)NSIndexPath *selectedIndexPath;

@property (nonatomic,strong)RefreshControlAction refrshAction;//刷新事件

@property (nonatomic,strong)RefreshControlAction loadAction;  //加载事件

@property (nonatomic,strong)NSDictionary *params;
@end
