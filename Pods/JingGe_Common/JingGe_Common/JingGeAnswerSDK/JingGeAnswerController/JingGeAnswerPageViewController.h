//
//  JingGeAnswerPageViewController.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"
@class JingGeQuestionModel, JingGeAnswerPageViewController;

@protocol JingGeAnswerPageViewControllerDelegate <NSObject>

@optional

- (void)toNextQuestionTableView:(JingGeAnswerPageViewController *)tableView;

@end

@interface JingGeAnswerPageViewController : UIViewController

@property (strong, nonatomic) JingGeQuestionModel *model;
@property (assign, nonatomic) JingGeParsingType parsingType;//解析状态
@property (strong, nonatomic) JingGeAnswerConfig *config;
@property (assign, nonatomic) id<JingGeAnswerPageViewControllerDelegate> delegate;

@end
