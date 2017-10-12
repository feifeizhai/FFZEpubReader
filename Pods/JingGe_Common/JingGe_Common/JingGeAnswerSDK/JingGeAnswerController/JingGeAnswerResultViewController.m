//
//  JingGeAnswerResultViewController.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerResultViewController.h"
#import "JingGeResultHeaderView.h"
#import "JingGeAnswerSheetCollectionView.h"
#import "JingGeNavigationBar.h"
#import "JingGeAnswerModel.h"
#import "JingGeAnswerViewController.h"
#import "JingGeMacro.h"
#import "UIViewController+JingGeTransition.h"
#import "JingGeAnswerConfig.h"
#import "JingGeBaseNavigationController.h"
#define kHeaderHeight 333
#define kBtnTitleParsing @"全题解析"
@interface JingGeAnswerResultViewController ()<JingGeAnswerSheetCollectionViewDelegate>
@property (strong, nonatomic) JingGeResultHeaderView *headerView;

@property (strong, nonatomic) JingGeAnswerSheetCollectionView *collectionView;

@property (strong, nonatomic) UIButton *parsingButton;

@property (strong, nonatomic) JingGeNavigationBar *naviBar;

@property (strong, nonatomic) UIButton *backButton;

@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation JingGeAnswerResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    [self subviewsLayout];
    [self addAction];
    
    // Do any additional setup after loading the view.
}

- (void)addSubviews {
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.parsingButton];
    [self.view addSubview:self.naviBar];
    
    self.titleLabel.text = self.model.exerciseTitle;
}

- (void)subviewsLayout {
    
    
    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBar_HEIGHT + kStatusBar_HEIGHT);
        make.trailing.left.mas_equalTo(0);
        
    }];
    
    [_parsingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
        make.trailing.left.mas_equalTo(0);
        
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
        make.bottom.mas_equalTo(_parsingButton.mas_top).offset(- kDefaultSpace * 2);
    }];
    
}

- (void)addAction {
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_parsingButton addTarget:self action:@selector(parsingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark actionMethed
- (void)backButtonAction:(UIButton *)button {
    [self dismissBack];
}

- (void)parsingButtonAction:(UIButton *)button {
    JingGeAnswerViewController *answerVC = [JingGeAnswerViewController new];
    answerVC.model = [self.model copy];
    
    JingGeBaseNavigationController *navi = [[JingGeBaseNavigationController alloc]initWithRootViewController:answerVC];
    [[UINavigationBar appearance] setTintColor:self.config.jingGeAnswerNaviTitleColor];
    answerVC.title = self.model.exerciseTitle;
    answerVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kGetImage(@"btn_defaukt_back") style:UIBarButtonItemStylePlain target:answerVC action:@selector(dismissBack)];
    navi.navigationBar.barTintColor = self.config.jingGeAnswerMainColor;
    [self JingGe_presentViewController:navi makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationType = JingGeTransitionAnimationTypeSysPushFromRight;
        transition.animationTime = 0.25;
        transition.backGestureEnable = YES;
    } completion:^{
        //[self.navigationController popViewControllerAnimated:NO];
    }];
    
}

#pragma mark sheetViewDelegate
- (void)answerSheetViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    NSLog(@"%f", offset);
    CGFloat scale = offset / (kNavigationBar_HEIGHT + kStatusBar_HEIGHT);
    self.naviBar.backgroundColor = [UIColor colorWithRed:((float)((0xf2ba00 & 0xFF0000) >> 16)) / 255.0 green:((float)((0xf2ba00 & 0xFF00) >> 8)) / 255.0 blue:((float)(0xf2ba00 & 0xFF)) / 255.0 alpha:scale];
    if (scale >= 1.0) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@分", self.model.score];
    }else {
        self.titleLabel.text = self.model.exerciseTitle;
    }
}

- (void)answerSheetView:(JingGeAnswerSheetCollectionView *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JingGeAnswerViewController *answerVC = [JingGeAnswerViewController new];
    answerVC.model = [self.model copy];
    answerVC.page = indexPath.row;
    
    JingGeBaseNavigationController *navi = [[JingGeBaseNavigationController alloc]initWithRootViewController:answerVC];
    [[UINavigationBar appearance] setTintColor:self.config.jingGeAnswerNaviTitleColor];
    //navi.navigationBar.tintColor = self.config.jingGeAnswerNaviTitleColor;
    answerVC.title = self.model.exerciseTitle;
    answerVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kGetImage(@"btn_defaukt_back") style:UIBarButtonItemStylePlain target:answerVC action:@selector(dismissBack)];
    navi.navigationBar.barTintColor = self.config.jingGeAnswerMainColor;
    [self JingGe_presentViewController:navi makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationType = JingGeTransitionAnimationTypeSysPushFromRight;
        transition.animationTime = 0.25;
        transition.backGestureEnable = YES;
    } completion:^{
        //[self.navigationController popViewControllerAnimated:NO];
    }];
    
}

- (UICollectionReusableView *)answerSheetView:(JingGeAnswerSheetCollectionView *)answerSheetView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    _headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([JingGeResultHeaderView class]) forIndexPath:indexPath];
    _headerView.model = self.model;
    
    return _headerView;
}

#pragma mark 懒加载

- (JingGeNavigationBar *)naviBar {
    if (!_naviBar) {
        _naviBar = [JingGeNavigationBar new];
        _naviBar.backItem = self.backButton;
        _naviBar.titleItem = self.titleLabel;
    }
    return _naviBar;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:kGetImage(@"btn_defaukt_back") forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = self.config.jingGeAnswerNaviTitleFont;
        _titleLabel.textColor = self.config.jingGeAnswerNaviTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (JingGeAnswerSheetCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[JingGeAnswerSheetCollectionView alloc]initWithFrame:self.view.bounds];
        _collectionView.sheetDelegate = self;
        _collectionView.layout.headerReferenceSize = CGSizeMake(kScreenWidth, kHeaderHeight);
        _collectionView.config = self.config;
        [_collectionView registerClass:[JingGeResultHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([JingGeResultHeaderView class])];
        
        _collectionView.model = self.model;
        //_collectionView.delegate = self;
        
    }
    return _collectionView;
}



- (UIButton *)parsingButton {
    if (!_parsingButton) {
        _parsingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _parsingButton.backgroundColor = self.config.jingGeAnswerMainColor;
        [_parsingButton setTitleColor:self.config.jingGeAnswerBtnTextColor forState:UIControlStateNormal];
        [_parsingButton setTitle:kBtnTitleParsing forState:UIControlStateNormal];
        _parsingButton.titleLabel.font = UISYSTEM_FONT(16);
    }
    return _parsingButton;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
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
