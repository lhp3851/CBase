//
//  SearchParamModel.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/7/1.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchGridModel : NSObject
@property(nonatomic,strong)NSString *gridId;
@property(nonatomic,strong)NSString *gridName;
@property(nonatomic,strong)NSString *gridNameShort;
@end


@interface SearchLotteryCalssesModel : NSObject
@property(nonatomic,assign)NSUInteger faceAmount;
@property(nonatomic,strong)NSString * lotteryClassCode;
@property(nonatomic,strong)NSString * lotteryClassId;
@property(nonatomic,strong)NSString * lotteryClassName;
@end

@interface SearchMerchantModel : NSObject
@property(nonatomic,strong)NSString *merchantId;
@property(nonatomic,strong)NSString *merchantName;
@end


@class SearchGridModel,SearchMerchantModel,SearchMerchantModel;

@interface SearchParamModel : NSObject

singleton_interface(SearchParamModel)

@property(nonatomic,strong)NSMutableArray <SearchGridModel *> *grid;

@property(nonatomic,strong)NSMutableArray <SearchLotteryCalssesModel *> *lotteryClasse;

@property(nonatomic,strong)NSMutableArray <SearchMerchantModel *> *merchant;

@end
