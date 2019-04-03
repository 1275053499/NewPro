//
//  NewProProtocalVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/3.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProProtocalVC.h"
#import <WebKit/WebKit.h>
@interface NewProProtocalVC ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong) UIWebView * WebView;//释义
@property(nonatomic,strong) WKWebView * wkwebview;//释义
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation NewProProtocalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
    WKWebViewConfiguration *config      = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize  = 0;
    self.wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
    [self.view addSubview:self.wkwebview];
    _wkwebview.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, kSafeHeight);
    self.wkwebview.UIDelegate         = self;
    self.wkwebview.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.Url]];
    [self.wkwebview loadRequest:request];
    

    // KVO，监听webView属性值得变化(estimatedProgress,title为特定的key)
    [self.wkwebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkwebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // UIProgressView初始化
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(0, 0, self.wkwebview.frame.size.width, 2);
    self.progressView.trackTintColor = [UIColor clearColor]; // 设置进度条的色彩
    self.progressView.progressTintColor = MainColor;
    // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
    [self.progressView setProgress:0.1 animated:YES];
    [self.wkwebview addSubview:self.progressView];
    
    //    本地
    //    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:self.Url withExtension:nil];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    //    [self.WebView loadRequest:request];
}

- (void)makeWhiteBtn{
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"NewBack"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)dismiss
{
    if ([self.wkwebview canGoBack]) {
        [self.wkwebview goBack];
    }else{
        if (self.rt_navigationController.rt_viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    self.title = webView.title;
}


// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载失败时调用");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"接收到服务器跳转请求之后调用");
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"在收到响应后navigationResponse.response.URL.absoluteString:%@",navigationResponse.response.URL.absoluteString);
    
    //     https://fir.im/5xr3
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"在发送请求之前navigationAction.request.URL.absoluteString :%@",navigationAction.request.URL.absoluteString);
    
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

- (void)dealloc {
    
    // 最后一步：移除监听
    [_wkwebview removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wkwebview removeObserver:self forKeyPath:@"title"];
}

#pragma mark - KVO监听
// 第三部：完成监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([object isEqual:self.wkwebview] && [keyPath isEqualToString:@"estimatedProgress"]) { // 进度条
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        NSLog(@"打印测试进度值：%f", newprogress);
        
        if (newprogress == 1) { // 加载完成
            // 首先加载到头
            [self.progressView setProgress:newprogress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });
            
        } else { // 加载中
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if ([object isEqual:self.wkwebview] && [keyPath isEqualToString:@"title"]) { // 标题
        
        self.title = self.wkwebview.title;//设置标题
    } else { // 其他
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
