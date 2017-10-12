//
//  UIImageView+JingGeImageView.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/16.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JingGeImageView)

- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)image size:(CGSize)size;

@end
