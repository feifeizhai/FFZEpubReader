//
//  JingGeAnswerSheetCollectionViewCell.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerSheetCollectionViewCell.h"
#import "JingGeQuestionModel.h"
#import "JingGeMacro.h"
@interface JingGeAnswerSheetCollectionViewCell ()

@property (strong, nonatomic) UIButton *titleButton;

@end

@implementation JingGeAnswerSheetCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self.contentView addSubview:self.titleButton];
}

- (void)subviewsLayout {
    [_titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
    }];
}

#pragma mark 赋值
- (void)setModel:(JingGeQuestionModel *)model {
    _model = model;
    [_titleButton setTitle:model.quesNum forState:UIControlStateNormal];
    if (self.parsingType == JingGeParsingTypeSuccess) {
        if (model.answerState == JingGeAnswerStateUnAnswer) {
            _titleButton.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
            _titleButton.backgroundColor = [UIColor clearColor];
            [_titleButton setTitleColor:UIColorFromHex(0x73736d) forState:UIControlStateNormal];
        }else {
            if (model.answerResult == JingGeAnswerResultFault) {
                _titleButton.layer.borderColor = [UIColor clearColor].CGColor;
                _titleButton.backgroundColor = self.config.jingGeAnswerFaultColor;
                [_titleButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateNormal];
            }else {
                _titleButton.layer.borderColor = self.config.jingGeAnswerTruetColor.CGColor;
                _titleButton.backgroundColor = [UIColor clearColor];
                [_titleButton setTitleColor:UIColorFromHex(0x73736d) forState:UIControlStateNormal];
            }
        }
    }else {
        if (model.answerState == JingGeAnswerStateUnAnswer) {
            _titleButton.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
            _titleButton.backgroundColor = [UIColor clearColor];
            [_titleButton setTitleColor:UIColorFromHex(0x73736d) forState:UIControlStateNormal];
        }else {
            _titleButton.layer.borderColor = [UIColor clearColor].CGColor;
            _titleButton.backgroundColor = self.config.jingGeAnswerMainColor;
            [_titleButton setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateNormal];
        }
    }
    
}

#pragma mark 懒加载
- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _titleButton.layer.cornerRadius = 20;
        _titleButton.layer.borderWidth = 0.5;
        _titleButton.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
        _titleButton.titleLabel.font = UISYSTEM_FONT(16);
        [_titleButton setTitleColor:UIColorFromHex(0x73736d) forState:UIControlStateNormal];
        _titleButton.userInteractionEnabled = NO;
    }
    return _titleButton;
}



@end
