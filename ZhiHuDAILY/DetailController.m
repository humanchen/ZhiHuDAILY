//
//  ViewController.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/6.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "DetailController.h"

@interface DetailController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,strong)WKWebView *webView;
@end

@implementation DetailController

- (UIWebView *)webView {
    if (!_webView) {
        WKWebView *webView = [[UIWebView alloc] init];
        webView.frame = CGRectMake(0, 20, kScreenWidth, kScreenHeight-40-20);
        _webView = webView;
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = kWhiteColor;
    }
    return _webView;
}

- (void)setStory:(Stories *)story{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    [self.view addSubview:self.webView];
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
