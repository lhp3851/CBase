//
//  AccountModel.h
//  CBase
//
//  Created by Jerry on 26/01/2018.
//  Copyright © 2018 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface AccountModel : BaseModel

@property(nonatomic,strong)NSString *loginId;
@property(nonatomic,strong)NSString *sessionId;
@property(nonatomic,strong)NSString *loginName;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *logins;
@property(nonatomic,strong)NSString *staffId;
@property(nonatomic,strong)NSString *staffName;
@property(nonatomic,strong)NSString *roleId;
@property(nonatomic)float ts;


@end
