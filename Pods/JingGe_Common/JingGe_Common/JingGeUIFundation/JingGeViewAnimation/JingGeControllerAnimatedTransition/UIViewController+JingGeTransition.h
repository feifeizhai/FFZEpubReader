//
//  UIViewController+JingGeTransition.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeTransition.h"
#import "JingGeTransitionProperty.h"
#import "JingGePercentDrivenInteractiveTransition.h"

typedef void(^JingGeTransitionBlock)(JingGeTransitionProperty *transition);
@interface UIViewController (JingGeTransition)<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

- (void)JingGe_presentViewController:(UIViewController *)viewControllerToPresent animationType:(JingGeTransitionAnimationType )animationType completion:(void (^)(void))completion;
- (void)JingGe_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(JingGeTransitionBlock)transitionBlock;
- (void)JingGe_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(JingGeTransitionBlock)transitionBlock completion:(void (^)(void))completion;

@end
