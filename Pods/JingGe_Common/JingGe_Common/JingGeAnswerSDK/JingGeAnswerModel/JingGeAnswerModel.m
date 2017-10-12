//
//  JingGeAnswerModel.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/4.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerModel.h"

@implementation JingGeAnswerModel

- (NSMutableArray *)questionList {
    if (!_questionList) {
        _questionList = [NSMutableArray array];
    }
    return _questionList;
}

- (NSMutableArray *)answerList {
    if (!_answerList) {
        _answerList = [NSMutableArray array];
    }
    return _answerList;
}
- (NSMutableArray *)unAnswerList {
    if (!_unAnswerList) {
        _unAnswerList = [NSMutableArray array];
    }
    return _unAnswerList;
}
- (NSMutableArray *)answerTrueList {
    if (!_answerTrueList) {
        _answerTrueList = [NSMutableArray array];
    }
    return _answerTrueList;
}
- (NSMutableArray *)answerFaultList {
    if (!_answerFaultList) {
        _answerFaultList = [NSMutableArray array];
    }
    return _answerFaultList;
}

-(id)copyWithZone:(NSZone *)zone {
    
    JingGeAnswerModel *newClass = [[JingGeAnswerModel alloc]init];
    newClass.exerciseId = self.exerciseId;
    newClass.exerciseTitle = self.exerciseTitle;
    newClass.exerciseIntro = self.exerciseIntro;
    newClass.totalScore = self.totalScore;
    newClass.questionList = [self.questionList mutableCopy];
    newClass.parsingType = self.parsingType;
    return newClass;
}

@end
