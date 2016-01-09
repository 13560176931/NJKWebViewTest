//
//  ViewController.m
//  NJKWebViewTest
//
//  Created by 郑乾坤 on 16/1/9.
//  Copyright © 2016年 郑乾坤. All rights reserved.
//

#import "ViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface ViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>

@property (nonatomic , strong) UIWebView * webView;
@property (nonatomic , strong) NJKWebViewProgressView * progressView;
@property (nonatomic , strong) NJKWebViewProgress * progressPoxy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这一步很重要，必须先创建出来，否则你的进度条将不会动
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)];
    _webView.center = self.view.center;
    
    _progressPoxy = [[NJKWebViewProgress alloc]init];
    _webView.delegate = _progressPoxy;
    _progressPoxy.webViewProxyDelegate = self;
    _progressPoxy.progressDelegate = self;
    
    //http://58.96.180.232:80/ftl/html5/index/10.html?1451553857312
    
    _progressView = [[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-2, self.navigationController.navigationBar.frame.size.width, 2)];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    //初始化进度条进度
    [_progressView setProgress:0 animated:YES];
    
    [self loadWeb];
    
}
-(void)loadWeb{
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://58.96.180.232:80/ftl/html5/index/10.html?1451553857312"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}





@end
