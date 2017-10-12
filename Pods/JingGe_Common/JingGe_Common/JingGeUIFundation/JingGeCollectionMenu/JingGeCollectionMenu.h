//
//  JingGeCollectionMenu.h
//  JGCloudProject
//
//  Created by 景格_徐薛波 on 2017/5/4.
//  Copyright © 2017年 jg_lxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeMenuLayout.h"
#import "JingGeMenuItem.h"
typedef void(^selectAtIndex)(NSIndexPath *indexPath, UIView *sender);
typedef void(^creatAtIndex)(NSIndexPath *indexPath, UIView *sender);
@interface JingGeCollectionMenu : UIView

- (id)initWithCount:(NSInteger)count selectAtIndex:(selectAtIndex)index;
- (id)initWithFrame:(CGRect)frame count:(NSInteger)count selectAtIndex:(selectAtIndex)index;

- (id)initWithFrame:(CGRect)frame count:(NSInteger)count creatAtIndex:(creatAtIndex)creatAtIndex selectAtIndex:(selectAtIndex)index;
- (void)setDataSource:(NSArray *)titlesArray images:(NSArray *)images subTitlesArray:(NSArray *)subTitlsArray;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic) UIEdgeInsets sectionInset;
@property (assign, nonatomic) CGSize itemSize;
@property (strong, nonatomic) JingGeMenuLayout *layout;
@property (assign, nonatomic) JingGeMenuItemType jingGeMenuIteType;
@property (strong, nonatomic) UIColor *itemTitleColor;
@property (strong, nonatomic) UIColor *itemDetailTitleColor;
@property (strong, nonatomic) UIFont *itemDetailFont;
@property (strong, nonatomic) UIFont *itemTitleFont;

@property (assign, nonatomic) CGFloat imageCorner;

@end
