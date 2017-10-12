//
//  JingGeTransition+FragmentAnimation.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransition.h"

@interface JingGeTransition (FragmentAnimation)
-(void)fragmentShowNextType:(JingGeTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)fragmentShowBackType:(JingGeTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)fragmentHideNextType:(JingGeTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)fragmentHideBackType:(JingGeTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
