//
//  JingGeAnswerTableViewAnalysisHeaderView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerTableViewAnalysisFooterView.h"
#import "JingGeMacro.h"
#import "JingGeQuestionModel.h"
#import "JingGeOptionModel.h"
#import "JingGeDataManager.h"
@interface JingGeAnswerTableViewAnalysisFooterView ()

@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *answerLabel;
@property (strong, nonatomic) UILabel *parsingLabel;

@end
@implementation JingGeAnswerTableViewAnalysisFooterView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.topLine];
    [self addSubview:self.titleLabel];
    [self addSubview:self.answerLabel];
    [self addSubview:self.parsingLabel];
}

- (void)subviewsLayout {
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kDefaultSpace);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
    }];
    [_answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.titleLabel);
    }];
    [_parsingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.answerLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(-15);
    }];
}

- (void)updateLayout {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.parsingLabel.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark 赋值

- (void)setModel:(JingGeQuestionModel *)model {
    _model = model;
    NSString *answerLabelText = @"正确答案: ";
    for (JingGeOptionModel *optionModel in model.tureOption) {
        answerLabelText = [answerLabelText stringByAppendingString:optionModel.optionLetter];
    }
    
    self.answerLabel.text = answerLabelText;
    self.parsingLabel.text = model.explain;
}

- (void)setConfig:(JingGeAnswerConfig *)config {
    _config = config;
    _titleLabel.font = self.config.jingGeParsingTitleFont;
    _titleLabel.textColor = self.config.jingGeQuestionTextColor;
    _answerLabel.font = self.config.jingGeParsingDetailFont;
    _answerLabel.textColor = self.config.jingGeOptionTextColor;
}

#pragma mark 懒加载
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = UIColorFromHex(0xf6f6f6);
        
    }
    return _topLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"题目解析";
        
        _titleLabel.backgroundColor = kRandColor;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)answerLabel {
    if (!_answerLabel) {
        _answerLabel = [UILabel new];
   
        _answerLabel.backgroundColor = kRandColor;
        [_answerLabel sizeToFit];
    }
    return _answerLabel;
}

- (UILabel *)parsingLabel {
    if (!_parsingLabel) {
        _parsingLabel = [UILabel new];
        _parsingLabel.font = UISYSTEM_FONT(12);
        _parsingLabel.textColor = UIColorFromHex(0x999990);
        _parsingLabel.backgroundColor = kRandColor;
        _parsingLabel.numberOfLines = 0;
        _parsingLabel.text = @"--";
        [_parsingLabel sizeToFit];
    }
    return _parsingLabel;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
