//
//  JingGeAnswerChoiseTableView.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"
@class JingGeQuestionModel, JingGeAnswerChoiseTableView;

@protocol JingGeAnswerChoiseTableViewDelegate <NSObject>

@optional

- (void)toNextQuestionTableView:(JingGeAnswerChoiseTableView *)tableView;

@end

@interface JingGeAnswerChoiseTableView : UITableView

@property (strong, nonatomic) JingGeQuestionModel *model;

@property (assign, nonatomic) JingGeParsingType parsingType;//解析状态

@property (strong, nonatomic) JingGeAnswerConfig *config;

@property (assign, nonatomic) id<JingGeAnswerChoiseTableViewDelegate> choiseTableViewDelegate;

@end
