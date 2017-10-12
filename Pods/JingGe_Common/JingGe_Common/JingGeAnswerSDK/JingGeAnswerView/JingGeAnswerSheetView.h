//
//  JingGeAnswerSheetView.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerModel.h"
@class JingGeAnswerSheetView;

@protocol JingGeAnswerSheetViewDelegate <NSObject>

@optional

- (void)showSheetView:(JingGeAnswerSheetView *)answerSheet;

- (void)hidSheetView:(JingGeAnswerSheetView *)answerSheet;

- (void)answerSheetView:(JingGeAnswerSheetView *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)submitButtonActionSheetView:(JingGeAnswerSheetView *)answerSheet;

@end

@interface JingGeAnswerSheetView : UIView

@property (strong, nonatomic) JingGeAnswerModel *model;

@property (strong, nonatomic) NSString *pageNum;

@property (strong, nonatomic) JingGeAnswerConfig *config;

- (void)showSheetViewWithView:(UIView *)view;

- (void)hidSheetViewWithView:(UIView *)view;

@property (assign, nonatomic) id<JingGeAnswerSheetViewDelegate> delegate;

@end
