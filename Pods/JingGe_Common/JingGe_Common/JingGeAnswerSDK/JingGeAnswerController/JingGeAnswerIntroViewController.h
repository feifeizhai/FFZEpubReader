//
//  JingGeAnswerIntroViewController.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeBaseViewController.h"
@class JingGeAnswerConfig, JingGeAnswerModel, JingGeAnswerIntroViewController;

@protocol JingGeAnswerIntroViewControllerDelegate <NSObject>

@optional

- (void)answerButtonActionInController:(JingGeAnswerIntroViewController *)controller;

- (void)toViewParsingWithController:(JingGeAnswerIntroViewController *)controller;

@end

typedef void(^jingGeAnswerConfigBlock)(JingGeAnswerConfig *answerConfig);
typedef void(^buttonActionBlock)(JingGeAnswerModel *model);
@interface JingGeAnswerIntroViewController : JingGeBaseViewController
@property (strong, nonatomic) JingGeAnswerModel *model;
@property (assign, nonatomic) id<JingGeAnswerIntroViewControllerDelegate> delegate;

@end
