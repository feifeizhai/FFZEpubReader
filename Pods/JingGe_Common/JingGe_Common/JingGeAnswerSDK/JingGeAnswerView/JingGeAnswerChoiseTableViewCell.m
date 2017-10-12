//
//  JingGeAnswerChoiseTableViewCell.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerChoiseTableViewCell.h"
#import "JingGeOptionModel.h"
#import "JingGeMacro.h"
#import "JingGeAnswerImageView.h"
#import "JingGeDataManager.h"
#import "JingGePicReaderViewController.h"

#import "UINavigationController+JingGeTransition.h"
#define kBtnLeftSpace 10
#define kTitleTopSpace 17.5
#define kBtnSize 28

@interface JingGeAnswerChoiseTableViewCell ()<JingGeAnswerImageViewDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) JingGeAnswerImageView *contentImage;
@property (strong, nonatomic) UIButton *selectBtn;

@end

@implementation JingGeAnswerChoiseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        [self subviewLayout];
    }
    return self;
}

- (void)addSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.contentImage];
}

- (void)subviewLayout {
    
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kBtnLeftSpace);
        make.top.mas_equalTo(11);
        make.bottom.mas_lessThanOrEqualTo(- 11);
        make.size.mas_equalTo(kBtnSize);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(kBtnLeftSpace);
        make.right.mas_equalTo(-kBtnLeftSpace);
        make.top.mas_equalTo(kTitleTopSpace);
        make.bottom.mas_lessThanOrEqualTo(- kTitleTopSpace);
    }];
    
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark 赋值
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selectBtn.selected = isSelected;
    
    if (self.parsingType == JingGeParsingTypeNone) {
        //self.userInteractionEnabled = YES;
        if (isSelected) {
            _selectBtn.layer.borderColor = [UIColor clearColor].CGColor;
            [_selectBtn setBackgroundColor:self.config.jingGeAnswerMainColor];
        }else {
            _selectBtn.layer.borderColor = self.config.jingGeAnswerLineColor.CGColor;
            [_selectBtn setBackgroundColor:[UIColor clearColor]];
            
        }
    }else {
        //self.userInteractionEnabled = NO;
        if (isSelected) {
            _selectBtn.layer.borderColor = [UIColor clearColor].CGColor;
            [_selectBtn setBackgroundColor:self.config.jingGeParsingOptionBtnColor];
        }else {
            _selectBtn.layer.borderColor = self.config.jingGeAnswerLineColor.CGColor;
            [_selectBtn setBackgroundColor:[UIColor clearColor]];
        }
    }
}


- (void)setModel:(JingGeOptionModel *)model {
    _model = model;
    _titleLabel.text = model.optionTitle;
    self.contentImage.imageNames = model.imageUrlLists;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(kBtnLeftSpace);
        make.right.mas_equalTo(-kBtnLeftSpace);
        make.top.mas_equalTo(kTitleTopSpace);
        make.bottom.mas_lessThanOrEqualTo(- kTitleTopSpace);
    }];
    NSInteger height = 0;
    if (model.imageUrlLists.count == 1) {
        height  = ((kScreenWidth - 55) / 1.6) + 30;
    }else if (model.imageUrlLists.count > 1){
        height = (((model.imageUrlLists.count - 1) / 2) + 1) * (((kScreenWidth / 2 - 22.5) / 1.6) + 30);
    }else {
        return;
    }
    
    // self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,
    
    [self.contentImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setConfig:(JingGeAnswerConfig *)config {
    _config = config;
    _titleLabel.font = self.config.jingGeOptionTextFont;
    _titleLabel.textColor = self.config.jingGeOptionTextColor;
    _selectBtn.titleLabel.font = self.config.jingGeOptionTextFont;
    _selectBtn.layer.borderColor = self.config.jingGeAnswerLineColor.CGColor;
    [_selectBtn setTitleColor:self.config.jingGeQuestionTextColor forState:UIControlStateNormal];
}

- (void)setOptionLetter:(NSString *)optionLetter {
    [_selectBtn setTitle:optionLetter forState:UIControlStateNormal];
}

#pragma mark JingGeAnswerImageViewDelegate
- (void)clickImageView:(JingGeAnswerImageView *)imageView image:(UIImage *)image index:(NSUInteger)index {
    UIViewController *currentVC = [JingGeDataManager topViewController];
    
    JingGePicReaderViewController *picReaderVC = [[JingGePicReaderViewController alloc]initWithControllerGoBack:^(id sender) {
        
    }];
    kWeakSelf(ws);
    
    [currentVC.navigationController JingGe_pushViewController:picReaderVC makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationType = JingGeTransitionAnimationTypeSysFade;
        transition.animationTime = 0.4;
        picReaderVC.image = image;
        picReaderVC.imageURL = [ws.model.viewImageLists objectAtIndex:index];
        transition.backGestureEnable = NO;
        transition.autoShowAndHideNavBar = NO;
    }];
}

#pragma mark 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.backgroundColor = kRandColor;
        _titleLabel.numberOfLines = 0;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (JingGeAnswerImageView *)contentImage {
    if (!_contentImage) {
        _contentImage = [[JingGeAnswerImageView alloc]init];
        // _contentImage.userInteractionEnabled = NO;
        _contentImage.delegate = self;
    }
    return _contentImage;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_selectBtn setTitleColor:UIColorFromHex(0xffffff) forState:UIControlStateSelected];
        _selectBtn.layer.cornerRadius = kBtnSize / 2;
        
        _selectBtn.layer.borderWidth = 0.5;
        _selectBtn.userInteractionEnabled = NO;
        
    }
    return _selectBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        if (self.isSelected) {
            if (self.parsingType == JingGeParsingTypeNone) {
                [_selectBtn setBackgroundColor:self.config.jingGeAnswerMainColor];
            }else {
                [_selectBtn setBackgroundColor:self.config.jingGeParsingOptionBtnColor];
            }
        }else {
            [_selectBtn setBackgroundColor:[UIColor clearColor]];
        }
        
    }else {
        if (self.isSelected) {
            if (self.parsingType == JingGeParsingTypeNone) {
                [_selectBtn setBackgroundColor:self.config.jingGeAnswerMainColor];
            }else {
                [_selectBtn setBackgroundColor:self.config.jingGeParsingOptionBtnColor];
            }
            
        }else {
            [_selectBtn setBackgroundColor:[UIColor clearColor]];
        }
    }
    // Configure the view for the selected state
}

@end
