//
//  UINavigationController+JingGeTransition.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeTransitionTypeConfig.h"
#import "UIViewController+JingGeTransition.h"
@interface UINavigationController (JingGeTransition)
/*
 *
 */
- (void)JingGe_pushViewController:(UIViewController *)viewController animationType:(JingGeTransitionAnimationType) animationType;
- (void)JingGe_pushViewController:(UIViewController *)viewController makeTransition:(JingGeTransitionBlock) transitionBlock;
@end
