//
//  JingGeAnswerHelper.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/4.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JingGeAnswerConfig.h"
@class JingGeQuestionModel, JingGeOptionModel, JingGeAnswerModel;
@interface JingGeAnswerHelper : NSObject
@property (strong, nonatomic) NSMutableArray *choiseArray;

- (NSArray *)choise:(id)object type:(JingGeQuestionType)type;

+ (BOOL)hasTrueAnswer:(JingGeQuestionModel *)model;
+ (NSInteger)getScore:(JingGeAnswerModel *)model;
@end
