//
//  JingGeTransition+ViewMoveAnimation.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransition+ViewMoveAnimation.h"

@implementation JingGeTransition (ViewMoveAnimation)
- (void)viewMoveRollNextWithType:(JingGeTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *startView = [self.startView snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:startView];
    
    startView.frame = [self.startView convertRect:self.startView.bounds toView: containerView];
    toVC.view.alpha = 0;
    self.startView.hidden = YES;
    self.targetView.hidden = YES;
    fromVC.view.alpha = 1;
}


- (void)viewMoveNextWithType:(JingGeTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *startView = [self.startView snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:startView];
    
    startView.frame = self.startView.frame;
    toVC.view.alpha = 0;
    self.startView.hidden = YES;
    self.targetView.hidden = YES;
    fromVC.view.alpha = 1;
    
    __weak typeof(self) weakSelf = self;
    
    
    void(^AnimationBlock)() = ^(){
        startView.frame = weakSelf.targetView.frame;
        toVC.view.alpha = 1;
        fromVC.view.alpha = 0.0;
    };
    
    void(^AnimationCompletion)() = ^(void){
        startView.hidden = YES;
        weakSelf.startView.hidden = NO;
        weakSelf.targetView.hidden = NO;
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
    
    if (type == JingGeTransitionAnimationTypeViewMoveToNextVC) {
        
        [UIView animateWithDuration:self.animationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1 / 0.7 options:0 animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            AnimationCompletion();
        }];
        
    }else {
        
        [UIView animateWithDuration:self.animationTime animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            AnimationCompletion();
        }];
        
    }
    
}

- (void)viewMoveBackWithType:(JingGeTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    [containerView insertSubview:toVC.view atIndex:0];
    //Default values
    self.targetView.hidden = YES;
    self.startView.hidden = YES;
    tempView.hidden = NO;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    fromVC.view.alpha = 1;
    tempView.frame = self.targetView.frame;
    __weak typeof(self) weakSelf = self;
    void(^AnimationBlock)() = ^(){
        tempView.frame = weakSelf.startView.frame;
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
    };
    
    void(^AnimationCompletion)() = ^(void){
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            tempView.hidden = YES;
            weakSelf.targetView.hidden = NO;
            weakSelf.startView.hidden = NO;
        }else{
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
        fromVC.view.hidden = NO;
    };
    
    
    if (type == JingGeTransitionAnimationTypeViewMoveToNextVC) {
        
        [UIView animateWithDuration:self.animationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1 / 0.7 options:0 animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            AnimationCompletion();
        }];
        
    }else {
        
        [UIView animateWithDuration:self.animationTime animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            
            AnimationCompletion();
        }];
        
    }
    __weak UIViewController * weakFromVC = fromVC;
    self.willEndInteractiveBlock  = ^(BOOL success){
        
        if (success) {
            
            weakFromVC.view.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            [tempView removeFromSuperview];
            
        }else{
            tempView.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = NO;
            
        }
    };
    
}

@end
