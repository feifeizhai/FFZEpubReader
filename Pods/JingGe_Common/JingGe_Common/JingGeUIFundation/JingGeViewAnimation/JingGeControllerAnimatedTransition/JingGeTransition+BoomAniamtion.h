//
//  JingGeTransition+BoomAniamtion.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransition.h"

@interface JingGeTransition (BoomAniamtion)
-(void)boomPresentTransitionNextAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)boomPresentTransitionBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
