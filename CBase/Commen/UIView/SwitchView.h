//
//  SwitchView.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/13.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchView : UISwitch

@property(nonatomic,strong)NSIndexPath *indexPath;

-(instancetype)initWithFrame:(CGRect)frame;

-(instancetype)initWithFrame:(CGRect)frame andIndexPath:(NSIndexPath *)indexPath;



@end
