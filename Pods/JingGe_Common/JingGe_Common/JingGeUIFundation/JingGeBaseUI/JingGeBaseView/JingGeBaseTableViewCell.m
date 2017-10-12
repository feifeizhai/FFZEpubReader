//
//  JingGeBaseTableViewCell.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/16.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeBaseTableViewCell.h"
#import "JingGeMacro.h"
@interface JingGeBaseTableViewCell ()

//@property (nonatomic) CELL_CUSTOM_TYPE cellCustomType;

@end

@implementation JingGeBaseTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.footButtonIsShow = YES;
    }
    return self;
}


- (void)subViewsLayout
{
    kWeakSelf(ws);
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kDefaultSpace);
        make.centerY.mas_equalTo(ws.contentView);
    }];
    [self.footBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kDefaultSpace);
        make.centerY.mas_equalTo(ws.iconImageView);
        if (ws.footButtonIsShow) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }else{
            make.size.mas_equalTo(CGSizeMake(0, 40));
        }
        
    }];
    
    [self.valueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ws.footBtn.mas_left).offset(-kDefaultSpace);
        make.centerY.mas_equalTo(ws.iconImageView);
    }];
    
    
    
    if (self.cellCustomType == CELL_CUSTOM_TYPE_Default) {
        
        
        [self.mainLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(kDefaultSpace * 2);
            make.left.mas_equalTo(ws.iconImageView.mas_right).offset(kDefaultSpace);
            make.centerY.mas_equalTo(ws.iconImageView);
            make.right.mas_lessThanOrEqualTo(ws.valueLable.mas_left).offset(-kDefaultSpace);
            make.bottom.mas_lessThanOrEqualTo(-kDefaultSpace * 2);
        }];
    }else if (self.cellCustomType == CELL_CUSTOM_TYPE_SUBTITLE){
        [self.mainLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(2 * kDefaultSpace);
            make.left.mas_equalTo(ws.iconImageView.mas_right).offset(kDefaultSpace);
            make.top.mas_equalTo(ws.iconImageView);
            make.right.mas_lessThanOrEqualTo(ws.valueLable.mas_left).offset(-kDefaultSpace);
            make.bottom.mas_lessThanOrEqualTo(-kDefaultSpace * 2);
        }];
        
        [self.subLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.mainLable);
            make.bottom.mas_equalTo(ws.iconImageView);
        }];
        
    }
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        self.iconImageView = [UIImageView new];
        // [_iconImageView sizeToFit];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)mainLable
{
    if (!_mainLable) {
        self.mainLable = [UILabel new];
        [_mainLable sizeToFit];
        //_mainLable.numberOfLines = 0;
        self.mainLable.preferredMaxLayoutWidth = kScreenWidth * 3 / 5;
        _mainLable.font = UISYSTEM_FONT(kCellMainTitleFontSize);
        _mainLable.backgroundColor = kRandColor;
        _mainLable.textColor = kCellMainTitleTextColor;
        
        [self.contentView addSubview:_mainLable];
    }
    return _mainLable;
}

- (UILabel *)subLable
{
    if (!_subLable) {
        self.subLable = [UILabel new];
        [_subLable sizeToFit];
        _subLable.font = UISYSTEM_FONT(kCellSubTitleFontSize);
        _subLable.backgroundColor = kRandColor;
        _subLable.textColor = kCellSubTitleTextColor;
        [self.contentView addSubview:_subLable];
    }
    return _subLable;
}

- (UILabel *)valueLable
{
    if (!_valueLable) {
        self.valueLable = [UILabel new];
        [_valueLable sizeToFit];
        
        _valueLable.font = UISYSTEM_FONT(kCellValueTitleFontSize);
        _valueLable.backgroundColor = kRandColor;
        _valueLable.textColor = kCellValueTitleTextColor;
        [self.contentView addSubview:_valueLable];
    }
    return _valueLable;
}

- (UIButton *)footBtn
{
    if (!_footBtn) {
        self.footBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        _footBtn.backgroundColor = kRandColor;
        [self.contentView addSubview:_footBtn];
    }
    return _footBtn;
}

- (void)setCellCustomType:(CELL_CUSTOM_TYPE)cellCustomType
{
    _cellCustomType = cellCustomType;
    [self subViewsLayout];
}

- (void)setFootButtonIsShow:(BOOL)footButtonIsShow
{
    _footButtonIsShow = footButtonIsShow;
    kWeakSelf(ws);
    [self.footBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kDefaultSpace);
        make.centerY.mas_equalTo(ws.iconImageView);
        if (ws.footButtonIsShow) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }else{
            make.size.mas_equalTo(CGSizeMake(0, 40));
        }
        
    }];
}
/*
 - (void)drawRect:(CGRect)rect {
 
 CGContextRef context =UIGraphicsGetCurrentContext();
 CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
 CGContextFillRect(context, rect);
 
 //下分割线
 CGContextSetStrokeColorWithColor(context,kCellLineColor.CGColor);
 CGContextStrokeRect(context,CGRectMake(0, rect.size.height-0.5, rect.size.width,1));
 
 }
 */

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
