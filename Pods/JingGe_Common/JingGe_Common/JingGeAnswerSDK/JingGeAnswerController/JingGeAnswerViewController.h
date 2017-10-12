//
//  JingGeAnswerViewController.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"

@class JingGeAnswerModel, JingGeAnswerViewController, JingGeAnswerConfig;

@protocol JingGeAnswerViewControllerDelegate <NSObject>
@optional
- (void)toViewParsing:(JingGeAnswerModel *)model;

@end

typedef void(^jingGeAnswerConfigBlock)(JingGeAnswerConfig *answerConfig);

@interface JingGeAnswerViewController : UIViewController

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) JingGeAnswerModel *model;

@property (assign, nonatomic) JingGeParsingType parsingType;

@property (assign, nonatomic) id<JingGeAnswerViewControllerDelegate> delegate;

@property (strong, nonatomic) JingGeAnswerConfig *answerConfig;

@end
