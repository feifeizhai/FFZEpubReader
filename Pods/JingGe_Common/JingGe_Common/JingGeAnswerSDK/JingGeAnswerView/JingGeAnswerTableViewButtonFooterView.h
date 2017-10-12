//
//  JingGeAnswerButtonFooterView.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"

@class JingGeAnswerTableViewButtonFooterView;

@protocol JingGeAnswerTableViewButtonFooterViewDelegate <NSObject>

- (void)buttonActionFooterView:(JingGeAnswerTableViewButtonFooterView *)view;

@end

@interface JingGeAnswerTableViewButtonFooterView : UIView

@property (assign, nonatomic) id<JingGeAnswerTableViewButtonFooterViewDelegate> delegate;

@property (strong, nonatomic) JingGeAnswerConfig *config;

@end
