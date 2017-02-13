//
//  ViewController.h
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/6.
//  Copyright © 2017年 陈思宇. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "BaseViewController.h"
#import "Stories.h"
@interface DetailController : BaseViewController
@property (nonatomic, weak) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) Stories *story;
@end
