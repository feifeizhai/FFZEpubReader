//
//  JingGeAnswerChoiseTableView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerChoiseTableView.h"
#import "JingGeAnswerChoiseTableViewCell.h"
#import "JingGeAnswerQuestionTableViewCell.h"
#import "JingGeAnswerTableViewButtonFooterView.h"
#import "JingGeAnswerTableViewAnalysisFooterView.h"
#import "JingGeQuestionModel.h"
#import "JingGeOptionModel.h"
#import "JingGeDataManager.h"
#import "JingGeAnswerHelper.h"
#import "JingGeMacro.h"
#define kFooterHeight 100

@interface JingGeAnswerChoiseTableView () <UITableViewDelegate, UITableViewDataSource, JingGeAnswerTableViewButtonFooterViewDelegate>

@property (strong, nonatomic) JingGeAnswerTableViewAnalysisFooterView *footerView;
@property (strong, nonatomic) JingGeAnswerTableViewButtonFooterView *btnFooterView;
@property (strong, nonatomic) JingGeAnswerHelper *helper;
@end

@implementation JingGeAnswerChoiseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 50;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.helper = [JingGeAnswerHelper new];
        //[self setNeedsLayout];
        //[self  layoutIfNeeded];
    }
    return self;
}

- (JingGeAnswerTableViewAnalysisFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[JingGeAnswerTableViewAnalysisFooterView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kFooterHeight)];
        
        [_footerView sizeToFit];
        
        _footerView.backgroundColor = [UIColor blueColor];
    }
    return _footerView;
}

- (JingGeAnswerTableViewButtonFooterView *)btnFooterView {
    if (!_btnFooterView) {
        _btnFooterView = [[JingGeAnswerTableViewButtonFooterView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kFooterHeight)];
        _btnFooterView.delegate = self;
        _btnFooterView.config = self.config;
    }
    return _btnFooterView;
}


#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.quesOption.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        JingGeAnswerQuestionTableViewCell *questionCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JingGeAnswerQuestionTableViewCell class])];
        if (!questionCell) {
            questionCell = [[JingGeAnswerQuestionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JingGeAnswerQuestionTableViewCell class])];
            
        }
        questionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        questionCell.parsingType = self.parsingType;
        questionCell.config = self.config;
        questionCell.model = self.model;
 
        return questionCell;
    }else {
        JingGeAnswerChoiseTableViewCell *answerCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JingGeAnswerChoiseTableViewCell class])];
        if (!answerCell) {
            answerCell = [[JingGeAnswerChoiseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JingGeAnswerChoiseTableViewCell class])];
        }
        answerCell.config = self.config;
        answerCell.model = [self.model.quesOption objectAtIndex:(indexPath.row - 1)];
        answerCell.optionLetter = [JingGeDataManager asciiToNSString:(int)(64 + indexPath.row)];
        
        answerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([self.model.answerOption containsObject:answerCell.model]) {
            answerCell.parsingType = self.parsingType;
            answerCell.isSelected = YES;
        }else {
            answerCell.parsingType = self.parsingType;
            answerCell.isSelected = NO;
        }
        
        return answerCell;
    }
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JingGeAnswerChoiseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.parsingType == JingGeParsingTypeSuccess) {
        return;
    }
    
    if (indexPath.row == 0) {
        return;
    }
    
    cell.isSelected = !cell.isSelected;
    
    self.model.answerOption = [[self.helper choise:[self.model.quesOption objectAtIndex:(indexPath.row - 1)] type:self.model.qType] copy];
    
    if ([JingGeAnswerHelper hasTrueAnswer:self.model]) {
        self.model.answerResult = JingGeAnswerResultTrue;
    }else {
        self.model.answerResult = JingGeAnswerResultFault;
    }
    if (self.model.answerOption.count > 0) {
        self.model.answerState = JingGeAnswerStateAnswer;
    }else {
        self.model.answerState = JingGeAnswerStateUnAnswer;
    }
    if (self.model.answerOption.count <= 0) {
        return;
    }
    if (self.model.qType == JingGeQuestionTypeSingle) {
        [self nextQuestion];
    }
}

#pragma mark buttonActionFooterViewDelegate
- (void)buttonActionFooterView:(JingGeAnswerTableViewButtonFooterView *)view {
    [self nextQuestion];
}

#pragma mark
- (void)nextQuestion {
    if ([self.choiseTableViewDelegate respondsToSelector:@selector(toNextQuestionTableView:)]) {
        
        [self.choiseTableViewDelegate toNextQuestionTableView:self];
    }
}

#pragma mark 赋值
- (void)setModel:(JingGeQuestionModel *)model {
    _model = model;
    self.helper.choiseArray = [self.model.answerOption mutableCopy];
    if (self.parsingType == JingGeParsingTypeSuccess) {
        self.footerView.model = self.model;
        [self.footerView updateLayout];
        JingGeAnswerTableViewAnalysisFooterView * footer = [[JingGeAnswerTableViewAnalysisFooterView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _footerView.frame.size.height)];
        footer.config = self.config;
        footer.model = model;
        //footer.backgroundColor = [UIColor blueColor];
        self.tableFooterView = footer;
        //self.tableFooterView = self.footerView;
        
    }else {
        if (model.qType == JingGeQuestionTypeMultiple) {
            
            self.tableFooterView = self.btnFooterView;
        }else {
            self.tableFooterView = [UIView new];
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
