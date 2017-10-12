//
//  JingGeAnswerSheetCollectionViewCell.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"
@class JingGeQuestionModel;
@interface JingGeAnswerSheetCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) JingGeQuestionModel *model;

@property (assign, nonatomic) JingGeParsingType parsingType;

@property (strong, nonatomic) JingGeAnswerConfig *config;

@end
