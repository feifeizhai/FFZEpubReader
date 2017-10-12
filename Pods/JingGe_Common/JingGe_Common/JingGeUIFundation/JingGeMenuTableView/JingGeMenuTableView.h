//
//  JingGeMenuTableView.h
//  JGCloudProject
//
//  Created by 景格_徐薛波 on 2017/5/4.
//  Copyright © 2017年 jg_lxh. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol JingGeMenuTableViewDelegate,JingGeMenuTableViewDatasource;

typedef UITableViewCell JingGeMenuTableViewCell;

typedef UITableViewRowAnimation JingGeMenuTableViewRowAnimation;

typedef NS_ENUM(NSInteger, JingGeMenuTableViewCellEditingStyle) {
    JingGeMenuTableViewCellEditingStyleNone,
    JingGeMenuTableViewCellEditingStyleDelete,
    JingGeMenuTableViewCellEditingStyleInsert
};

@interface JingGeMenuTableView : UIView <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, assign, readwrite) id<JingGeMenuTableViewDatasource> datasource;

@property (nonatomic, assign, readwrite) id<JingGeMenuTableViewDelegate> delegate;


/**
 若为YES，则点开一行，其他行关闭,默认为YES
 */
@property (nonatomic, assign, readwrite) BOOL autoAdjustOpenAndClose;

/**
 预先打开的行数组
 */
@property (nonatomic, copy, readwrite) NSArray *openSectionArray;

@property (nonatomic, strong, readwrite) UIView *tableViewHeader;

- (instancetype)initWithStyle:(UITableViewStyle)style;

/**
 *  Cell重用机制（一）
 *
 *  @param identifier Cell标识
 *
 *  @return Cell
 */
- (JingGeMenuTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

/**
 *  Cell重用机制（二）
 *
 *  @param identifier Cell标识
 
 *
 *  @return Cell
 */
- (JingGeMenuTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                                  forIndexPath:(NSIndexPath *)indexPath;
/**
 *  刷新数据源
 */
- (void)reloadData;

/**
 *  注册cell（一）
 *
 
 */
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier ;

/**
 *  注册cell（二）
 *
 
 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

/**
 *  删除cell
 *
 
 */
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;


/**
 自动预先展开一个section
 
 */
- (void)autoOpenWithSection:(NSInteger)section;

@end

/**
 *  数据源
 */
@protocol JingGeMenuTableViewDatasource <NSObject>

@required

/**
 *  每个section的行数
 *
 
 *
 *  @return 每个section的行数
 */
- (NSInteger)mTableView:(JingGeMenuTableView *)mTableView numberOfRowsInSection:(NSInteger)section;

/**
 *  Cell显示
 *
 
 *
 *  @return Cell
 */
- (JingGeMenuTableViewCell *)mTableView:(JingGeMenuTableView *)mTableView
                  cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  section的数量
 *
 
 */
- (NSInteger)numberOfSectionsInTableView:(JingGeMenuTableView *)mTableView;              // Default is 1

/**
 *  头部的title
 *
 
 */
-(NSString *)mTableView:(JingGeMenuTableView *)mTableView titleForHeaderInSection:(NSInteger)section;

//Edit

/**
 *  cell是否可以编辑
 *
 
 */
- (BOOL)mTableView:(JingGeMenuTableView *)mTableView canEditRowAtIndexPath:(NSIndexPath  *)indexPath;

/**
 *  cell编辑后回调
 *
 
 */
- (void)mTableView:(JingGeMenuTableView *)tableView commitEditingStyle:(JingGeMenuTableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 *  代理
 */
@protocol JingGeMenuTableViewDelegate <NSObject>

@optional
/**
 *  每个Cell的高度
 *
 *
 *  @return 每个Cell的高度
 */
//- (CGFloat)mTableView:(JingGeMenuTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  每个section的高度
 *
 *
 *  @return 每个section的高度
 */
- (CGFloat)mTableView:(JingGeMenuTableView *)mTableView heightForHeaderInSection:(NSInteger)section;

/**
 *  每个section的高度
 *
 *
 *  @return 每个section的高度
 */
- (CGFloat)mTableView:(JingGeMenuTableView *)mTableView heightForFooterInSection:(NSInteger)section;

/**
 *  section View
 *
 *  @return section View
 */
- (UIView *)mTableView:(JingGeMenuTableView *)mTableView viewForHeaderInSection:(NSInteger)section;

/**
 section View
 
 @param mTableView mTableView
 @param section section
 @return section footerView
 */
- (UIView *)mTableView:(JingGeMenuTableView *)mTableView viewForFooterInSection:(NSInteger)section;

/**
 *  即将打开指定列表回调
 *
 */
- (void)mTableView:(JingGeMenuTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section;

/**
 *
 *  即将关闭列表回调
 */
- (void)mTableView:(JingGeMenuTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section;


- (void)mTableView:(JingGeMenuTableView *)mTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;

/**
 *  点击Cell回调
 *
 */
- (void)mTableView:(JingGeMenuTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)mTableView:(JingGeMenuTableView *)mTableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)mTableView:(JingGeMenuTableView *)mTableView didSelectSectionAtSection:(UIView *)sectionView;
//Edit

/**
 *
 *  设置cell的编辑类型
 
 *
 */
- (JingGeMenuTableViewCellEditingStyle)mTableView:(JingGeMenuTableView *)mTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  设置cell编辑状态之删除的文本
 *
 
 */
- (NSString *)mTableView:(JingGeMenuTableView *)mTableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  ...易拓展出你想要的tableview的功能，写法可以参照上面的定义
 */



@end
