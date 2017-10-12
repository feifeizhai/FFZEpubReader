//
//  UIViewController+JingGeTransitionProperty.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JingGeTransitionProperty;
@interface UIViewController (JingGeTransitionProperty)
typedef void(^JingGeTransitionBlock)(JingGeTransitionProperty *transition);

@property (nonatomic, copy  ) JingGeTransitionBlock            JingGe_callBackTransition;
@property (nonatomic, assign) BOOL                          JingGe_delegateFlag;
@property (nonatomic, assign) BOOL                          JingGe_addTransitionFlag;
@property (nonatomic, assign) BOOL                          JingGe_backGestureEnable;

@property (nonatomic, weak  ) id                            JingGe_transitioningDelegate;
@property (nonatomic, weak  ) id                            JingGe_tempNavDelegate;


@end
