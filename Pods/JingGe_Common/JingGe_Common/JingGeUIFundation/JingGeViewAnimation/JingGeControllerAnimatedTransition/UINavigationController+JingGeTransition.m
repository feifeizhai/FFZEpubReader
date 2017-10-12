//
//  UINavigationController+JingGeTransition.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "UINavigationController+JingGeTransition.h"
#import <objc/runtime.h>
#import "UIViewController+JingGeTransitionProperty.h"
@implementation UINavigationController (JingGeTransition)
#pragma mark Hook
+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method0 = class_getInstanceMethod(self.class, @selector(popViewControllerAnimated:));
        Method method1 = class_getInstanceMethod(self.class, @selector(JingGe_popViewControllerAnimated:));
        method_exchangeImplementations(method0, method1);
        
    });
}
#pragma mark Action Method
- (void)JingGe_pushViewController:(UIViewController *)viewController {
    
    [self JingGe_pushViewController:viewController makeTransition:nil];
    
}

- (void)JingGe_pushViewController:(UIViewController *)viewController animationType:(JingGeTransitionAnimationType) animationType{
    
    [self JingGe_pushViewController:viewController makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationType = animationType;
    }];
}

- (void)JingGe_pushViewController:(UIViewController *)viewController makeTransition:(JingGeTransitionBlock) transitionBlock {
    
    if (self.delegate) {
        viewController.JingGe_tempNavDelegate = self.delegate;
    }
    self.delegate = viewController;
    viewController.JingGe_addTransitionFlag = YES;
    viewController.JingGe_callBackTransition = transitionBlock ? transitionBlock : nil;
    
    [self pushViewController:viewController animated:YES];
    self.delegate = nil;
    if (viewController.JingGe_tempNavDelegate) {
        self.delegate = viewController.JingGe_tempNavDelegate;
    }
    
    
}

- (UIViewController *)JingGe_popViewControllerAnimated:(BOOL)animated {
    
    if (self.viewControllers.lastObject.JingGe_delegateFlag) {
        self.delegate = self.viewControllers.lastObject;
        if (self.JingGe_tempNavDelegate) {
            self.delegate = self.JingGe_tempNavDelegate;
        }
    }
    return [self JingGe_popViewControllerAnimated:animated];
    
}

@end
