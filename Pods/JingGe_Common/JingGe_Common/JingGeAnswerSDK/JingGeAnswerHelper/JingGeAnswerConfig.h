//
//  JingGeAnswerConfig.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/4.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kColor UIColorFromHex(0xf2ba00)

typedef NS_ENUM(NSInteger,JingGeQuestionType){
    JingGeQuestionTypeSingle = 1,             //单选
    JingGeQuestionTypeMultiple,               //多选
    JingGeQuestionTypeJudge,                  //判断
    JingGeQuestionTypeSingleBlank,            //单填空
    JingGeQuestionTypeMultipleBlank           //多项填空
};
typedef NS_ENUM(NSInteger,JingGeParsingType){
    JingGeParsingTypeNone = 0,                 //未解析
    JingGeParsingTypeSuccess,                  //解析完成
};
typedef NS_ENUM(NSInteger,JingGeAnswerState){
    JingGeAnswerStateUnAnswer = 0,             //未做答
    JingGeAnswerStateAnswer,                   //已作答
};

typedef NS_ENUM(NSInteger,JingGeAnswerResult){
    JingGeAnswerResultFault =  0,              //回答错误
    JingGeAnswerResultTrue                     //回答正确
};


@interface JingGeAnswerConfig : NSObject

@property (strong, nonatomic) UIColor *jingGeAnswerMainColor;           //主色调
@property (strong, nonatomic) UIColor *jingGeQuestionTextColor;         //问题字体颜色
@property (strong, nonatomic) UIColor *jingGeOptionTextColor;           //选项字体颜色
@property (strong, nonatomic) UIColor *jingGeAnswerFaultColor;          //回答错误颜色
@property (strong, nonatomic) UIColor *jingGeAnswerTruetColor;          //回答正确颜色
@property (strong, nonatomic) UIColor *jingGeAnswerBtnTextColor;        //按钮字体颜色
@property (strong, nonatomic) UIColor *jingGeAnswerSheetTextColor;      //题卡字体颜色
@property (strong, nonatomic) UIColor *jingGeParsingOptionBtnColor;     //解析完成选项按钮颜色
@property (strong, nonatomic) UIColor *jingGeAnswerLineColor;           //横线颜色
@property (strong, nonatomic) UIImage *jingGeAnswerPlaceHolderImage;    //占位图片
@property (strong, nonatomic) UIImage *jingGeAnswerSubmitImage;         //提交图片
@property (strong, nonatomic) UIFont *jingGeQuestionTextFont;           //问题字号
@property (strong, nonatomic) UIFont *jingGeOptionTextFont;             //选项字号
@property (strong, nonatomic) UIFont *jingGeAnswerBtnTextFont;          //按钮字号
@property (strong, nonatomic) UIFont *jingGeParsingTitleFont;           //解析title字号
@property (strong, nonatomic) UIFont *jingGeParsingDetailFont;          //解析详情字号
@property (strong, nonatomic) UIFont *jingGeAnswerNaviTitleFont;        //导航栏字号
@property (strong, nonatomic) UIColor *jingGeAnswerNaviTitleColor;      //导航栏字体颜色


@end
