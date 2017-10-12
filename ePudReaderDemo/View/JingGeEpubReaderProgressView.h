//
//  JingGeEpubReaderProgressView.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/20.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeEpubReaderConfig.h"
@interface JingGeEpubReaderProgressView : UIView

@property (assign, nonatomic) float value;

- (instancetype)initWithSliderBlock:(EpubReaderSliderBlock)sliderBlock;

@end
