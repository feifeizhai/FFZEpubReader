//
//  JingGeNavigationBar.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeNavigationBar.h"
#import "JingGeMacro.h"


@implementation JingGeNavigationBar

- (void)setBackItem:(UIButton *)backItem {
    _backItem = [self barItem];
   // [_backItem addTarget:[backItem.allTargets valueForKey:<#(nonnull NSString *)#>] action: forControlEvents:<#(UIControlEvents)#>]
    [_backItem mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-8);
        make.left.mas_equalTo(kDefaultSpace * 2);
        
        
    }];
    [backItem sizeToFit];
    [_backItem addSubview:backItem];
    [backItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
}

- (void)setLeftItem:(UIButton *)leftItem {
    _leftItem = leftItem;
    [_leftItem sizeToFit];
    [self addSubview:leftItem];
    if (!_leftItem) {
        [_leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(22);
            make.left.mas_equalTo(kDefaultSpace * 2);
            //make.size.mas_equalTo (CGSizeMake(kNavigationBar_HEIGHT, kNavigationBar_HEIGHT));
        }];
    }else{
        [_leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(22);
            make.left.mas_equalTo(_backItem.mas_right).offset(kDefaultSpace * 2);
            //make.size.mas_equalTo (CGSizeMake(kNavigationBar_HEIGHT, kNavigationBar_HEIGHT));
        }];
    }
}

- (void)setRightItem:(UIView *)rightItem {
    _rightItem = rightItem;
    [_rightItem sizeToFit];
    [self addSubview:rightItem];
    [_rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22);
        make.right.mas_equalTo(-kDefaultSpace * 2);
        make.size.mas_equalTo (CGSizeMake(kNavigationBar_HEIGHT, kNavigationBar_HEIGHT));
    }];
}

- (void)setLeftItems:(NSArray *)leftItems {
    
}

- (void)setRightItems:(NSArray *)rightItems {
    
}

- (void)setTitleItem:(UIView *)titleItem {
    _titleItem = titleItem;
    [self addSubview:titleItem];
    _titleItem.backgroundColor = kRandColor;
    [_titleItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-8);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth / 2, kNavigationBar_HEIGHT));
        make.left.mas_equalTo(kNavigationBar_HEIGHT * 2);
        make.right.mas_equalTo(-kNavigationBar_HEIGHT * 2);
    }];
}

- (UIButton *)barItem {
    UIButton *barItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [barItem sizeToFit];
    [self addSubview:barItem];
    [barItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(10);
        make.width.mas_greaterThanOrEqualTo (kNavigationBar_HEIGHT);
        //make.height.mas_greaterThanOrEqualTo(33);
    }];
    
    return barItem;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
