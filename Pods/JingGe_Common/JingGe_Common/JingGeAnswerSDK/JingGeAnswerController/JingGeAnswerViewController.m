//
//  JingGeAnswerViewController.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerViewController.h"
#import "JingGeCoverViewController.h"
#import "JingGeAnswerPageViewController.h"
#import "JingGeAnswerSheetViewController.h"
#import "JingGeAnswerSheetView.h"
#import "JingGeAnswerHelper.h"
#import "JingGeMacro.h"
#import "JingGeAnswerModel.h"
#import "JingGeDateManager.h"
#import "JingGeAnswerConfig.h"

#define kAnswerSheetHeight kScreenHeight / 6 * 5

#define kAlertTitle @"提示"
#define kAlertMessage(count) [NSString stringWithFormat:@"您还剩%ld题未做, 确定交卷么?",count]

@interface JingGeAnswerViewController ()<JingGeCoverControllerDelegate, JingGeAnswerPageViewControllerDelegate, JingGeAnswerSheetViewDelegate, JingGeAnswerSheetViewControllerDelegate>

@property (strong, nonatomic) JingGeCoverController *coverVC;

@property (strong, nonatomic) JingGeAnswerHelper *helper;

@property (strong, nonatomic) JingGeAnswerSheetView *answerSheetView;



@end

@implementation JingGeAnswerViewController

- (void)dealloc {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [_answerSheetView removeFromSuperview];
}

- (id)initWithConfigBlock:(jingGeAnswerConfigBlock)configBlock {
    self = [super init];
    if (self) {
        configBlock(self.answerConfig);
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    // self.dataArray = [[JingGeAnswerHelper creatDataArray] mutableCopy];
    
    [self addSubviews];
    [self subviewsLayout];
    
}

- (void)addSubviews {
    [self.view addSubview:self.coverVC.view];
    [self.view addSubview:self.answerSheetView];
    // [self.view addSubview:self.answerSheetView];
}

- (void)subviewsLayout {
    [_answerSheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kAnswerSheetHeight - kToolsBar_HEIGHT);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kAnswerSheetHeight);
    }];
}

#pragma mark CoverControllerDelegate
// 切换结果
- (void)coverController:(JingGeCoverController * _Nonnull)coverController currentController:(UIViewController * _Nullable)currentController finish:(BOOL)isFinish {
    if (!isFinish) { // 切换失败
        if (coverController.isLeft) {
            self.page += 1;
            
            if (self.page ==  self.dataArray.count) {
                [self hidAnswerSheet];
            }
            
        }else {
            self.page -= 1;
            if (self.page <  self.dataArray.count) {
                [self showAnswerSheet];
            }
        }
        self.answerSheetView.pageNum = [self pageNum];
    }
    
}
// 上一页
- (UIViewController * _Nullable)coverController:(JingGeCoverController * _Nonnull)coverController getAboveControllerWithCurrentController:(UIViewController * _Nullable)currentController {
    
    self.page -= 1;
    if (self.page < 0) {
        self.page += 1;
        return nil;
    }
    
    JingGeAnswerPageViewController *pageVC = [self pageViewController];
    // pageVC.model = [self.dataArray objectAtIndex: self.page];
    [self showAnswerSheet];
    
    return pageVC;
}
// 下一页
- (UIViewController * _Nullable)coverController:(JingGeCoverController * _Nonnull)coverController getBelowControllerWithCurrentController:(UIViewController * _Nullable)currentController {
    self.page += 1;
    if (self.page > self.dataArray.count) {
        self.page -= 1;
        return nil;
    }
    
    if (self.page == self.dataArray.count && self.parsingType == JingGeParsingTypeNone) {
        JingGeAnswerSheetViewController *sheetVC = [[JingGeAnswerSheetViewController alloc]init];
        sheetVC.model = self.model;
        sheetVC.config = self.answerConfig;
        sheetVC.delegate = self;
        [self hidAnswerSheet];
        return sheetVC;
    }
    
    if (self.page == self.dataArray.count) {
        self.page -= 1;
        return nil;
    }
    
    JingGeAnswerPageViewController *pageVC = [self pageViewController];
    //pageVC.model = [self.dataArray objectAtIndex: self.page];
    
    return pageVC;
}

#pragma mark JingGeAnswerPageViewControllerDelegate
- (void)toNextQuestionTableView:(JingGeAnswerPageViewController *)tableView {
    if (self.page < 0) {
        return;
    }
    self.page += 1;
    if (self.page > self.dataArray.count) {
        self.page -= 1;
        
        return;
    }
    if (self.page == self.dataArray.count && self.parsingType == JingGeParsingTypeNone) {
        JingGeAnswerSheetViewController *sheetVC = [[JingGeAnswerSheetViewController alloc]init];
        sheetVC.delegate = self;
        sheetVC.model = self.model;
        sheetVC.config = self.answerConfig;
        [sheetVC.view setNeedsLayout];
        [sheetVC.view layoutIfNeeded];
        [self.coverVC setController:sheetVC animated:YES isAbove:NO];
        
        [self hidAnswerSheet];
    }else {
        if (self.page == self.dataArray.count) {
            self.page -= 1;
            
            return;
        }
        JingGeAnswerPageViewController *pageVC = [self pageViewController];
        //pageVC.model = [self.dataArray objectAtIndex: self.page];
        [self.coverVC setController:pageVC animated:YES isAbove:NO];
        [self showAnswerSheet];
        // [self showAnswerSheet];
    }
}

#pragma mark JingGeAnswerSheetViewDelegate
- (void)answerSheetView:(JingGeAnswerSheetView *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self coverToControllerPage:indexPath.row];
}
- (void)submitButtonActionSheetView:(JingGeAnswerSheetView *)answerSheet {
    self.model.score = [NSString stringWithFormat:@"%ld", (long)[JingGeAnswerHelper getScore:self.model]];
    kWeakSelf(ws);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:kAlertTitle message:kAlertMessage((unsigned long)self.model.unAnswerList.count) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ws toViewParsing];
        
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    [kWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark JingGeAnswerSheetControllerDelegate
- (void)answerSheetViewController:(JingGeAnswerSheetViewController *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self coverToControllerPage:indexPath.row];
}
- (void)toViewParsing {
    self.model.parsingType = JingGeParsingTypeSuccess;
    self.model.score = [NSString stringWithFormat:@"%ld", (long)[JingGeAnswerHelper getScore:self.model]];
    self.model.submitTime = [JingGeDateManager currentDate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(toViewParsing:)]) {
        [self.delegate toViewParsing:self.model];
    }
}
#pragma mark 动画
- (void)coverToControllerPage:(NSInteger)page {
    
    if (self.page == page) {
        return;
    }
    NSInteger tempTemp = self.page;
    self.page = page;
    JingGeAnswerPageViewController *pageVC = [self pageViewController];
    pageVC.model = [self.dataArray objectAtIndex: page];
    [self.coverVC setController:pageVC animated:YES isAbove:tempTemp > page ? YES : NO];
    
}

- (void)showAnswerSheet {
    [_answerSheetView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kAnswerSheetHeight - kToolsBar_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidAnswerSheet {
    [_answerSheetView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kAnswerSheetHeight);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 赋值
- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    self.parsingType = model.parsingType;
    self.dataArray = [model.questionList mutableCopy];
    self.answerSheetView.model = model;
    if (model.parsingType) {
        self.answerSheetView.hidden = YES;
    }else {
        self.answerSheetView.hidden = NO;
    }
}
#pragma mark 懒加载
- (JingGeCoverController *)coverVC {
    
    if (!_coverVC) {
        _coverVC = [[JingGeCoverController alloc] init];
        _coverVC.delegate = self;
        _coverVC.openTapGesture = NO;
        [self addChildViewController:_coverVC];
        _coverVC.view.frame = self.view.bounds;
        [_coverVC setController:[self pageViewController]];
    }
    return _coverVC;
}

- (JingGeAnswerPageViewController *)pageViewController {
    
    JingGeAnswerPageViewController *pageVC = [[JingGeAnswerPageViewController alloc] init];
    pageVC.delegate = self;
    pageVC.config = self.answerConfig;
    pageVC.parsingType = self.model.parsingType;
    pageVC.model = [self.dataArray objectAtIndex:self.page];
    self.answerSheetView.pageNum = [self pageNum];
    
    return pageVC;
}

- (JingGeAnswerSheetView *)answerSheetView {
    if (!_answerSheetView) {
        _answerSheetView = [JingGeAnswerSheetView new];
        _answerSheetView.config = self.answerConfig;
        _answerSheetView.delegate = self;
    }
    return _answerSheetView;
}

- (JingGeAnswerConfig *)answerConfig {
    if (!_answerConfig) {
        _answerConfig = [JingGeAnswerConfig new];
    }
    return _answerConfig;
}

- (NSString *)pageNum {
    return [NSString stringWithFormat:@"%ld/%lu", (long)self.page + 1, (unsigned long)self.dataArray.count];
}

- (void)dismissBack {
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
