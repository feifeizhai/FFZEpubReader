//
//  JingGeResultHeaderView.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JingGeAnswerModel, JingGeAnswerConfig;

@interface ParsingHeaderViewTopView : UIView

@end

@interface ParsingHeaderViewMidView : UIView

@end

@interface ParsingHeaderViewBottomView : UIView

@end

@interface JingGeResultHeaderView : UICollectionReusableView

@property (strong, nonatomic) JingGeAnswerModel *model;

@property (strong, nonatomic) JingGeAnswerConfig *config;

@end
