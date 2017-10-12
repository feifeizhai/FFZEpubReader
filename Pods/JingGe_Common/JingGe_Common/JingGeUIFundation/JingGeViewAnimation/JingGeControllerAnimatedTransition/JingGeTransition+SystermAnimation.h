//
//  JingGeTransition+SystermAnimation.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransition.h"

@interface JingGeTransition (SystermAnimation)
-(void)sysTransitionNextAnimationWithType:(JingGeTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)sysTransitionBackAnimationWithType:(JingGeTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
