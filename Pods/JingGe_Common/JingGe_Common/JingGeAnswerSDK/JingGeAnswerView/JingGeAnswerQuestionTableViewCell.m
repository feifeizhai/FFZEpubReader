//
//  JingGeAnswerHeaderTableViewCell.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerQuestionTableViewCell.h"
#import "JingGeQuestionModel.h"
#import "JingGeMacro.h"
#import "JingGeAnswerImageView.h"
#import "JingGeDataManager.h"
#import "JingGePicReaderViewController.h"

#import "UINavigationController+JingGeTransition.h"
#define kBtnLeftSpace 10
#define kSimgleImageWidth kScreenWidth - 55
#define kDoubleImageWidth kScreenWidth / 2 - 22.5
@interface JingGeAnswerQuestionTableViewCell ()<JingGeAnswerImageViewDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) JingGeAnswerImageView *contentImage;
@property (strong, nonatomic) UIButton *typeBtn;

@end

@implementation JingGeAnswerQuestionTableViewCell

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
    [self.contentView addSubview:self.typeBtn];
    [self.contentView addSubview:self.contentImage];
}


- (void)subviewLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kBtnLeftSpace);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(- kBtnLeftSpace);
    }];
    
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}
#pragma mark 赋值
- (void)setModel:(JingGeQuestionModel *)model {
    _model = model;
    // 创建一个富文本
    NSMutableAttributedString *attri =   [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@. %@  ( %@分 )   ", model.quesNum, model.quesTitle, model.score]];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = kGetImage(model.quesTypeImage);
    // 设置图片大小
    attch.bounds = CGRectMake(0, - 2, 40, 15);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    
    NSTextAttachment *stateAttch = [[NSTextAttachment alloc] init];
    
    if (self.parsingType == JingGeParsingTypeNone) {
        
    }else if (self.parsingType == JingGeParsingTypeSuccess){
        
        if (model.answerResult == JingGeAnswerResultFault) {
            stateAttch.image = kGetImage(@"img_fault");
        }else if (model.answerResult == JingGeAnswerResultTrue) {
            stateAttch.image = kGetImage(@"img_true");
        }
    }
    // 设置图片大小
    stateAttch.bounds = CGRectMake(0, - 5, 22, 22);
    NSAttributedString *statestring = [NSAttributedString attributedStringWithAttachment:stateAttch];
    [attri appendAttributedString:statestring];
    
    self.titleLabel.attributedText = attri;
    self.contentImage.imageNames = model.imageUrlLists;
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kBtnLeftSpace);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-kBtnLeftSpace);
        // make.bottom.mas_equalTo(20);
    }];
    
    NSInteger height = 0;
    if (model.imageUrlLists.count == 1) {
        height  = ((kScreenWidth - 55) / 1.6) + 30;
    }else if (model.imageUrlLists.count > 1){
        height = (((model.imageUrlLists.count - 1) / 2) + 1) * (((kScreenWidth / 2 - 22.5) / 1.6) + 30);
    }else {
        return;
    }
    
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
    _titleLabel.textColor = self.config.jingGeQuestionTextColor;
    _titleLabel.font = self.config.jingGeQuestionTextFont;
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
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (JingGeAnswerImageView *)contentImage {
    if (!_contentImage) {
        _contentImage = [[JingGeAnswerImageView alloc]init];
        _contentImage.delegate = self;
        //_contentImage.userInteractionEnabled = NO;
    }
    return _contentImage;
}

- (UIButton *)typeBtn {
    if (!_typeBtn) {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _typeBtn;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
