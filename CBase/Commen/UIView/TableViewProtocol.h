//
//  TableViewProtocol.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BaseTableView;
@class BaseModel;

@protocol TableViewProtocol <NSObject>

@required

+(__kindof UITableViewCell *)cellWithTableView:(BaseTableView *)tableView;


@optional

+(CGFloat)cellHeightWithModel:(BaseModel *)model;

@end


