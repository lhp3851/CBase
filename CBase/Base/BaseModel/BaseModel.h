//
//  BaseModel.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSDictionary *cellClassNameAndModel;

@interface BaseModel : NSObject

@property (nonatomic, assign)NSInteger rtn;
@property (nonatomic, strong)NSString *message;
@property (nonatomic, strong)id data;



/**
 根据model返回cell名
 
 @param model 数据模型
 @return cell名字
 */
+(NSString *)cellNameWithModel:(BaseModel *)model;

@end
