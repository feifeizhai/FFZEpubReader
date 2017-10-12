//
//  UIButton+JingGeButton.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/16.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JingGeButton)

/**
 倒计时button

 @param timeLine time
 @param title title
 @param subTitle countDownTitle
 @param mColor mainColor
 @param color countColor
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;
@end
