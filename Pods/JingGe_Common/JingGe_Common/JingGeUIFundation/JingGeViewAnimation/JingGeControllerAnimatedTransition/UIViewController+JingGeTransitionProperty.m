//
//  UIViewController+JingGeTransitionProperty.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "UIViewController+JingGeTransitionProperty.h"
#import <objc/runtime.h>


static NSString *JingGe_callBackTransitionKey = @"CallBackTransitionKey";
static NSString *JingGe_delegateFlagKey = @"JingGe_DelegateFlagKey";
static NSString *JingGe_addTransitionFlagKey = @"JingGe_addTransitionFlagKey";
static NSString *JingGe_backGestureEnableKey = @"JingGe_backGestureEnableKey";
static NSString *JingGe_transitioningDelegateKey = @"JingGe_transitioningDelegateKey";
static NSString *JingGe_tempNavDelegateKey = @"JingGe_tempNavDelegateKey";
@implementation UIViewController (JingGeTransitionProperty)
#pragma mark Property


//----- CallBackTransition
- (void)setJingGe_callBackTransition:(JingGeTransitionBlock)JingGe_callBackTransition {
    objc_setAssociatedObject(self, &JingGe_callBackTransitionKey, JingGe_callBackTransition, OBJC_ASSOCIATION_COPY);
}
- (JingGeTransitionBlock)JingGe_callBackTransition {
    return objc_getAssociatedObject(self, &JingGe_callBackTransitionKey);
}

//----- JingGe_DelegateFlag
- (void)setJingGe_delegateFlag:(BOOL)JingGe_delegateFlag {
    objc_setAssociatedObject(self, &JingGe_delegateFlagKey, @(JingGe_delegateFlag), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)JingGe_delegateFlag {
    return [objc_getAssociatedObject(self, &JingGe_delegateFlagKey) integerValue] == 0 ?  NO : YES;
}


//----- JingGe_addTransitionFlag
- (void)setJingGe_addTransitionFlag:(BOOL)JingGe_addTransitionFlag {
    objc_setAssociatedObject(self, &JingGe_addTransitionFlagKey, @(JingGe_addTransitionFlag), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)JingGe_addTransitionFlag {
    return [objc_getAssociatedObject(self, &JingGe_addTransitionFlagKey) integerValue] == 0 ?  NO : YES;
}


// ---- JingGe_backGestureEnable
- (void)setJingGe_backGestureEnable:(BOOL)JingGe_backGestureEnable {
    objc_setAssociatedObject(self, &JingGe_backGestureEnableKey, @(JingGe_backGestureEnable), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)JingGe_backGestureEnable {
    return [objc_getAssociatedObject(self , &JingGe_backGestureEnableKey) integerValue] == 0 ? NO : YES;
}

//----- JingGe_transitioningDelega
- (void)setJingGe_transitioningDelegate:(id)JingGe_transitioningDelegate {
    objc_setAssociatedObject(self, &JingGe_transitioningDelegateKey, JingGe_transitioningDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id)JingGe_transitioningDelegate {
    return objc_getAssociatedObject(self, &JingGe_transitioningDelegateKey);
}
//----- JingGe_tempNavDelegate
- (void)setJingGe_tempNavDelegate:(id)JingGe_tempNavDelegate {
    objc_setAssociatedObject(self, &JingGe_tempNavDelegateKey, JingGe_tempNavDelegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id)JingGe_tempNavDelegate {
    return objc_getAssociatedObject(self, &JingGe_tempNavDelegateKey);
}

@end
