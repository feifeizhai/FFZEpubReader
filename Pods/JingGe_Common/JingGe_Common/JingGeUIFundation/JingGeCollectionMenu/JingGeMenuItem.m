//
//  JingGeMenuItem.m
//  JGCloudProject
//
//  Created by 景格_徐薛波 on 2017/5/4.
//  Copyright © 2017年 jg_lxh. All rights reserved.
//

#import "JingGeMenuItem.h"
#import "Masonry.h"
#import "JingGeMacro.h"
@interface JingGeMenuItem ()

@end

@implementation JingGeMenuItem



- (void)layoutSubviews
{
    [super layoutSubviews];
  
    
    
}

- (void)subviewsLayout
{
    if (self.jingGeMenuItemType == JingGeMenuItemTypeVertical) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        
    }else if (self.jingGeMenuItemType == JingGeMenuItemTypeHorizontal){
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).offset(kDefaultSpace);
            make.centerY.mas_equalTo(self.imageView);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }else if (self.jingGeMenuItemType == JingGeMenuItemTypeVerticalSubtitle){
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kDefaultSpace);
            make.centerX.mas_equalTo(self.contentView);
           
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(kDefaultSpace);
            make.centerX.mas_equalTo(self.contentView);
        }];
        
    }else{
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self.contentView);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        
    }
}

- (void)setJingGeMenuItemType:(JingGeMenuItemType)jingGeMenuItemType
{
    _jingGeMenuItemType = jingGeMenuItemType;
    [self subviewsLayout];
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        
        //_titleLabel.backgroundColor = [UIColor greenColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:9];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        self.detailLabel = [UILabel new];
        [self.contentView addSubview:_detailLabel];
        
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = [UIFont systemFontOfSize:8];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        self.imageView = [UIImageView new];
     
        [_imageView sizeToFit];
    
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}


@end
