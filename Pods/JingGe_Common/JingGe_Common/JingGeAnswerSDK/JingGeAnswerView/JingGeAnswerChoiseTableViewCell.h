//
//  JingGeAnswerChoiseTableViewCell.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"
@class JingGeOptionModel;
@interface JingGeAnswerChoiseTableViewCell : UITableViewCell

@property (strong, nonatomic) JingGeOptionModel *model;

@property (assign, nonatomic) BOOL isSelected;

@property (assign, nonatomic) JingGeAnswerState answerState;

@property (strong, nonatomic) NSString *optionLetter;

@property (assign, nonatomic) JingGeParsingType parsingType;

@property (strong, nonatomic) JingGeAnswerConfig *config;

@end
