//
//  JingGeAnswerTableViewAnalysisHeaderView.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"
@class JingGeQuestionModel;
@interface JingGeAnswerTableViewAnalysisFooterView : UIView

@property (strong, nonatomic) JingGeQuestionModel *model;

@property (strong, nonatomic) JingGeAnswerConfig *config;

- (void)updateLayout;

@end
