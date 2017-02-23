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
#import "SYTopView.h"
@interface DetailController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)DetailViewModel *dVM;
@property (nonatomic, strong) SYStoryNavigationView *storyNav;
@property (nonatomic, strong) SYTopView   *topView;
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
        
//        _webView.scrollView.panGestureRecognizer.delegate = self;
        _webView.scrollView.delegate = self;
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


- (SYTopView *)topView {
    if (!_topView) {
        _topView = [SYTopView topView];
        _topView.clipsToBounds = YES;
        _topView.frame = CGRectMake(0, -40, kScreenWidth, 220+40);
//        _topView.hidden = YES;
    }
    return _topView;
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
    self.panGestureRecognizer.delegate=self;
    
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.storyNav];
    [self setupRAC];
}

- (void)setupRAC{
    _dVM=[[DetailViewModel alloc]init];
    _dVM.storyid=self.story.id;
    [[[_dVM.requestDetailCommand executionSignals]switchToLatest] subscribeNext:^(id  _Nullable x) {
        
        [self.webView loadHTMLString:_dVM.detailStory.htmlStr baseURL:nil];
        _topView.story=_dVM.detailStory;
    }];
    [_dVM.requestDetailCommand execute:nil];
   
 
}

//- (UIView *)currentTopView {
//        if (!self.topView.hidden) {
//            return self.topView;
//        } else if (!self.headerView.hidden) {
//            return self.headerView;
//        }
//        return nil;
//    
////    return !self.topView.hidden ? self.topView : (!self.headerView.hidden ? self.headerView : nil);
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
   CGFloat yoffset = scrollView.contentOffset.y;
    if (yoffset > 220) Black_StatusBar;
    else White_StatusBar;

    _topView.story=_dVM.detailStory;
    if(yoffset<0){
        //下拉
        self.topView.frame = CGRectMake(0, -40, kScreenWidth, 260-yoffset);
        [_topView reset];
    }else{
        //上拉
        self.topView.frame = CGRectMake(0, -40-yoffset, kScreenWidth, 260);
         [_topView reset];
    }
//    if (yoffset < 0) {
//        if (self.topView == [self currentTopView]) {
//            self.topView.frame = CGRectMake(0, -40, kScreenWidth, 260-yoffset);
//        }
//        self.header.transform = CGAffineTransformMakeTranslation(0, -yoffset);
//        
//        CGAffineTransform transform = CGAffineTransformIdentity;
//        if (yoffset < -80.) transform = CGAffineTransformMakeRotation(M_PI);
//        
//        if (!CGAffineTransformEqualToTransform(self.downArrow.transform, transform)) {
//            [UIView animateWithDuration:0.25 animations:^{
//                self.downArrow.transform = transform;
//            }];
//        }
//    } else {
//        if (self.topView == [self currentTopView]) {
//            self.topView.frame = CGRectMake(0, -40-yoffset, kScreenWidth, 260);
//        }
//        
//        CGFloat boffset = kScreenHeight-80-scrollView.contentSize.height + yoffset;
//        
//        if (boffset > 0) {
//            self.footer.transform = CGAffineTransformMakeTranslation(0, -boffset);
//            CGAffineTransform transform = CGAffineTransformIdentity;
//            if (boffset > 60.) transform = CGAffineTransformMakeRotation(M_PI);
//            
//            if (!CGAffineTransformEqualToTransform(self.upArrow.transform, transform)) {
//                [UIView animateWithDuration:0.25 animations:^{
//                    self.upArrow.transform = transform;
//                }];
//            }
//        }
//    }

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

-(BOOL)gestureRecognizer:(UIGestureRecognizer*) gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer
{
    return YES;
//    if ([gestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
//        
//        return NO;
//        
//    }
//    else {
//        
//        return YES;
//        
//    }
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//        // Find the current vertical scrolling velocity
//        CGFloat velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:gestureRecognizer.view].y;
//        // Return YES if no scrolling up
//        return fabs(velocity) <= 0.2;
//    }
//    return YES;
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
//    {
//        CGPoint translation = [gestureRecognizer translationInView:self.view];
//        return fabs(translation.y) <= fabs(translation.x);
//    }
//    return YES;
//}

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
