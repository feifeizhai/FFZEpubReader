//
//  JingGeQuestionModel.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/7.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JingGeAnswerConfig.h"
#import "JingGeBaseModel.h"
@interface JingGeQuestionModel : JingGeBaseModel

@property (strong, nonatomic) NSString *quesTypeImage;
@property (strong, nonatomic) NSString *quesId;             //题目Id
@property (strong, nonatomic) NSString *quesNum;            //题目编号
@property (strong, nonatomic) NSString *quesTitle;          //题目名称
@property (strong, nonatomic) NSString *quesType;           //题目类型 // 1:单选 2:多选, 3:判断, 4:单项填空, 5:多项填空
@property (assign, nonatomic) JingGeQuestionType qType;
@property (strong, nonatomic) NSString *score;              //题目分数

@property (strong, nonatomic) NSString *imageUrls;          //暂时不用
@property (strong, nonatomic) NSString *explain;            //答案解析
@property (strong, nonatomic) NSString *order;              //排序
@property (strong, nonatomic) NSMutableArray *imageUrlLists;//缩略图片
@property (strong, nonatomic) NSMutableArray *viewImageLists;//原图图片
@property (strong, nonatomic) NSMutableArray *quesOption;  //选项
@property (strong, nonatomic) NSMutableArray *tureOption;  //正确选项

@property (strong, nonatomic) NSMutableArray *answerOption;//作答选项

@property (assign, nonatomic) JingGeAnswerState answerState;
@property (assign, nonatomic) JingGeAnswerResult answerResult;
@property (strong, nonatomic) NSString *userScore;          //用户本题得分
@property (assign, nonatomic) BOOL getScore;                //作对得分

@end
