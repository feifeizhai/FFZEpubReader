//
//  JingGePercentDrivenInteractiveTransition.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGePercentDrivenInteractiveTransition.h"
@interface JingGePercentDrivenInteractiveTransition ()
{
    BOOL _isInter;
}

@property (nonatomic, weak  ) UIViewController *vc;  //
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat percent;



@end
@implementation JingGePercentDrivenInteractiveTransition
-(void)addGestureToViewController:(UIViewController *)vc{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    self.vc = vc;
    [vc.view addGestureRecognizer:pan];
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    
    _percent = 0.0;
    CGFloat totalWidth = pan.view.bounds.size.width;
    CGFloat totalHeight = pan.view.bounds.size.height;
    switch (self.getstureType) {
            
        case JingGeGestureTypePanLeft:{
            CGFloat x = [pan translationInView:pan.view].x;
            _percent = -x/totalWidth;
        }
            break;
        case JingGeGestureTypePanRight:{
            CGFloat x = [pan translationInView:pan.view].x;
            _percent = x/totalWidth;
        }
            break;
        case JingGeGestureTypePanDown:{
            
            CGFloat y = [pan translationInView:pan.view].y;
            _percent = y/totalHeight;
            
        }
            break;
        case JingGeGestureTypePanUp:{
            CGFloat y = [pan translationInView:pan.view].y;
            _percent = -y/totalHeight;
        }
            
        default:
            break;
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            _isInter = YES;
            [self beganGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:_percent];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            _isInter = NO;
            
            [self continueAction];
            
        }
            break;
        default:
            break;
    }
}



-(void)beganGesture{
    
    switch (_transitionType) {
        case JingGeTransitionTypePresent:{
            _presentBlock? _presentBlock() : nil;
        }
            break;
        case JingGeTransitionTypeDismiss:{
            _dismissBlock ? _dismissBlock() : [_vc dismissViewControllerAnimated:YES completion:^{
            }];
        }
            break;
        case JingGeTransitionTypePush: {
            _pushBlock ? _pushBlock() : nil;
        }
            break;
        case JingGeTransitionTypePop:{
            _popBlock ? _popBlock() : [_vc.navigationController popViewControllerAnimated:YES];
            
        }
            break;
        default:
            break;
    }
    
}

- (BOOL)isInteractive {
    return _isInter;
}

- (void)continueAction{
    if (_displayLink) {
        return;
    }
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(UIChange)];
    [_displayLink  addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)UIChange {
    
    CGFloat timeDistance = 2.0/60;
    if (_percent > 0.4) {
        _percent += timeDistance;
    }else {
        _percent -= timeDistance;
    }
    [self updateInteractiveTransition:_percent];
    
    if (_percent >= 1.0) {
        
        _willEndInteractiveBlock ? _willEndInteractiveBlock(YES) : nil;
        [self finishInteractiveTransition];
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
    if (_percent <= 0.0) {
        
        _willEndInteractiveBlock ? _willEndInteractiveBlock(NO) : nil;
        
        [_displayLink invalidate];
        _displayLink = nil;
        [self cancelInteractiveTransition];
    }
}

@end
