//
//  JingGeFlatDoubleSegment.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/16.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JingGeFlatDoubleSegment : CALayer
typedef NS_ENUM(NSInteger, DoubleSegmentState) {
    doubleSegmentDefaultState,          // Vertical line
    doubleSegmentFirstQuadrantState,    // |_
    doubleSegmentSecondQuadrantState,   // _|
    doubleSegmentThridQuadrantState,    // -|
    doubleSegmentFourthQuadrantState,   // |-
    doubleSegmentLessThanState,         // <
    doubleSegmentMoreThanState,         // >
    doubleSegmentUpArrow,               // ^
    doubleSegmentDownArrow,             // Previous symbol upside-down
    doubleSegmentMinusState,            // --
    doubleSegmentSlashState45,          // \                         /
    doubleSegmentBackSlashState45,      // /
    doubleSegmentSlashState30,          // \                         /
    doubleSegmentBackSlashState30,       // /
    doubleSegmentSlashState60,          // \                         /
    doubleSegmentBackSlashState60       // /
    
    
};

@property (nonatomic) DoubleSegmentState segmentState;

@property (nonatomic, strong, nonnull) UIColor *lineColor;
@property (nonatomic) CGFloat lineThickness;
@property (nonatomic) CGFloat lineRadius;

- (nonnull)initWithLength:(CGFloat)length
                thickness:(CGFloat)lineThickness
                   radius:(CGFloat)lineRadius
                    color:(nonnull UIColor *)lineColor
             initialState:(DoubleSegmentState)initState;

- (void) moveToState:(DoubleSegmentState)finalState animated:(BOOL)animated;
- (void) movePositionToPoint:(CGPoint)finalPosition animated:(BOOL)animated;
@end
