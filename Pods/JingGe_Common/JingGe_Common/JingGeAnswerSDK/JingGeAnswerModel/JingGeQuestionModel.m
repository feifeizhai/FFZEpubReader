//
//  JingGeQuestionModel.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/7.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeQuestionModel.h"

@implementation JingGeQuestionModel

- (JingGeQuestionType)qType {
    return [self.quesType integerValue];
}

- (NSMutableArray *)imageUrlLists {
    if (!_imageUrlLists) {
        _imageUrlLists = [NSMutableArray array];
    }
    return _imageUrlLists;
}

- (NSMutableArray *)viewImageLists {
    if (!_viewImageLists) {
        _viewImageLists = [NSMutableArray array];
    }
    return _viewImageLists;
}

- (NSMutableArray *)quesOption {
    if (!_quesOption) {
        _quesOption = [NSMutableArray array];
    }
    return _quesOption;
}

- (NSMutableArray *)tureOption {
    if (!_tureOption) {
        _tureOption = [NSMutableArray array];
    }
    return _tureOption;
}

- (NSMutableArray *)answerOption {
    if (!_answerOption) {
        _answerOption = [NSMutableArray array];
    }
    return _answerOption;
}

@end
