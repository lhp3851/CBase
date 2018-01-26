//
//  CommenView.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/17.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommenView : UIView

@property (nonatomic,strong)KKImageView *arrowImageView;

@property (nonatomic,strong)KKButton *longButton;

@property (nonatomic,strong)KKLabel *longLabel;

+(instancetype)shareInstance;

@end
