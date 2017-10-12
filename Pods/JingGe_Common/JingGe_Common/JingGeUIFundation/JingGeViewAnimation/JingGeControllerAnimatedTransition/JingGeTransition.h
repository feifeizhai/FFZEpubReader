//
//  JingGeTransition.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JingGeTransitionTypeConfig.h"


@interface JingGeTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval                    animationTime;
@property (nonatomic, assign) JingGeTransitionType                 transitionType;
@property (nonatomic, assign) JingGeTransitionAnimationType        animationType;
@property (nonatomic, assign) JingGeTransitionAnimationType        backAnimationType;
@property (nonatomic, assign) JingGeGestureType                    backGestureType;

@property (nonatomic, weak) UIView                              *startView;
@property (nonatomic, weak) UIView                              *targetView;

@property (nonatomic, assign) BOOL                              isSysBackAnimation;
@property (nonatomic, assign) BOOL                              autoShowAndHideNavBar;
@property (nonatomic, assign) BOOL                              backGestureEnable;

@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);
@property (nonatomic, copy) void(^completionBlock)();


+(JingGeTransition *)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet;

@end
