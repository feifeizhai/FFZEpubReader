//
//  JingGeAnswerImageView.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/13.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"

@class JingGeAnswerImageView;

@protocol JingGeAnswerImageViewDelegate <NSObject>

@optional

- (void)clickImageView:(JingGeAnswerImageView *)imageView image:(UIImage *)image index:(NSUInteger)index;

@end

@interface JingGeAnswerImageView : UIView

@property (assign, nonatomic)id<JingGeAnswerImageViewDelegate> delegate;

@property (strong, nonatomic) NSArray *imageNames;

@property (strong, nonatomic) JingGeAnswerConfig *config;

- (instancetype)initWithImageNames:(NSArray *)imageNames;

@end
