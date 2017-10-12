//
//  JinGeTransitionProperty.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransitionProperty.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation JingGeTransitionProperty

-(instancetype)init {
    self = [super init];
    if (self) {
        _animationTime = 0.400082;
        self.animationType = JingGeTransitionAnimationTypeDefault;
        _backGestureType = JingGeGestureTypePanRight;
        _backGestureEnable = YES;
        _autoShowAndHideNavBar = YES;
    }
    return self;
}

@end
