//
//  JingGeEpubReaderProgressView.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/20.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReaderProgressView.h"
#import <JingGeMacro.h>

@interface JingGeEpubReaderProgressView ()

@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UISlider *sliderView;
@property (copy, nonatomic) EpubReaderSliderBlock sliderBlock;

@end

@implementation JingGeEpubReaderProgressView

- (instancetype)initWithSliderBlock:(EpubReaderSliderBlock)sliderBlock {
    self = [super init];
    if (self) {
        self.sliderBlock = sliderBlock;
        [self addSubviews];
        [self subviewsLayout];
        [self addAction];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.sliderView];
}

- (void)subviewsLayout {
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kDefaultSpace);
        make.centerY.mas_equalTo(self);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kDefaultSpace);
        make.centerY.mas_equalTo(self);
    }];
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftBtn.mas_right).offset(kDefaultSpace);
        make.right.mas_equalTo(_rightBtn.mas_left).offset(-kDefaultSpace);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)addAction {
    
    [_sliderView addTarget:self action:@selector(sliderViewAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)sliderViewAction:(UISlider *)slider {
    
    self.sliderBlock(slider.value);
    
}

#pragma mark 赋值
- (void)setValue:(float)value {
    _value = value;
    
    self.sliderView.value = value;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:kGetImage(@"RM_14") forState:UIControlStateNormal];
        [_leftBtn sizeToFit];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [_rightBtn setImage:kGetImage(@"RM_13") forState:UIControlStateNormal];
        
        [_rightBtn sizeToFit];
    }
    return _rightBtn;
}

- (UISlider *)sliderView {
    if (!_sliderView) {
        _sliderView = [UISlider new];
        //_sliderView.continuous = NO;
    }
    return _sliderView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
