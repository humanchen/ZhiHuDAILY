//
//  ViewController.h
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/6.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "BaseViewController.h"

@interface ViewController : BaseViewController
@property (nonatomic, weak) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@end
