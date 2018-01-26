//
//  AdressManager.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/28.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "FMDB.h"

@class AddressDBDetailModel;
@class AddressDetailModel;


typedef void(^AddressLocateCompleteBlock)(AddressDetailModel *model);

@interface AddressManager : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)AddressDetailModel *locateAddress;//定位的位置信息

@property(nonatomic,strong)NSArray *provinces;

@property(nonatomic,strong)NSArray *cities;

@property(nonatomic,strong)NSArray *districts;


+(instancetype)shareInstance;


/**
 获取定位位置信息
 */
-(void)locateUserAddressWithCompleteBlock:(AddressLocateCompleteBlock)resultBlock;


/**
 获取所有地址信息
 */
-(void)addresses;

/**
 查询所有省份信息

 @return 所有省份的数组
 */
-(NSMutableArray <AddressDBDetailModel *>*)querryProvincesInfo;

/**
 查询省辖所有市的信息

 @param provinceId 省份ID
 @return 所有该省的所有市的信息数组
 */
-(NSMutableArray <AddressDBDetailModel *>*)querryCitiesInfoWithProvinceId:(NSInteger)provinceId;

/**
 查询市辖所有县、区的信息

 @param cityId 市ID
 @return 所有该市的地区、县信息数组
 */
-(NSMutableArray <AddressDBDetailModel *>*)querryDistrictsInfoWithCityId:(NSInteger)cityId;


/**
 根据省市区名称查找并返回省市区信息模型

 @param name 名称
 @return 位置信息模型
 */
-(AddressDBDetailModel *)querryAddressDBModelWithName:(NSString *)name;

//是否为直辖市
-(BOOL)isMunicipality:(AddressDBDetailModel *)model;
@end


@interface AddressDBDetailModel : NSObject
@property(nonatomic,assign)NSInteger addressId;
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger pcode;
@end

@interface AddressDetailModel : NSObject //参照百度模型
/// 街道号码
@property (nonatomic, strong) NSString* streetNumber;
/// 街道名称
@property (nonatomic, strong) NSString* streetName;
/// 区县名称
@property (nonatomic, strong) NSString* district;
/// 城市名称
@property (nonatomic, strong) NSString* city;
/// 省份名称
@property (nonatomic, strong) NSString* province;
/// 国家
@property (nonatomic, strong) NSString* country;
/// 国家代码
@property (nonatomic, strong) NSString* countryCode;
/// 行政区域编码
@property (nonatomic, strong) NSString* adCode;

-(instancetype)initWithBMKAddressComponent:(BMKAddressComponent *)addressComponent;

@end



@class AddressCityDetailModel;
@interface AddressProvinceDetailModel : AddressDBDetailModel

@property(nonatomic,strong)AddressCityDetailModel *cityModel;

@end


@class AddressDistricDetailModel;
@interface AddressCityDetailModel : AddressProvinceDetailModel

@property(nonatomic,strong)AddressDistricDetailModel *districtModel;

@end


@interface AddressDistricDetailModel : AddressCityDetailModel

@end







