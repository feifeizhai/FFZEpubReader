//
//  JingGeAnswerButtonFooterView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerTableViewButtonFooterView.h"
#import "JingGeMacro.h"
#import "JingGeAnswerConfig.h"
#define kBtnTitle @"确认答案"
#define kBtnSize CGSizeMake(160, 40)
@interface JingGeAnswerTableViewButtonFooterView ()

@property (strong, nonatomic) UIButton *button;

@end

@implementation JingGeAnswerTableViewButtonFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor redColor];
        [self addSubviews];
        [self subviewsLayout];
        [self addAction];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.button];
}

- (void)subviewsLayout {
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(kBtnSize);
    }];
    [self setNeedsLayout];
    [self  layoutIfNeeded];
}

- (void)addAction {
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)buttonAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonActionFooterView:)]) {
        [self.delegate buttonActionFooterView:self];
    }
}


- (void)setConfig:(JingGeAnswerConfig *)config {
    _config = config;
    [_button setTitleColor:self.config.jingGeAnswerBtnTextColor forState:UIControlStateNormal];
    _button.titleLabel.font = self.config.jingGeAnswerBtnTextFont;
    _button.backgroundColor = self.config.jingGeAnswerMainColor;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:kBtnTitle forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor blueColor];
    }
    return _button;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
