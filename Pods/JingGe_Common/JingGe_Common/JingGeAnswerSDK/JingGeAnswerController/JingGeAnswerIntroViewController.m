//
//  JingGeAnswerIntroViewController.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerIntroViewController.h"
#import "JingGeAnswerIntroView.h"
#import "JingGeAnswerHelper.h"
#import "JingGeAnswerModel.h"
#import "JingGeAnswerViewController.h"
#import "JingGeAnswerResultViewController.h"
#import "UIViewController+JingGeTransition.h"
#import "JingGeMacro.h"
#import "JingGeAnswerConfig.h"
#import "MBProgressHUD.h"
#define kSpace 30
#define kBtnSize CGSizeMake(160, 40)
#define kBtnTitle @"开始答题"
#define kQuestionErrer @"没有题目"

@interface JingGeAnswerIntroViewController ()<JingGeAnswerViewControllerDelegate>

@property (strong, nonatomic) JingGeAnswerIntroView *introView;
@property (strong, nonatomic) UIButton *answerButton;
@property (strong, nonatomic) JingGeAnswerHelper *helper;


@property (strong, nonatomic) JingGeAnswerConfig *config;

@property (copy, nonatomic) buttonActionBlock buttonActionBlock;

@end

@implementation JingGeAnswerIntroViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    /*
     if (!self.model) {
     [self network];
     }else {
     self.model = [Jg_RspExerciseHelper restoreModel:self.model];
     }
     */
}

- (instancetype)initWithConfig:(jingGeAnswerConfigBlock)configBlock buttonAction:(buttonActionBlock)buttonActionBlock {
    self = [super init];
    if (self) {
        configBlock(self.config);
        self.buttonActionBlock = buttonActionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self subviewsLayout];
    [self addAction];
    // Do any additional setup after loading the view.
}

- (void)addSubviews {
    [self.view addSubview:self.introView];
    [self.view addSubview:self.answerButton];
}

- (void)subviewsLayout {
    [_introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavigationBar_HEIGHT + kStatusBar_HEIGHT);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(self.introView.mas_width);
    }];
    [_answerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.introView.mas_bottom).offset(kSpace);
        make.size.mas_equalTo(kBtnSize);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)addAction {
    [_answerButton addTarget:self action:@selector(answerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark Action Method
- (void)answerButtonAction:(UIButton *)button {
    
    JingGeAnswerViewController *answerVC = [JingGeAnswerViewController new];
    answerVC.answerConfig = self.config;
    answerVC.title = self.model.exerciseTitle;
    answerVC.delegate = self;
    answerVC.model = [self.model copy];
    
    if (self.model.questionList.count <= 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.textColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.label.text = kQuestionErrer;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:2];
        return;
    }
    
    [self.navigationController pushViewController:answerVC animated:YES];
    
}

#pragma mark network
/*
 - (void)network {
 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 NSDictionary *param = @{kResourceId : self.resourceId};
 [Jg_RspExerciseHelper reloadDateWithParam:param URL:kJg_GetQuestionsURL success:^(id responseObject) {
 self.model = responseObject;
 [MBProgressHUD hideHUDForView:self.view animated:YES];
 } failure:^(id error) {
 [MBProgressHUD hideHUDForView:self.view animated:YES];
 }];
 }
 */


#pragma mark JingGeAnswerViewControllerDelegate
- (void)toViewParsing:(JingGeAnswerModel *)model; {
    _model = model;
    JingGeAnswerResultViewController *resultVC = [[JingGeAnswerResultViewController alloc] initWithControllerGoBack:^(id sender) {
        
    }];
    resultVC.model = model;
    resultVC.config = self.config;
    resultVC.title = model.exerciseTitle;
    [self JingGe_presentViewController:resultVC makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationType = JingGeTransitionAnimationTypeSysPushFromRight;
        transition.animationTime = 0.25;
        
    } completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toViewParsingWithController:)]) {
        [self.delegate toViewParsingWithController:self];
    }
}

#pragma mark 赋值

- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    self.introView.model = model;
}

#pragma mark 懒加载
- (JingGeAnswerIntroView *)introView {
    if (!_introView) {
        _introView = [JingGeAnswerIntroView new];
    }
    return _introView;
}

- (JingGeAnswerConfig *)config {
    if (!_config) {
        _config = [JingGeAnswerConfig new];
    }
    return _config;
}

- (UIButton *)answerButton {
    if (!_answerButton) {
        _answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _answerButton.backgroundColor = self.config.jingGeAnswerMainColor;
        [_answerButton setTitleColor:self.config.jingGeAnswerBtnTextColor forState:UIControlStateNormal];
        _answerButton.titleLabel.font = self.config.jingGeAnswerBtnTextFont;
        [_answerButton setTitle:kBtnTitle forState:UIControlStateNormal];
    }
    return _answerButton;
}

- (JingGeAnswerHelper *)helper {
    if (!_helper) {
        _helper = [JingGeAnswerHelper new];
    }
    return _helper;
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
