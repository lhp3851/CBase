//
//  SGWebView.m
//  SGWebViewExample
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 Sorgle. All rights reserved.
//

#import "SGWebView.h"
#import <WebKit/WebKit.h>

@interface SGWebView () <WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler>{
    UIViewController *viewController;
}
/// WKWebView
@property (nonatomic, strong) WKWebView *wkWebView;
/// 进度条
@property (nonatomic, strong) UIProgressView *progressView;
    
@end

@implementation SGWebView

static CGFloat const navigationBarHeight = 0.0f;
static CGFloat const progressViewHeight = 2;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)VC{
    viewController = VC;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.wkWebView];
        [self addSubview:self.progressView];
    }
    return self;
}

+ (instancetype)webViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
        // 交互对象设置
        [config.userContentController addScriptMessageHandler:(id)self name:@"zhaocaimao"];
        config.allowsInlineMediaPlayback = YES;
//        config.preferences.javaScriptCanOpenWindowsAutomatically = true;
        _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds configuration:config];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        
        _wkWebView.allowsBackForwardNavigationGestures = true;
        _wkWebView.allowsLinkPreview = true;
        [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        // 高度默认有导航栏且有穿透效果
        _progressView.frame = CGRectMake(0, navigationBarHeight, self.frame.size.width, progressViewHeight);
        // 设置进度条颜色
        _progressView.tintColor = [[UIColor alloc]initWithRed:218/255.0 green:103/255.0 blue:41/255.0 alpha:1.0];
    }
    return _progressView;
}
    
- (void)setProgressViewColor:(UIColor *)progressViewColor {
    _progressViewColor = progressViewColor;
    if (progressViewColor) {
        _progressView.tintColor = progressViewColor;
    }
}

- (void)setIsNavigationBarOrTranslucent:(BOOL)isNavigationBarOrTranslucent {
    _isNavigationBarOrTranslucent = isNavigationBarOrTranslucent;
    
    if (isNavigationBarOrTranslucent == YES) { // 导航栏存在且有穿透效果
        _progressView.frame = CGRectMake(0, navigationBarHeight, self.frame.size.width, progressViewHeight);
    } else { // 导航栏不存在或者没有有穿透效果
        _progressView.frame = CGRectMake(0, 0, self.frame.size.width, progressViewHeight);
    }
}

/// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        self.progressView.alpha = 1.0;
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        if(self.wkWebView.estimatedProgress >= 0.97) {
            [UIView animateWithDuration:0.1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - - - 加载的状态回调（WKNavigationDelegate）
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse   ====    %@", navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
    
// 加载 HTTPS 的链接，需要权限认证时调用  \  如果 HTTPS 是用的证书在信任列表中这不要此代理方法
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}
    
/// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.SGQRCodeDelegate webViewDidStartLoad:self];
    }
}

/// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webView:didCommitWithURL:)]) {
        [self.SGQRCodeDelegate webView:self didCommitWithURL:self.wkWebView.URL];
    }
    
    self.navigationItemTitle = self.wkWebView.title;
}

/// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.navigationItemTitle = self.wkWebView.title;
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webView:didFinishLoadWithURL:)]) {
        [self.SGQRCodeDelegate webView:self didFinishLoadWithURL:self.wkWebView.URL];
    }
    
    self.progressView.alpha = 0.0;
}
/// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.SGQRCodeDelegate webView:self didFailLoadWithError:error];
    }
    
    self.progressView.alpha = 0.0;
}
/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.SGQRCodeDelegate webView:self didFailLoadWithError:error];
    }
    
    self.progressView.alpha = 0.0;
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}
#pragma mark 加载数据
/// 加载 web
- (void)loadRequest:(NSURLRequest *)request {
    [self.wkWebView loadRequest:request];
}
/// 加载 HTML
- (void)loadHTMLString:(NSString *)HTMLString {
    [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
}
/// 根据baseURL加载 HTML
- (void)loadHTMLString:(NSString *)HTMLString baseURL:(NSURL*)baseURL{
    [self.wkWebView loadHTMLString:HTMLString baseURL:baseURL];
}
/// 刷新数据
- (void)reloadData {
    [self.wkWebView reload];
}

    
/**
 set cookies
 */
- (void)setCookies{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:[NSURL URLWithString:@"http://192.168.1.200:8008/api/lottery/user/"] forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"cookie_user" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:se forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"www.zhaocaimao.com" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];

    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookieJar.cookies) {
        NSLog(@"cookie:%@",cookie);
    }
    
}

//清除cookie
- (void)deleteCookie{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieAry = [cookieJar cookiesForURL: [NSURL URLWithString: @"http://192.168.1.200:8008/api/lottery/user/"]];
    for (NSHTTPCookie *cookie in cookieAry) {
        [cookieJar deleteCookie: cookie];
    }
}


#pragma mark 弹框提示
// 提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    
    [viewController presentViewController:alert animated:true completion:^{
        
    }];
    
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [viewController presentViewController:alert animated:YES completion:NULL];
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
        textField.placeholder = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    [viewController presentViewController:alert animated:YES completion:NULL];
}

#pragma mark JavaScript 调用 native
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:message.body];
    NSLog(@"JS交互参数：%@", dic);

    if (dic.count<1) {//若果传的是空参数，不做处理
        return;
    }
    
    if ([message.name isEqualToString:@"zhaocaimao"]) {
        NSLog(@"currentThread  ------   %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.SGQRCodeDelegate postBackJavascript:self message:message];
        });
    } else {
        return;
    }
}

#pragma mark di转 Json
- (NSString*)changeToJson:(id)object
{
    if ([object isKindOfClass:[NSString class]]){
        NSString * str = (NSString *)object;
        return str;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

#pragma mark native 调用 JavaScript
-(void)invokeJavascriptWithParam:(id)param function:(NSString *)functionName{
    NSString *jsonParam = [self changeToJson:param];
    NSString *js = [NSString stringWithFormat:@"%@(%@)",functionName,jsonParam];
    NSLog(@"js:%@",js);
    [self.wkWebView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"send sessio ok,datas:%@",result);
        }
        else{
            NSLog(@"error:%@",error);
        }
    }];
}


/// dealloc
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"zhaocaimaouser"];
}

-(void)clearWebView{
    if (self.wkWebView) {
        self.wkWebView.scrollView.delegate = nil;
        self.SGQRCodeDelegate = nil;
        [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
        [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"zhaocaimaouser"];
        self.wkWebView = nil;
    }
}

@end

