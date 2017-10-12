//
//  JingGeNavigationBar.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JingGeNavigationBar : UIView

@property (strong, nonatomic) UIButton *backItem;

@property (strong, nonatomic) UIButton *rightItem;

@property (strong, nonatomic) NSArray *rightItems;

@property (strong, nonatomic) UIButton *leftItem;

@property (strong, nonatomic) NSArray *leftItems;

@property (strong, nonatomic) UIView *titleItem;

@end
