//
//  RefreshView.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/9.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "RefreshView.h"
@interface RefreshView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) CGFloat refreshFlag;

@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;

@end


@implementation RefreshView
+ (instancetype)refreshViewWithScrollView:(UIScrollView *)scrollView {
    RefreshView *refreshView = [[self alloc] init];
    refreshView.bounds = CGRectMake(0, 0, 18, 18);
    refreshView.scrollView = scrollView;
    
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    [refreshView.layer addSublayer:progressLayer];
    progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    progressLayer.fillColor = [UIColor clearColor].CGColor;
    progressLayer.backgroundColor = [UIColor clearColor].CGColor;
    progressLayer.strokeEnd = 0.0;
    progressLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
    progressLayer.lineWidth = 2.0;
    refreshView.progressLayer = progressLayer;
    
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
    indicatorView.bounds = CGRectMake(0, 0, 18, 18);
    [refreshView addSubview:indicatorView];
    refreshView.indicatorView = indicatorView;
    
    
    [refreshView.scrollView addObserver:refreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    return refreshView;
}


- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 2, 2)].CGPath;
}

- (void)layoutSubviews {
    self.indicatorView.frame = self.bounds;
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (self.refreshing)  return;
    
    
    CGFloat height = [change[@"new"] CGPointValue].y;
    
    if (height > 0) {
        height = 0.;
    } else if (height <= -80) {
        height = 1.0;
    } else {
        height = height / -80.0;
    }
    
    
    if (self.scrollView.isDragging) {
        
        self.hidden = NO;
        self.refreshFlag = height;
        self.progressLayer.hidden = NO;
        self.progressLayer.strokeEnd = height;
        [self.indicatorView stopAnimating];
    } else {
        if (self.refreshFlag == 1.) {
            self.refreshFlag = 0;
            self.refreshing = YES;
            [self.indicatorView startAnimating];
            self.progressLayer.hidden = YES;
            self.progressLayer.strokeEnd = 0;
        } else {
            [self.indicatorView stopAnimating];
            self.progressLayer.hidden = NO;
            self.progressLayer.strokeEnd = height;
        }
    }
}


- (void)endRefresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.hidden = YES;
        self.refreshing = NO;
        self.progressLayer.strokeEnd = 0;
        self.progressLayer.hidden = NO;
        [self.indicatorView stopAnimating];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
