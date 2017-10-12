//
//  JingGeAnswerIntroView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerIntroView.h"
#import "JingGeAnswerModel.h"
#import "JingGeAnswerConfig.h"
#import "JingGeMacro.h"
#define kTopSpace 30
#define kLeftSpace 30

@interface JingGeAnswerIntroView ()
@property (strong, nonatomic) UIImageView *groupImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@end

@implementation JingGeAnswerIntroView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.groupImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.detailLabel];
}

- (void)subviewsLayout {
    [_groupImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.bottom.mas_equalTo(-30);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.groupImageView.mas_left).offset(30);
        make.right.mas_equalTo(self.groupImageView.mas_right).offset(- 30);
        make.top.mas_equalTo(self.groupImageView.mas_top).offset(45);
        make.centerX.mas_equalTo(self.groupImageView);
    }];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.groupImageView);
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subTitleLabel.mas_bottom).offset(35);
        make.left.mas_equalTo(self.groupImageView.mas_left).offset(30);
        make.right.mas_equalTo(self.groupImageView.mas_right).offset(-30);
        make.bottom.mas_lessThanOrEqualTo(self.groupImageView.mas_bottom).offset(-45);
    }];
    
    
}

- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    self.titleLabel.text = model.exerciseTitle;
    self.subTitleLabel.text = [NSString stringWithFormat:@"总分: %@分", model.totalScore];
    self.detailLabel.text = model.exerciseIntro;
    
}

- (UIImageView *)groupImageView {
    if (!_groupImageView) {
        _groupImageView = [[UIImageView alloc]initWithImage:kGetImage(@"img_bg_practice")];
    }
    return _groupImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = UISYSTEM_FONT(15);
        _titleLabel.textColor = UIColorFromHex(0x333330);
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = UISYSTEM_FONT(12);
        _subTitleLabel.textColor = UIColorFromHex(0x999990);
    }
    return _subTitleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = UISYSTEM_FONT(13);
        _detailLabel.textColor = UIColorFromHex(0x73736d);
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
