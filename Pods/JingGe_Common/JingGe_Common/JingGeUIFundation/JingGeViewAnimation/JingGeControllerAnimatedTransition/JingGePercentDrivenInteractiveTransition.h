//
//  JingGePercentDrivenInteractiveTransition.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeTransitionTypeConfig.h"
typedef void(^ActionBlock)(void);
//继承自 实现了UIViewControllerInteractiveTransitioning协议的UIPercentDrivenInteractiveTransition
@interface JingGePercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) JingGeGestureType getstureType;
@property (readonly, assign, nonatomic) BOOL isInteractive;
@property (nonatomic, assign) JingGeTransitionType transitionType;

@property (nonatomic, copy) ActionBlock presentBlock;
@property (nonatomic, copy) ActionBlock pushBlock;
@property (nonatomic, copy) ActionBlock dismissBlock;
@property (nonatomic, copy) ActionBlock popBlock;

@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);

-(void)addGestureToViewController:(UIViewController *)vc;
@end
