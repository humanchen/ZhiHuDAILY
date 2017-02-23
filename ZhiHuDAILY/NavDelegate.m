//
//  NavDelegate.m
//  TestNavAni
//
//  Created by 陈思宇 on 17/2/6.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "NavDelegate.h"
#import "AAPLSwipeTransitionAnimator.h"
#import "DetailController.h"
@implementation NavDelegate

- (UIPercentDrivenInteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
        _interactiveTransition.completionSpeed=0.2;
    }
    return _interactiveTransition;
}

- (AAPLSwipeTransitionAnimator *)ani{
    if(!_ani){
        _ani=   [[AAPLSwipeTransitionAnimator alloc]init];
        
    }
    _ani.operation=_operation;
    return _ani;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if(_operation==UINavigationControllerOperationPop){
        return self.interactiveTransition;

    }
    
    return nil;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    _operation=operation;
    _interactiveTransition.completionSpeed=(1-_interactiveTransition.percentComplete)*0.25;
    if(operation==UINavigationControllerOperationPush){
        [self.interactiveTransition updateInteractiveTransition:0];
        DetailController *v2=(DetailController *)toVC;
        v2.interactiveTransition=self.interactiveTransition;
    }
    
    if(operation==UINavigationControllerOperationPop){
    [self.interactiveTransition updateInteractiveTransition:0];
        DetailController *v2=(DetailController *)fromVC;
        v2.interactiveTransition=self.interactiveTransition;
    }
   return self.ani;
}
@end
