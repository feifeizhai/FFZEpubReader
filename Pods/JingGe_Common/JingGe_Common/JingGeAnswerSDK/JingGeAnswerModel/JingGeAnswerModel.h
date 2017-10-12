//
//  JingGeAnswerModel.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/4.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JingGeAnswerConfig.h"
#import "JingGeBaseModel.h"
@interface JingGeAnswerModel : JingGeBaseModel
@property (strong, nonatomic) NSString *parentId;          //上一级ID
@property (strong, nonatomic) NSString *exerciseId;        //练习ID
@property (strong, nonatomic) NSString *exerciseTitle;     //练习名称
@property (strong, nonatomic) NSString *exerciseIntro;     //练习说明
@property (strong, nonatomic) NSString *totalScore;        //总分
@property (strong, nonatomic) NSMutableArray *questionList;//题目列表


@property (strong, nonatomic) NSMutableArray *answerTrueList;//正确列表
@property (strong, nonatomic) NSMutableArray *answerFaultList;//错误列表
@property (strong, nonatomic) NSMutableArray *answerList;     //回答列表
@property (strong, nonatomic) NSMutableArray *unAnswerList;//未回答列表
@property (assign, nonatomic) JingGeParsingType parsingType;//解析状态
@property (strong, nonatomic) NSString *score;             //得分
@property (strong, nonatomic) NSString *submitTime;        //提交时间
@end
