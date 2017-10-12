//
//  JingGeAnswerHelper.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/4.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerHelper.h"

#import "JingGeAnswerModel.h"

#import "JingGeQuestionModel.h"

#import "JingGeOptionModel.h"

@implementation JingGeAnswerHelper

- (NSMutableArray *)choiseArray {
    if (!_choiseArray) {
        _choiseArray = [NSMutableArray array];
    }
    return _choiseArray;
}


- (NSArray *)choise:(id)object type:(JingGeQuestionType)type{
    if ([self.choiseArray containsObject:object]) {
        [self.choiseArray removeObject:object];
    }else {
        if (type == JingGeQuestionTypeMultiple) {
            [self.choiseArray addObject:object];
        }else {
            if (self.choiseArray.count <= 0) {
                [self.choiseArray addObject:object];
            }else {
                [self.choiseArray replaceObjectAtIndex:0 withObject:object];
            }
            
        }
    }
    return [NSArray arrayWithArray:self.choiseArray];
}

+ (BOOL)hasTrueAnswer:(JingGeQuestionModel *)model {
    if (model.answerOption.count != model.tureOption.count) {
        model.getScore = NO;
        return NO;
    }else {
        for (JingGeOptionModel *optionModel in model.answerOption) {
            if (![model.tureOption containsObject:optionModel]) {
                model.getScore = NO;
                return NO;
            }
        }
        model.getScore = YES;
        return YES;
    }
}

+ (NSInteger)getScore:(JingGeAnswerModel *)model {
    NSInteger score = 0;
    
    model.answerList = nil;
    model.unAnswerList = nil;
    model.answerFaultList = nil;
    model.answerTrueList = nil;
    for (JingGeQuestionModel *questionModel in model.questionList) {
        
        if (questionModel.answerState == JingGeAnswerStateUnAnswer) {
            [model.unAnswerList addObject:questionModel];
        }else {
            [model.answerList addObject:questionModel];
        }
        
        if (questionModel.answerResult == JingGeAnswerResultFault) {
            if (questionModel.answerState == JingGeAnswerStateAnswer) {
                [model.answerFaultList addObject:questionModel];
            }
            
        }else {
            if (questionModel.answerState == JingGeAnswerStateAnswer) {
                [model.answerTrueList addObject:questionModel];
            }
        }
        
        if (questionModel.getScore) {
            questionModel.userScore = questionModel.score;
            score += [questionModel.score integerValue];
        }else {
            questionModel.userScore = questionModel.score;
        }
    }
    return score;
}


@end
