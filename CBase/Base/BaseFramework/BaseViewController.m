//
//  BaseViewController.m
//  TMKJ_Merchant
//
//  Created by 刘合鹏 on 2017/6/6.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property(nonatomic,strong)UIBarButtonItem *leftItem;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout=UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars=NO;
//    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
}

-(UIBarButtonItem *)leftItem{
    UIImage *backButtonImage = [kImageName(@"nav_back") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    backButtonImage = [backButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _leftItem = [[UIBarButtonItem alloc]initWithImage:backButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(popViewController)];
    _leftItem.tintColor = kBACKGROUND_COLOR;
    return _leftItem;
}


+(void)jumpFromSourceViewController:(UIViewController *)sourceViewController  ToViewController:(UIViewController *)toViewController{
    
    if (!toViewController) {
        return;
    }
    
    if (!toViewController.hidesBottomBarWhenPushed) {
        toViewController.hidesBottomBarWhenPushed = YES;
    }
    
    [sourceViewController.navigationController pushViewController:toViewController animated:YES];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    return  [self.navigationController popViewControllerAnimated:true];
    
}

-(void)popViewController {
    [self popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
