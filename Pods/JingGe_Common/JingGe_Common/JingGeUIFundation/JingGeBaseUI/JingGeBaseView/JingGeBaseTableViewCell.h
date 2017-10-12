//
//  JingGeBaseTableViewCell.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/16.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellMainTitleFontSize 15
#define kCellMainTitleTextColor UIColorFromHex(0x303030)

#define kCellSubTitleFontSize 12
#define kCellSubTitleTextColor UIColorFromHex(0xababab)

#define kCellValueTitleFontSize 12
#define kCellValueTitleTextColor UIColorFromHex(0xaeaeae)

#define kCellLineColor UIColorFromHex(0xe0e0e0)

typedef enum : NSUInteger {
    
    CELL_CUSTOM_TYPE_Default = 0,//
    
    CELL_CUSTOM_TYPE_SUBTITLE, //
    
} CELL_CUSTOM_TYPE;

@interface JingGeBaseTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *mainLable;
@property (strong, nonatomic) UILabel *subLable;
@property (strong, nonatomic) UILabel *valueLable;
@property (strong, nonatomic) UIButton *footBtn;
@property (nonatomic) BOOL footButtonIsShow; //是否显示button 默认YES
@property (nonatomic) CELL_CUSTOM_TYPE cellCustomType;
- (void)subViewsLayout;
@end
