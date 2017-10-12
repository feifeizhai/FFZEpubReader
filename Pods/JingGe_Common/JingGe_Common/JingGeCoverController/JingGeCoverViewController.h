//
//  JingGeCoverViewController.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/4.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//


/*
 仿UIPageViewController 可以用于小说覆盖翻页样式使用
 */

#import <UIKit/UIKit.h>

@class JingGeCoverController;

@protocol JingGeCoverControllerDelegate <NSObject>

@optional

/**
 *  切换是否完成
 *
 *  @param coverController   coverController
 *  @param currentController 当前正在显示的控制器
 *  @param isFinish          切换是否成功
 */
- (void)coverController:(JingGeCoverController * _Nonnull)coverController currentController:(UIViewController * _Nullable)currentController finish:(BOOL)isFinish;

/**
 *  将要显示的控制器
 *
 *  @param coverController   coverController
 *  @param pendingController 将要显示的控制器
 */
- (void)coverController:(JingGeCoverController * _Nonnull)coverController willTransitionToPendingController:(UIViewController * _Nullable)pendingController;

/**
 *  获取上一个控制器
 *
 *  @param coverController   coverController
 *  @param currentController 当前正在显示的控制器
 *
 *  @return 返回当前显示控制器的上一个控制器
 */
- (UIViewController * _Nullable)coverController:(JingGeCoverController * _Nonnull)coverController getAboveControllerWithCurrentController:(UIViewController * _Nullable)currentController;

/**
 *  获取下一个控制器
 *
 *  @param coverController   coverController
 *  @param currentController 当前正在显示的控制器
 *
 *  @return 返回当前显示控制器的下一个控制器
 */
- (UIViewController * _Nullable)coverController:(JingGeCoverController * _Nonnull)coverController getBelowControllerWithCurrentController:(UIViewController * _Nullable)currentController;

@end

@interface JingGeCoverController : UIViewController

/**
 *  代理
 */
@property (nonatomic,weak,nullable) id<JingGeCoverControllerDelegate> delegate;

/**
 *  手势启用状态 default:YES
 */
@property (nonatomic,assign) BOOL gestureRecognizerEnabled;

/**
 *  当前手势操作是否带动画效果 default: YES
 */
@property (nonatomic,assign) BOOL openAnimate;

/**
 是否开启点击手势 default: YES
 */
@property (nonatomic, assign) BOOL openTapGesture;

/**
 *  正在动画 default:NO
 */
@property (nonatomic,assign) BOOL isAnimateChange;

/**
 *  当前控制器
 */
@property (nonatomic,strong,readonly,nullable) UIViewController *currentController;
/**
 *  手势触发点在左边 辨认方向 左边拿上一个控制器  右边拿下一个控制器
 */
@property (nonatomic,assign) BOOL isLeft;
/**
 *  手动设置显示控制器 无动画
 *
 *  @param controller 设置显示的控制器
 */
- (void)setController:(UIViewController * _Nullable)controller;

/**
 *  手动设置显示控制器
 *
 *  @param controller 设置显示的控制器
 *  @param animated   是否需要动画
 *  @param isAbove    动画是否从上面显示 YES   从下面显示 NO
 */
- (void)setController:(UIViewController * _Nullable)controller animated:(BOOL)animated isAbove:(BOOL)isAbove;

@end

