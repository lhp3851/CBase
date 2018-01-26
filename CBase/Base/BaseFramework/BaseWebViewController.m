//
//  BaseWebViewController.m
//  TMKJ_Merchant
//
//  Created by Jerry on 2017/12/5.
//  Copyright © 2017年 TMWL. All rights reserved.
//

#import "BaseWebViewController.h"
#import "SGWebView.h"
#import "QRCodeViewController.h"
#import "AccountTool.h"

@interface BaseWebViewController ()<SGWebViewDelegate>
@property(nonatomic,strong)SGWebView *reslutWebView;
@property(nonatomic,strong)NSString *fileName;
@property(nonatomic,strong)NSString *directory;
@property(nonatomic,strong)NSString *lotteryPackageCode;
@end

@implementation BaseWebViewController

-(instancetype)initWithFileName:(NSString *)fileName subDirectory:(NSString *)subDirectory lotteryCode:(NSString*)lotteryCode{
    self = [super init];
    self.fileName = fileName;
    self.directory = subDirectory;
    self.lotteryPackageCode = lotteryCode;
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPannel];
    [self canClearLocalStroage];
    [self initData];
}

-(void)initData{
    NSURL *ulr = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:@"html" subdirectory:self.directory];
    NSURLRequest *request = [NSURLRequest requestWithURL:ulr];
    [self.reslutWebView loadRequest:request];
}

-(void)initPannel{
    self.view.backgroundColor=kBACKGROUND_DEEP_COLOR;
    [self.view addSubview:self.reslutWebView];
}

-(SGWebView *)reslutWebView{
    if (!_reslutWebView) {
        CGPoint point ={0,0};
        CGSize size = {kWINDOW_WIDTH,kWINDOW_HEIGHT};
        CGRect frame = {point,size};
        _reslutWebView = [[SGWebView alloc]initWithFrame:frame viewController:self];
        _reslutWebView.SGQRCodeDelegate = self;
        _reslutWebView.progressViewColor = kWARNING_COLOR;
    }
    return _reslutWebView;
}

-(void)webViewDidStartLoad:(SGWebView *)webView{
//    NSDictionary *dic= @{@"qrcode":self.lotteryPackageCode};//
//    [webView invokeJavascriptWithParam:dic function:@"getQrcode"];
}

- (void)webView:(SGWebView *)webView didFinishLoadWithURL:(NSURL *)url{
    self.navigationItem.title = webView.navigationItemTitle;
}

/** 传参数给 Javascript */
- (void)postBackJavascript:(SGWebView *)webView message:(WKScriptMessage *)message{
    Print(@"webView:%@--body:%@--frameInfo:%@",webView,message.body,message.frameInfo);
    NSDictionary *dic= [NSDictionary dictionaryWithDictionary:message.body];
    NSString *code = dic[@"qrcode"];
    
    if (![NSString isBlank:code] && [code isEqualToString:@"qrcodeValue"]) {
        NSString *userId    = [NSString stringWithString:[KUserInfo sharedKUserInfo].loginInfo.loginId];
        NSString *sessionid = [NSString stringWithString:[KUserInfo sharedKUserInfo].loginInfo.sessionId];
        [webView invokeJavascriptWithParam:@{@"qrcode":self.lotteryPackageCode,
                                             @"lotteryClassId":[NSString isBlank:self.lotteryCode]?@"":self.lotteryCode,
                                             @"loginId":userId,
                                             @"sessionId":sessionid,
                                             @"type":[NSString stringWithFormat:@"%ld",self.type],
                                             @"canClear":[NSString stringWithFormat:@"%d",[self canClearLocalStroage]]
                                             } function:@"getQrcode"];
    }
    else if (![NSString isBlank:code] && [code isEqualToString:@"qrcodeFunction"]){
        Print(@"二维码调试");
        [self scanQrCode];
    }
    else if (![NSString isBlank:code] && [code isEqualToString:@"goBackFuntion"]){
        Print(@"返回事件");
        [self popBackWithEvent:@"goBackFuntion"];
    }
    else if (![NSString isBlank:code] && [code isEqualToString:@"goBackToTerminal"]){
        [self popBackWithEvent:@"goBackToTerminal"];
    }
    else if (![NSString isBlank:code] && [code isEqualToString:@"goBackToLotteryOperation"]){
        [self popBackWithEvent:@"goBackToLotteryOperation"];
    }
    else if (![NSString isBlank:code] && [code isEqualToString:@"needLogin"]){
        [self needLogin];
    }
}

/**
 返回终端详情
 */
-(void)popBackWithEvent:(NSString *)eventID{
    
}

/**
 继续扫描二维码
 */
-(void)scanQrCode{
    QRCodeViewController *qRcodeVC=[QRCodeViewController new];
    [BaseViewController jumpFromSourceViewController:self ToViewController:qRcodeVC];
}

/**清除缓存和cookie*/

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}

-(BOOL)canClearLocalStroage{
    NSInteger count = 0;
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (BaseViewController *vc in viewControllers) {
        if ([vc isKindOfClass:[BaseWebViewController class]]) {
            count++;
        }
    }
    Print(@"栈里有 %ld 个 webView",count);
    return count <= 1;
}


/**
 登录态失效，需要重新登录
 */
-(void)needLogin{
    [[AccountTool shareInstance] knickOut];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}



@end
