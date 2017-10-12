//
//  UIImage+JingGeImage.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/26.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3
} UIImageRoundedCorner;
@interface UIImage (JingGeImage)

/**
 从bundle中取image
 
 @param imgName imageName
 @return image
 */
+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName;

/**
 绘制圆角image

 @param radius radius
 @param cornerMask UIImageRoundedCorner
 @return image
 */
- (UIImage *)roundedRectWith:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask;

/**
 改变大小

 @param scaleSize scaleSize
 */
- (UIImage *)toScaleSize:(CGSize)scaleSize;


+ (UIImage *)captureWithView:(UIView *)view;


+ (UIImage *)captureBackView:(UIView *)view;

@end
