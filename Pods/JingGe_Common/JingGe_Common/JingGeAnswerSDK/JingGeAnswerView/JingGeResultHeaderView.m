//
//  JingGeResultHeaderView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeResultHeaderView.h"
#import "JingGeAnswerModel.h"
#import "JingGeAnswerConfig.h"
#import "JingGeMacro.h"
@interface ParsingHeaderViewTopView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UILabel *totalScoreLabel;
@property (strong, nonatomic) UILabel *detailLabel;

@property (strong, nonatomic) JingGeAnswerModel *model;
@end

@implementation ParsingHeaderViewTopView

- (id)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.imageView];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.totalScoreLabel];
    [self addSubview:self.detailLabel];
}

- (void)subviewsLayout {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavigationBar_HEIGHT + kStatusBar_HEIGHT + 15);
        make.centerX.mas_equalTo(self);
    }];
    
    [_totalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scoreLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.totalScoreLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self);
    }];
}
- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    
    // 创建一个富文本
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@分",model.score]];
    
    // 修改富文本中的不同文字的样式
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(model.score.length, 1)];
    
    self.scoreLabel.attributedText = attri;
    self.totalScoreLabel.text = [NSString stringWithFormat:@"总分: %@", model.totalScore];
    
    self.detailLabel.text = [NSString stringWithFormat:@"共%lu道题, 答对%lu道, 答错%lu道, 未作答%lu道", (unsigned long)model.questionList.count, (unsigned long)model.answerTrueList.count, (unsigned long)model.answerFaultList.count, (unsigned long)model.unAnswerList.count];
    
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:kGetImage(@"img_bg_report")];
    }
    return _imageView;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [UILabel new];
        _scoreLabel.font = UISYSTEM_FONT(45);
        _scoreLabel.textColor = UIColorFromHex(0x333330);
    }
    return _scoreLabel;
}

- (UILabel *)totalScoreLabel {
    if (!_totalScoreLabel) {
        _totalScoreLabel = [UILabel new];
        _totalScoreLabel.font = UISYSTEM_FONT(12);
        _totalScoreLabel.textColor = UIColorFromHex(0x73736d);
    }
    return _totalScoreLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = UISYSTEM_FONT(14);
        _detailLabel.textColor = UIColorFromHex(0x73736d);
    }
    return _detailLabel;
}

@end

@interface ParsingHeaderViewMidView ()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) JingGeAnswerModel *model;
@end

@implementation ParsingHeaderViewMidView

- (id)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
}

- (void)subviewsLayout {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(kDefaultSpace);
        make.right.mas_equalTo(-20);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo( - 20);
        make.left.mas_equalTo(kDefaultSpace);
        make.right.mas_equalTo(-20);
    }];
}
- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    _nameLabel.text = [NSString stringWithFormat:@"试卷名称: %@", model.exerciseTitle];
    _timeLabel.text = [NSString stringWithFormat:@"交卷时间: %@", model.submitTime];
    
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = UISYSTEM_FONT(14);
        _nameLabel.textColor = UIColorFromHex(0x4c4c49);
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = UISYSTEM_FONT(14);
        _timeLabel.textColor = UIColorFromHex(0x4c4c49);
    }
    return _timeLabel;
}

@end

@interface ParsingHeaderViewBottomView ()

@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) JingGeAnswerModel *model;
@end

@implementation ParsingHeaderViewBottomView

- (id)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.titleLabel];
}

- (void)subviewsLayout {
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(kDefaultSpace);
        make.trailing.leading.mas_equalTo(0);
    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.trailing.leading.mas_equalTo(kDefaultSpace);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kDefaultSpace);
        make.centerY.mas_equalTo(self);
    }];
}
- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    
}
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = UIColorFromHex(0xf6f6f6);
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColorFromHex(0xf6f6f6);
    }
    return _bottomLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"答题卡";
        _titleLabel.font = UISYSTEM_FONT(15);
        _titleLabel.textColor = UIColorFromHex(0x333330);
    }
    return _titleLabel;
}

@end


@interface JingGeResultHeaderView ()

@property (strong, nonatomic) ParsingHeaderViewTopView *topView;
@property (strong, nonatomic) ParsingHeaderViewMidView *midView;
@property (strong, nonatomic) ParsingHeaderViewBottomView *bottomView;

@end

#define kTopViewHeight 204
#define kMidViewHeight 76
#define kBottomViewHeight 53

@implementation JingGeResultHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.topView];
    [self addSubview:self.midView];
    [self addSubview:self.bottomView];
}

- (void)subviewsLayout {
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kTopViewHeight);
    }];
    
    [_midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topView.mas_bottom);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kMidViewHeight);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_midView.mas_bottom);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kBottomViewHeight);
    }];
    
}

- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    self.topView.model = model;
    self.midView.model = model;
    self.bottomView.model = model;
}

- (ParsingHeaderViewTopView *)topView {
    if (!_topView) {
        _topView = [ParsingHeaderViewTopView new];
    }
    return _topView;
}


- (ParsingHeaderViewMidView *)midView {
    if (!_midView) {
        _midView = [ParsingHeaderViewMidView new];
    }
    return _midView;
}

- (ParsingHeaderViewBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [ParsingHeaderViewBottomView new];
    }
    return _bottomView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
