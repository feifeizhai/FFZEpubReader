//
//  JingGeTransition+ViewMoveAnimation.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransition.h"

@interface JingGeTransition (ViewMoveAnimation)
- (void)viewMoveNextWithType:(JingGeTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)viewMoveBackWithType:(JingGeTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
