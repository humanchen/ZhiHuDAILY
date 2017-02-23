/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A transition animator that slides the incoming view controller over the
  presenting view controller.
 */

#import "AAPLSwipeTransitionAnimator.h"

@implementation AAPLSwipeTransitionAnimator

//| ----------------------------------------------------------------------------
//- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge
//{
//    self = [self init];
//    if (self) {
//        _targetEdge = targetEdge;
//    }
//    return self;
//}


//| ----------------------------------------------------------------------------
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

//| ----------------------------------------------------------------------------
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;

    UIView *fromView;
    UIView *toView;
    

    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    // If this is a presentation, toViewController corresponds to the presented
    // view controller and its presentingViewController will be
    // fromViewController.  Otherwise, this is a dismissal.
//    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
//    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    


//    if (isPresenting) {
//        // For a presentation, the toView starts off-screen and slides in.
//        fromView.frame = fromFrame;
////        toView.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,
////                                             toFrame.size.height * offset.dy * -1);
//        toView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    } else {
//        fromView.frame = fromFrame;
//        toView.frame = toFrame;
//    }
//    
//    // We are responsible for adding the incoming view to the containerView
//    // for the presentation.
    
    if(_operation==UINavigationControllerOperationPush){
        //        toView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        toView.frame=CGRectMake(-[UIScreen mainScreen].bounds.size.width/4, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        _maskView=[[UIView alloc]initWithFrame:toView.bounds];
        _maskView.backgroundColor=[UIColor blackColor];
        _maskView.alpha=0.3;
        [toView addSubview:_maskView];
        
        fromView.layer.shadowColor=[UIColor blackColor].CGColor;
        fromView.layer.shadowOffset=CGSizeMake(-2, 1);
        fromView.layer.shadowRadius=2;
        fromView.layer.shadowOpacity=0.5;
        
    }
    
    if (_operation==UINavigationControllerOperationPush)
        [containerView addSubview:toView];
    else
      
        [containerView insertSubview:toView belowSubview:fromView];

    
    

    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
 animations:^{

        
        if(_operation==UINavigationControllerOperationPush){
            toView.frame=fromFrame;
            fromView.frame=CGRectMake(-[UIScreen mainScreen].bounds.size.width/4, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }else{
            _maskView.alpha=0;
            toView.frame=fromFrame;
            fromView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
    } completion:^(BOOL finished) {
        
        if(_operation==UINavigationControllerOperationPop){
            [_maskView removeFromSuperview];
        }
        
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        
                if (wasCancelled)
            [toView removeFromSuperview];
        
      
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
