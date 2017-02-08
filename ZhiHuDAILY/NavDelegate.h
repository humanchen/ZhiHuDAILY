//
//  NavDelegate.h
//  TestNavAni
//
//  Created by 陈思宇 on 17/2/6.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAPLSwipeTransitionAnimator.h"
@interface NavDelegate : NSObject<UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, strong) AAPLSwipeTransitionAnimator *ani;
@property (nonatomic ,assign)UINavigationControllerOperation operation;
@end
