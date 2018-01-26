//
//  BaseTableViewCell.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TableViewProtocol.h"

@implementation BaseTableViewCell

+(BaseTableViewCell *)tableView:(BaseTableView *)tableView model:(id)model
{
    NSString *cellClassName = [BaseModel cellNameWithModel:model];
    if (![NSString isBlank:cellClassName]) {
        Class c = NSClassFromString(cellClassName);
        BaseTableViewCell<TableViewProtocol> *cell = [c cellWithTableView:tableView];
        [cell configCellWithModel:model];
        return cell;
    }
    return nil;
}

+(BaseTableViewCell *)tableView:(BaseTableView *)tableView datas:(NSArray *)datas;
{
    id model = datas.firstObject;
    NSString *cellClassName = [BaseModel cellNameWithModel:model];
    if (![NSString isBlank:cellClassName]) {
        Class c = NSClassFromString(cellClassName);
        BaseTableViewCell<TableViewProtocol> *cell = [c cellWithTableView:tableView];
        cell.datas = model;
        [cell configCellWithDatas:datas];
        return cell;
    }
    return nil;
}


+(BaseTableViewCell *)tableView:(BaseTableView *)tableView model:(id)model indexPath:(NSIndexPath *)indexPath
{
    NSString *cellClassName = [BaseModel cellNameWithModel:model];
    if (![NSString isBlank:cellClassName]) {
        Class c = NSClassFromString(cellClassName);
        BaseTableViewCell<TableViewProtocol> *cell = [c cellWithTableView:tableView];
        [cell configCellWithModel:model indexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
