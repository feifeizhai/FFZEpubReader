//
//  JingGeAnswerSheetViewController.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"
@class JingGeAnswerModel, JingGeAnswerSheetViewController;

@protocol JingGeAnswerSheetViewControllerDelegate <NSObject>

- (void)answerSheetViewController:(JingGeAnswerSheetViewController *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)toViewParsing;
@end

@interface JingGeAnswerSheetViewController : UIViewController

@property (strong, nonatomic) JingGeAnswerModel *model;
@property (strong, nonatomic) JingGeAnswerConfig *config;
@property (assign, nonatomic) id<JingGeAnswerSheetViewControllerDelegate> delegate;

@end
