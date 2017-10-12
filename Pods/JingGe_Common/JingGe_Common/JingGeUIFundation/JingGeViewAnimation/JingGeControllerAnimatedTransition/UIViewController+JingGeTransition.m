//
//  UIViewController+JingGeTransition.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "UIViewController+JingGeTransition.h"

#import <objc/runtime.h>
#import "UIViewController+JingGeTransitionProperty.h"

UINavigationControllerOperation _operation;
JingGePercentDrivenInteractiveTransition *_interactive;
JingGeTransition *_transtion;
@implementation UIViewController (JingGeTransition)
#pragma mark Hook

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        Method method0 = class_getInstanceMethod(self.class, @selector(JingGe_dismissViewControllerAnimated:completion:));
        Method method1 = class_getInstanceMethod(self.class, @selector(dismissViewControllerAnimated:completion:));
        method_exchangeImplementations(method0, method1);
        
        
        
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(JingGe_viewDidAppear:);
        
        Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        
        BOOL success = class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        
        
        
        originalSelector = @selector(viewWillDisappear:);
        swizzledSelector = @selector(JingGe_viewWillDisappear:);
        
        originalMethod = class_getInstanceMethod(self.class, originalSelector);
        swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        
        success = class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}



- (void)JingGe_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if (self.JingGe_delegateFlag) {
        self.transitioningDelegate = self;
        if (self.JingGe_transitioningDelegate) {
            self.transitioningDelegate = self.JingGe_transitioningDelegate;
        }
    }
    [self JingGe_dismissViewControllerAnimated:flag completion:completion];
}

- (void)JingGe_viewDidAppear:(BOOL)animated {
    
    [self JingGe_viewDidAppear:animated];
    if (self.JingGe_backGestureEnable) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)JingGe_viewWillDisappear:(BOOL)animated {
    [self JingGe_viewWillDisappear:animated];
    if (self.JingGe_backGestureEnable) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}



#pragma mark Action Method

//Default
- (void)JingGe_presentViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion{
    
    [self JingGe_presentViewController:viewControllerToPresent makeTransition:nil completion:completion];
}

//Choose animation type
-(void)JingGe_presentViewController:(UIViewController *)viewControllerToPresent animationType:(JingGeTransitionAnimationType )animationType completion:(void (^)(void))completion{
    
    [self JingGe_presentViewController:viewControllerToPresent makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationType = animationType;
    } completion:completion];
    
    
}

//make transition
-(void)JingGe_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(JingGeTransitionBlock)transitionBlock{
    
    [self JingGe_presentViewController:viewControllerToPresent makeTransition:transitionBlock completion:nil];
    
}

//make transition With Completion
-(void)JingGe_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(JingGeTransitionBlock)transitionBlock completion:(void (^)(void))completion{
    
    if (viewControllerToPresent.transitioningDelegate) {
        self.JingGe_transitioningDelegate = viewControllerToPresent.transitioningDelegate;
    }
    viewControllerToPresent.JingGe_addTransitionFlag = YES;
    viewControllerToPresent.transitioningDelegate = viewControllerToPresent;
    viewControllerToPresent.JingGe_callBackTransition = transitionBlock ? transitionBlock : nil;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
    
}




#pragma mark Delegate
// ********************** Present Dismiss **********************
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if (!self.JingGe_addTransitionFlag) {
        return nil;//dimiss directly
    }
    
    !_transtion ? _transtion = [[JingGeTransition alloc] init] : nil ;
    JingGeTransitionProperty *make = [[JingGeTransitionProperty alloc] init];
    self.JingGe_callBackTransition ? self.JingGe_callBackTransition(make) : nil;
    _transtion = [JingGeTransition copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = JingGeTransitionTypeDismiss;
    self.JingGe_backGestureEnable =  make.backGestureEnable;
    return _transtion;
    
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (!self.JingGe_addTransitionFlag) {
        return nil;//present directly
    }
    
    !_transtion ? _transtion = [[JingGeTransition alloc] init] : nil ;
    JingGeTransitionProperty *make = [[JingGeTransitionProperty alloc] init];
    self.JingGe_callBackTransition ? self.JingGe_callBackTransition(make) : nil;
    _transtion = [JingGeTransition copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = JingGeTransitionTypePresent;
    self.JingGe_delegateFlag = _transtion.isSysBackAnimation ? NO : YES;
    self.JingGe_backGestureEnable =  make.backGestureEnable;
    return _transtion;
    
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (!self.JingGe_addTransitionFlag) {
        return nil;
    }
    return _interactive.isInteractive ? _interactive : nil ;
}


//  ********************** Push Pop **********************
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (!self.JingGe_addTransitionFlag) {
        return nil;
    }
    !_transtion ? _transtion = [[JingGeTransition alloc] init] : nil ;
    JingGeTransitionProperty *make = [[JingGeTransitionProperty alloc] init];
    self.JingGe_callBackTransition ? self.JingGe_callBackTransition(make) : nil;
    _transtion = [JingGeTransition copyPropertyFromObjcet:make toObjcet:_transtion];
    _operation = operation;
    
    
    if ( operation == UINavigationControllerOperationPush ) {
        self.JingGe_delegateFlag = _transtion.isSysBackAnimation ? NO : YES;
        _transtion.transitionType = JingGeTransitionTypePush;
        
    }else{
        _transtion.transitionType = JingGeTransitionTypePop;
    }
    
    if (_operation == UINavigationControllerOperationPush && _transtion.isSysBackAnimation == NO && _transtion.backGestureEnable) {
        //add gestrue for pop
        !_interactive ? _interactive = [[JingGePercentDrivenInteractiveTransition alloc] init] : nil;
        [_interactive addGestureToViewController:self];
        _interactive.transitionType = JingGeTransitionTypePop;
        _interactive.getstureType = _transtion.backGestureType != JingGeGestureTypeNone ? _transtion.backGestureType : JingGeGestureTypePanRight;
        _interactive.willEndInteractiveBlock = ^(BOOL suceess) {
            _transtion.willEndInteractiveBlock ? _transtion.willEndInteractiveBlock(suceess) : nil;
        };
        
    }
    self.JingGe_backGestureEnable =  make.backGestureEnable;
    return _transtion;
    
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    if (!self.JingGe_addTransitionFlag) {
        return nil;
    }
    !_interactive ? _interactive = [[JingGePercentDrivenInteractiveTransition alloc] init] : nil;
    
    if (_operation == UINavigationControllerOperationPush) {
        return nil;
    }else{
        return _interactive.isInteractive ? _interactive : nil ;
    }
    
}

@end
