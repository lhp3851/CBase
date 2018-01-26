//
//  NavigationBarItem.h
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSInteger, NavigationBarStyle){
    ///left
    NavigationBarStyleLeft,   //返回
    
    NavigationBarStyleQRCode, //二维码
    
    NavigationBarStyleSearch, //搜索
    
    NavigationBarStylePhone,  //电话
    
    ///right
    NavigationBarStyleMessage,//消息
    
    NavigationBarStyleSetting //设置
};


@protocol NavigationBardelegate <NSObject>

@optional

-(void)actionWithStyle:(NavigationBarStyle)style;

@end

@interface NavigationBarItem : UIBarButtonItem

//+(instancetype)shareButtonItem;

@property (nonatomic,strong)UIBarButtonItem *leftItem;

@property (nonatomic,strong)UIBarButtonItem *qRCodeItem;

@property (nonatomic,strong)UIBarButtonItem *searchItem;

@property (nonatomic,strong)UIBarButtonItem *phoneItem;

@property (nonatomic,strong)UIBarButtonItem *messageItem;

@property (nonatomic,strong)UIBarButtonItem *settingItem;

@property (nonatomic,strong)UIBarButtonItem *unknownItem;

@property (nonatomic,strong)id <NavigationBardelegate> delegate;

-(UIBarButtonItem *)getItemWithItemStyle:(NavigationBarStyle)style andDelegate:(id<NavigationBardelegate>)delegate;

-(UIBarButtonItem *)getItemWithItemStyle:(NavigationBarStyle)style withBlock:(void(^)(void))handler;

@end
