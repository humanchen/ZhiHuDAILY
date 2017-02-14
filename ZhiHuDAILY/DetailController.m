//
//  ViewController.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/6.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "DetailController.h"
#import "DetailViewModel.h"
#import "SYStoryNavigationView.h"
@interface DetailController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)DetailViewModel *dVM;
@property (nonatomic, strong) SYStoryNavigationView *storyNav;
@end

@implementation DetailController

- (UIWebView *)webView {
    if (!_webView) {
        
//        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//        
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//        [wkUController addUserScript:wkUScript];
//        
//        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//        wkWebConfig.userContentController = wkUController;
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-40-20)  ];
//        webView.configuration=wkWebConfig;
//        webView.frame = CGRectMake(0, 20, kScreenWidth, kScreenHeight-40-20);
        
        _webView = webView;
        
//        _webView.delegate = self;
//        _webView.scrollView.delegate = self;
//        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (SYStoryNavigationView *)storyNav {
    if (!_storyNav) {
        _storyNav = [SYStoryNavigationView storyNaviView];
        _storyNav.frame = CGRectMake(0, kScreenHeight-40, kScreenWidth, 40);
        
//        _storyNav.delegate = self;
    }
    return _storyNav;
}

- (void)setStory:(Stories *)story{
    _story=story;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    // Do any additional setup after loading the view.
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.storyNav];
    [self setupRAC];
}

- (void)setupRAC{
    _dVM=[[DetailViewModel alloc]init];
    _dVM.storyid=self.story.id;
    [[[_dVM.requestDetailCommand executionSignals]switchToLatest] subscribeNext:^(id  _Nullable x) {
        
        [self.webView loadHTMLString:_dVM.detailStory.htmlStr baseURL:nil];
        
    }];
    [_dVM.requestDetailCommand execute:nil];
   
 
}


- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    static CGFloat beginX;
    CGFloat currentX = [gestureRecognizer translationInView:window].x;
    CGFloat percent = (currentX - beginX) / CGRectGetWidth(window.bounds);
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            beginX = [gestureRecognizer translationInView:window].y;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.interactiveTransition updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateEnded:
            if (percent > 0.3) {
                [self.interactiveTransition finishInteractiveTransition];
            }
            else {
                [self.interactiveTransition cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
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
