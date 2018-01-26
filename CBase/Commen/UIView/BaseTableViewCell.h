//
//  BaseTableViewCell.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,strong)BaseModel *datas;
/**
 *  获取tableViewCell
 *
 *  @param model     model
 *  @param tableView tableView
 *
 *  @return
 */
+(BaseTableViewCell *)tableView:(UITableView *)tableView model:(id)model;


/**
 获取tableViewCell

 @param tableView tableView
 @param datas 数据源
 @return 对应的cell
 */
+(BaseTableViewCell *)tableView:(UITableView *)tableView datas:(NSArray *)datas;


/**
 获取tableViewCell

 @param tableView tableView
 @param model model
 @param indexPath indexPath
 @return 对应的cell
 */
+(BaseTableViewCell *)tableView:(UITableView *)tableView model:(id)model indexPath:(NSIndexPath *)indexPath;

/**
 配置cell的数据

 @param model 数据
 */
-(void)configCellWithModel:(id)model;


/**
 配置cell的数据

 @param datas 批量一次性配置cell的数据
 */
-(void)configCellWithDatas:(NSArray *)datas;


/**
 配置cell的数据

 @param model 数据
 @param indexPath indexPath
 */
-(void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath;

@end
