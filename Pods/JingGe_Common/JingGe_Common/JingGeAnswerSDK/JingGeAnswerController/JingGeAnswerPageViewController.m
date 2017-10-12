//
//  JingGeAnswerPageViewController.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerPageViewController.h"
#import "JingGeAnswerChoiseTableView.h"
#import "JingGeAnswerBlankTableView.h"
#import "JingGeQuestionModel.h"
#import "JingGeAnswerConfig.h"
#import "JingGeAnswerHelper.h"
#import "JingGeMacro.h"
@interface JingGeAnswerPageViewController ()<JingGeAnswerChoiseTableViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JingGeAnswerHelper *helper;
@end

@implementation JingGeAnswerPageViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self subviewsLayout];
    // Do any additional setup after loading the view.
}

- (void)addSubviews {
    [self.view addSubview:self.tableView];
}

- (void)subviewsLayout {
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        if (self.model.qType == JingGeQuestionTypeSingle || self.model.qType == JingGeQuestionTypeMultiple || self.model.qType == JingGeQuestionTypeJudge) {
            JingGeAnswerChoiseTableView *choiseTableView = [[JingGeAnswerChoiseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
            choiseTableView.parsingType = self.parsingType;
            choiseTableView.config = self.config;
            choiseTableView.model = self.model;
        
            choiseTableView.choiseTableViewDelegate = self;
            _tableView = choiseTableView;
        }else {
            JingGeAnswerBlankTableView *blankTableView = [[JingGeAnswerBlankTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
            //blankTableView.model = self.model;
            _tableView = blankTableView;
        }
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, kNavigationBar_HEIGHT + kStatusBar_HEIGHT + kToolsBar_HEIGHT, 0);
    }
    return _tableView;
}

- (void)toNextQuestionTableView:(JingGeAnswerChoiseTableView *)tableView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(toNextQuestionTableView:)]) {
        [self.delegate toNextQuestionTableView:self];
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
