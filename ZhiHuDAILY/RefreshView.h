//
//  RefreshView.h
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/9.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView


+ (instancetype)refreshViewWithScrollView:(UIScrollView *)scrollView;

- (void)endRefresh;


@end
