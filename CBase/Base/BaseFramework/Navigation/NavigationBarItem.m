//
//  NavigationBarItem.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/3.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "NavigationBarItem.h"

typedef void(^OperateBlock)();

@interface NavigationBarItem ()

@property(nonatomic,strong)OperateBlock block;

@end

@implementation NavigationBarItem
//+(instancetype)shareButtonItem{
//    static NavigationBarItem *shareItem = nil;
//    
//    static dispatch_once_t once;
//    
//    dispatch_once(&once, ^{
//        shareItem = [NavigationBarItem new];
//    });
//    
//    return shareItem;
//}

-(UIBarButtonItem *)getItemWithItemStyle:(NavigationBarStyle)style andDelegate:(id<NavigationBardelegate>)delegate{
    _delegate = delegate;
    switch (style) {
        case NavigationBarStyleLeft:
        {
            return self.leftItem;
        }
            break;
        case NavigationBarStyleQRCode:
        {
            return self.qRCodeItem;
        }
            break;
        case NavigationBarStyleSearch:
        {
            return self.searchItem;
        }
            break;
        case NavigationBarStylePhone:
        {
            return self.phoneItem;
        }
            break;
        case NavigationBarStyleMessage:
        {
            return self.messageItem;
        }
            break;
        case NavigationBarStyleSetting:
        {
            return self.settingItem;
        }
            break;
        default:
            return self.leftItem;
            break;
    }
}

-(UIBarButtonItem *)getItemWithItemStyle:(NavigationBarStyle)style withBlock:(void(^)(void))handler{
    UIBarButtonItem *item =  [self getItemWithItemStyle:style andDelegate:nil];
    self.block = handler;
    return item;
}

-(UIBarButtonItem *)leftItem{
    UIImage *backButtonImage = [kImageName(@"nav_back") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _leftItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(leftTarget:)];
    _leftItem.tintColor = kBACKGROUND_COLOR;
    return _leftItem;
}

-(UIBarButtonItem *)qRCodeItem{
    UIImage *backButtonImage = [kImageName(@"scan_icon") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _qRCodeItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(qRcodeScane:)];
    _qRCodeItem.tintColor = kBACKGROUND_COLOR;
    return _qRCodeItem;
}

-(UIBarButtonItem *)searchItem{
    if (!_searchItem) {
        UIImage *backButtonImage = [kImageName(@"search_icon") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _searchItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(searchTarget:)];
        _searchItem.tintColor = kBACKGROUND_COLOR;
    }
    return _searchItem;
}

-(UIBarButtonItem *)phoneItem{
    UIImage *backButtonImage = [kImageName(@"setting_call_icon") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _phoneItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(callPhone:)];
    _phoneItem.tintColor = kBACKGROUND_COLOR;
    return _phoneItem;
}

-(UIBarButtonItem *)messageItem{
    UIImage *backButtonImage = [kImageName(@"message_icon") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _messageItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(messageTarget:)];
    _messageItem.tintColor = kBACKGROUND_COLOR;
    return _messageItem;
}

-(UIBarButtonItem *)settingItem{
    UIImage *backButtonImage = [kImageName(@"setting_icon") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _settingItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(settingTarget:)];
    _settingItem.tintColor = kBACKGROUND_COLOR;
    return _settingItem;
}

-(UIBarButtonItem *)unknownItem{
    UIImage *backButtonImage = [kImageName(@"nav_back") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _unknownItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(attachementTarget:)];
    _unknownItem.tintColor = kFIRST_LEVEL_COLOR;
    return _unknownItem;
}


-(void)leftTarget:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStyleLeft];
    }
}

-(void)qRcodeScane:(id)sender{
    if (self.block) {
        self.block();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStyleQRCode];
    }
}

-(void)searchTarget:(id)sender{
    if (self.block) {
        self.block();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStyleSearch];
    }
}

-(void)callPhone:(id)sender{
    if (self.block) {
        self.block();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStylePhone];
    }
}

-(void)messageTarget:(id)sender{
    if (self.block) {
        self.block();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStyleMessage];
    }
}

-(void)settingTarget:(id)sender{
    if (self.block) {
        self.block();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStyleSetting];
    }
}

-(void)attachementTarget:(id)sender{
    if (self.block) {
        self.block();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStyleLeft];
    }
}

-(void)backTarget:(id)sender{
    if (self.block) {
        self.block();
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionWithStyle:)]) {
        [self.delegate actionWithStyle:NavigationBarStyleLeft];
    }
}
@end
