//
//  UIImageView+JingGeImageView.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/16.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "UIImageView+JingGeImageView.h"

#import "UIImage+JingGeImage.h"

#import <UIImageView+WebCache.h>

#import "JingGeMacro.h"
@implementation UIImageView (JingGeImageView)

- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)image size:(CGSize)size
{
    kWeakSelf(ws);
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        UIImage *scaleImage = image;
        if (size.width > 0) {
            scaleImage = [image toScaleSize:size];
        }
        ws.image = scaleImage;
    }];
}


@end
