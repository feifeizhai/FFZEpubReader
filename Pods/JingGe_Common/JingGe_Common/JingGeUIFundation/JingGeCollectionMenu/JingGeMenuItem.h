//
//  JingGeMenuItem.h
//  JGCloudProject
//
//  Created by 景格_徐薛波 on 2017/5/4.
//  Copyright © 2017年 jg_lxh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JingGeMenuItemTypeVertical = 0,//竖直排布
    
    JingGeMenuItemTypeHorizontal,//水平排布
    
    JingGeMenuItemTypeVerticalSubtitle,//竖直有子标题
    
    JingGeMenuItemTypeDefault = JingGeMenuItemTypeVertical,
} JingGeMenuItemType;

@interface JingGeMenuItem : UICollectionViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UIImageView *imageView;

@property (assign, nonatomic) JingGeMenuItemType jingGeMenuItemType;

@end
