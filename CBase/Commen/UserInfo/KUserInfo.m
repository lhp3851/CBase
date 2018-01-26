//
//  KKStarUserInfo.m
//  KKStarZone
//
//  Created by TinySail on 15/11/21.
//  Copyright (c) 2015年 kankan. All rights reserved.
//

#import "KUserInfo.h"
#import "MJExtension.h"

@implementation KUserInfo

singleton_implementation(KUserInfo);

-(id)initWithDictionary:(NSDictionary *)jsonDictionary{
    self=[super init];
    if (self) {
        self = [KUserInfo mj_objectWithKeyValues:jsonDictionary];
    }
    return self;
}

//退出登录销毁
+ (void)attemptDealloc{
    if (_instance!=nil){
        _instance=nil;
    }
    return;
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    MJPropertyType *type = property.type;
    Class typeClass = type.typeClass;
    if (type.typeClass) {
        //对象类型
        if ([oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {
            if (typeClass == [NSString class]) {
                return @"";
            }else if (typeClass == [NSDictionary class])
            {
                return [NSDictionary dictionary];
            }else if (typeClass == [NSArray class])
            {
                return [NSArray array];
            }
            else
                return oldValue;
        }
        else
            return oldValue;
    }
    else
    {
        if (oldValue != 0) {
            return oldValue;
        }
        return 0;
    }
}






@end
