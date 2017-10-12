//
//  JingGeAnswerSheetViewController.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerSheetViewController.h"
#import "JingGeAnswerSheetCollectionView.h"
#import "JingGeMacro.h"
#import "JingGeAnswerModel.h"

#define kBtnTitleSubmit @"交卷并查看结果"
#define kBtnTitleParsing @"全题解析"

#define kHeaderHeight 333

@interface JingGeAnswerSheetViewController ()<JingGeAnswerSheetCollectionViewDelegate>

@property (strong, nonatomic) JingGeAnswerSheetCollectionView *sheetCollectionView;

@property (strong, nonatomic) UIButton *submitBtn;

@end

@implementation JingGeAnswerSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self subviewsLayout];
    [self addAction];
    // Do any additional setup after loading the view.
}

- (void)addSubviews {
    [self.view addSubview:self.sheetCollectionView];
    [self.view addSubview:self.submitBtn];
}

- (void)subviewsLayout {
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
    }];
    [_sheetCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
        make.bottom.mas_equalTo(- kToolsBar_HEIGHT);
    }];
}
- (void)addAction {
    [_submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)submitBtnAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(toViewParsing)]) {
        [self.delegate toViewParsing];
    }
}

#pragma mark sheetDelegate
- (void)answerSheetView:(JingGeAnswerSheetCollectionView *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(answerSheetViewController:didSelectItemAtIndexPath:)]) {
        [self.delegate answerSheetViewController:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark 赋值
- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
}

#pragma mark 懒加载
- (JingGeAnswerSheetCollectionView *)sheetCollectionView {
    if (!_sheetCollectionView) {
        _sheetCollectionView = [[JingGeAnswerSheetCollectionView alloc]initWithFrame:self.view.bounds];
        _sheetCollectionView.model = self.model;
        _sheetCollectionView.config = self.config;
        _sheetCollectionView.sheetDelegate = self;
    }
    return _sheetCollectionView;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.backgroundColor = self.config.jingGeAnswerMainColor;
        [_submitBtn setTitle:kBtnTitleSubmit forState:UIControlStateNormal];
        [_submitBtn setTitleColor:self.config.jingGeAnswerBtnTextColor forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = self.config.jingGeAnswerBtnTextFont;
    }
    return _submitBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
