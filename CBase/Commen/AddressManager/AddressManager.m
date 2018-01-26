//
//  AdressManager.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/28.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "AddressManager.h"

static NSString *addressDBPath = nil;
static FMDatabase *addressDB;

@interface AddressManager ()

@property (nonatomic,strong)BMKLocationService *locationService;

@property (nonatomic,strong)AddressLocateCompleteBlock resultBlock;

@property (nonatomic,assign)BOOL located;


@end

@implementation AddressManager

-(void)setProvinces:(NSArray *)provinces{
    _provinces = provinces;
}


-(void)addresses{
    AddressManager *manager = [AddressManager shareInstance];
    NSArray <AddressDBDetailModel *>*provinces = [manager querryProvincesInfo];
    manager.provinces = provinces;
    
    AddressDBDetailModel *provinceModel = provinces.firstObject;
    NSArray <AddressDBDetailModel *>*cities = [manager querryCitiesInfoWithProvinceId:provinceModel.code];
    manager.cities = cities;
    
    AddressDBDetailModel *cityModel = cities.firstObject;
    NSArray <AddressDBDetailModel *>*districts = [manager querryDistrictsInfoWithCityId:cityModel.code];
    manager.districts = districts;
}

+(instancetype)shareInstance{
    static AddressManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [AddressManager new];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"adressdb" ofType:@"db"];
        addressDB = [FMDatabase databaseWithPath:path];
    });
    return instance;
}


-(NSMutableArray <AddressDBDetailModel *>*)querryProvincesInfo{
    if ([addressDB open]) {
        NSMutableArray *provinceArray = [NSMutableArray array];
        FMResultSet *provinceSet= [addressDB executeQuery:@"SELECT * FROM com_wjy_db_Adress WHERE pcode = 'china'"];
        while ([provinceSet next]) {
            AddressDBDetailModel *model = [AddressDBDetailModel new];
            model.name = [provinceSet stringForColumn:@"name"];
            model.addressId = [provinceSet intForColumn:@"id"];
            model.code = [provinceSet intForColumn:@"code"];
            model.pcode = [provinceSet intForColumn:@"pcode"];
            [provinceArray addObject:model];
        }
        return provinceArray;
    }
    else{
        NSAssert(true, @"打开数据库失败");
        return nil;
    }
}

-(NSMutableArray <AddressDBDetailModel *>*)querryCitiesInfoWithProvinceId:(NSInteger)provinceId{
    if ([addressDB open]) {
        NSMutableArray *cityArrary = [NSMutableArray array];//110000 北京，120000 天津市，550000 重庆市，310000 上海市，810000 香港，820000 澳门，710000 台湾
        if (provinceId == 110000 || provinceId ==120000 || provinceId ==310000 ||  provinceId ==550000 || provinceId == 810000 || provinceId == 820000 || provinceId ==710000 ) {
            NSMutableArray *citySubItem = [NSMutableArray arrayWithArray:[self querySubItemWithItemID:provinceId]];
            for (AddressDBDetailModel *detailModel in citySubItem) {
                FMResultSet *cityResult = [addressDB executeQuery:@"SELECT * FROM com_wjy_db_Adress WHERE pcode = ?",@(detailModel.code)];
                while ([cityResult next]) {
                    AddressDBDetailModel *model = [AddressDBDetailModel new];
                    model.name = [cityResult stringForColumn:@"name"];
                    model.addressId = [cityResult intForColumn:@"id"];
                    model.code = [cityResult intForColumn:@"code"];
                    model.pcode = [cityResult intForColumn:@"pcode"];
                    [cityArrary addObject:model];
                }
            }
            
            AddressDBDetailModel *cityAllModle = [AddressDBDetailModel new];
            cityAllModle.name=@"全部";
            cityAllModle.pcode = kAll_Dictrict_Code;
            cityAllModle.code  = kAll_Dictrict_Code;
            cityAllModle.addressId = kAll_Dictrict_Code;
            [cityArrary insertObject:cityAllModle atIndex:0];
            return cityArrary;
        }
        else{
            FMResultSet *cityResult = [addressDB executeQuery:@"SELECT * FROM com_wjy_db_Adress WHERE pcode = ?",@(provinceId)];
            while ([cityResult next]) {
                AddressDBDetailModel *model = [AddressDBDetailModel new];
                model.name = [cityResult stringForColumn:@"name"];
                model.addressId = [cityResult intForColumn:@"id"];
                model.code = [cityResult intForColumn:@"code"];
                model.pcode = [cityResult intForColumn:@"pcode"];
                [cityArrary addObject:model];
            }
        }
        if (cityArrary.count>0) {
            AddressDBDetailModel *cityAllModle = [AddressDBDetailModel new];
            cityAllModle.name=@"全部";
            cityAllModle.pcode = kAll_Dictrict_Code;
            cityAllModle.code  = kAll_Dictrict_Code;
            cityAllModle.addressId = kAll_Dictrict_Code;
            [cityArrary insertObject:cityAllModle atIndex:0];
        }
        return cityArrary;
    }
    else{
        NSAssert(true, @"打开数据库失败");
        return nil;
    }
}

-(NSMutableArray <AddressDBDetailModel *>*)querryDistrictsInfoWithCityId:(NSInteger)cityId{
    if ([addressDB open]) {
        NSMutableArray *districtArray = [NSMutableArray array];
        FMResultSet *cityResult = [addressDB executeQuery:@"SELECT * FROM com_wjy_db_Adress WHERE pcode = ?",@(cityId)];
        while ([cityResult next]) {
            AddressDBDetailModel *model = [AddressDBDetailModel new];
            model.name = [cityResult stringForColumn:@"name"];
            model.addressId = [cityResult intForColumn:@"id"];
            model.code = [cityResult intForColumn:@"code"];
            model.pcode = [cityResult intForColumn:@"pcode"];
            if (![model.name isEqualToString:@"市辖区"]) {
                [districtArray addObject:model];
            }
        }
        if (districtArray.count>0) {//如果还有子地区的话，就加
            AddressDBDetailModel *districtAllModle = [AddressDBDetailModel new];
            districtAllModle.name=@"全部";
            districtAllModle.pcode = kAll_Dictrict_Code;
            districtAllModle.code  = kAll_Dictrict_Code;
            districtAllModle.addressId = kAll_Dictrict_Code;
            [districtArray insertObject:districtAllModle atIndex:0];
        }
        return districtArray;
    }
    else
    {
        NSAssert(true, @"打开数据库失败");
        return nil;
    }
}

-(NSMutableArray <AddressDBDetailModel *> *)querySubItemWithItemID:(NSInteger)itemID{
    if ([addressDB open]) {
        NSMutableArray *itemArray = [NSMutableArray array];
        FMResultSet *itemResult = [addressDB executeQuery:@"SELECT * FROM com_wjy_db_Adress WHERE pcode = ?",@(itemID)];
        while ([itemResult next]) {
            AddressDBDetailModel *model = [AddressDBDetailModel new];
            model.name = [itemResult stringForColumn:@"name"];
            model.addressId = [itemResult intForColumn:@"id"];
            model.code = [itemResult intForColumn:@"code"];
            model.pcode = [itemResult intForColumn:@"pcode"];
            [itemArray addObject:model];
        }
        return itemArray;
    }
    else{
        NSAssert(true, @"打开数据库失败");
        return nil;
    }
}

-(AddressDBDetailModel *)querryAddressDBModelWithName:(NSString *)name{
    if ([name isEqualToString:@"全部"]) {
        return nil;
    }
    else if ([NSString isBlank:name]){
        return nil;
    }
    else{
        if ([addressDB open]) {
            FMResultSet *itemResult = [addressDB executeQuery:@"SELECT * FROM com_wjy_db_Adress WHERE name = ?",name];
            AddressDBDetailModel *model = [AddressDBDetailModel new];
            while ([itemResult next]) {
                model.name = [itemResult stringForColumn:@"name"];
                model.addressId = [itemResult intForColumn:@"id"];
                model.code = [itemResult intForColumn:@"code"];
                model.pcode = [itemResult intForColumn:@"pcode"];
            }
            return model;
        }
        else{
            return nil;
        }
    }
}



/**
 是否为直辖市，包括台湾，澳门，香港

 @param model 市区地址信息模型
 @return 是否为直辖市
 */
-(BOOL)isMunicipality:(AddressDBDetailModel *)model{
    NSInteger provinceId = model.code;
    if (provinceId == 110000 || provinceId ==120000 || provinceId ==310000 ||  provinceId ==550000 || provinceId == 810000 || provinceId == 820000 || provinceId ==710000 ){
        return YES;
    }
    else{
        return NO;
    }
}


#pragma mark BMKLocationServiceDelegate
-(void)locateUserAddressWithCompleteBlock:(AddressLocateCompleteBlock)resultBlock{
    self.locationService = [[BMKLocationService alloc]init];
    self.locationService.delegate = self;
    self.locationService.desiredAccuracy = kCLLocationAccuracyBest;
    self.resultBlock = resultBlock;
    [self.locationService startUserLocationService];
}

-(void)getAddressWithLocation:(BMKUserLocation *)userLocation{
    BMKGeoCodeSearch *location = [[BMKGeoCodeSearch alloc]init];
    location.delegate = self;
    BMKReverseGeoCodeOption *option = [BMKReverseGeoCodeOption new];
    option.reverseGeoPoint = userLocation.location.coordinate;
    [location reverseGeoCode:option];//结果转到回调函数获取
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    Print(@"userLocation.heading:%@",userLocation.heading);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    Print(@"userLocation.location:%@",userLocation.location);
    [self getAddressWithLocation:userLocation];
    [self.locationService stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    Print(@"userLocation:定位失败%@",error);
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        self.locateAddress = [[AddressDetailModel alloc]initWithBMKAddressComponent:result.addressDetail];
        self.resultBlock(self.locateAddress);
        [self.locationService stopUserLocationService];
    }
    else{
        Print(@"地址反编码失败");
    }
}



@end




@implementation AddressProvinceDetailModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.addressId = super.addressId;
        self.code  = super.code;
        self.name  = super.name;
        self.pcode = super.pcode;
    }
    return self;
}

@end


@implementation AddressCityDetailModel



@end


@implementation AddressDistricDetailModel



@end


@implementation AddressDetailModel

-(instancetype)initWithBMKAddressComponent:(BMKAddressComponent *)addressComponent{
    self = [super init];
    if (self) {
        self.streetNumber = addressComponent.streetNumber;
        self.streetName = addressComponent.streetName;
        self.district = addressComponent.district;
        self.city = addressComponent.city;
        self.province = addressComponent.province;
        self.country = addressComponent.country;
        self.countryCode = addressComponent.countryCode;
        self.adCode = addressComponent.adCode;
        if ([self.province isEqualToString:self.city]) {
            self.city = @"";
        }
        
    }
    return self;
}

@end


@implementation AddressDBDetailModel



@end



