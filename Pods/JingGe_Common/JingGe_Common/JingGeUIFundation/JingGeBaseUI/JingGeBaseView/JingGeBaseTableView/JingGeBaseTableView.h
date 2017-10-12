//
//  JingGeBaseTableView.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JingGeTableViewDataSource <NSObject>
@required
- (NSInteger)b_tableView:(UITableView *_Nullable)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *_Nullable)b_TableView:(UITableView *_Nullable)tableView cellForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
@optional
- (NSInteger)b_numberOfSectionsInTableView:(UITableView *_Nullable)tableView;
- (nullable NSString *)b_tableView:(UITableView *_Nullable)tableView titleForHeaderInSection:(NSInteger)section;   - (nullable NSString *)b_tableView:(UITableView *_Nullable)tableView titleForFooterInSection:(NSInteger)section;
- (BOOL)b_tableView:(UITableView *_Nullable)tableView canEditRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (BOOL)b_tableView:(UITableView *_Nullable)tableView canMoveRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (nullable NSArray<NSString *> *)b_sectionIndexTitlesForTableView:(UITableView *_Nullable)tableView;
- (NSInteger)b_tableView:(UITableView *_Nullable)tableView sectionForSectionIndexTitle:(NSString *_Nullable)title atIndex:(NSInteger)index;
- (void)b_tableView:(UITableView *_Nullable)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (void)b_tableView:(UITableView *_Nullable)tableView moveRowAtIndexPath:(NSIndexPath *_Nullable)sourceIndexPath toIndexPath:(NSIndexPath *_Nullable)destinationIndexPath;
@end

@protocol JingGeTableViewDelegate <NSObject>
@optional
//cell将要显示时调用的方法
- (void)b_tableView:(UITableView *_Nullable)tableView willDisplayCell:(UITableViewCell *_Nullable)cell forRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
//头视图将要显示时调用的方法
- (void)b_tableView:(UITableView *_Nullable)tableView willDisplayHeaderView:(UIView *_Nullable)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//尾视图将要显示时调用的方法
- (void)b_tableView:(UITableView *_Nullable)tableView willDisplayFooterView:(UIView *_Nullable)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//和上面的方法对应，这三个方法分别是cell，头视图，尾视图已经显示时调用的方法
- (void)b_tableView:(UITableView *_Nullable)tableView didEndDisplayingCell:(UITableViewCell *_Nullable)cell forRowAtIndexPath:(NSIndexPath*_Nullable)indexPath NS_AVAILABLE_IOS(6_0);
- (void)b_tableView:(UITableView *_Nullable)tableView didEndDisplayingHeaderView:(UIView *_Nullable)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
- (void)b_tableView:(UITableView *_Nullable)tableView didEndDisplayingFooterView:(UIView *_Nullable)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//设置行高，头视图高度和尾视图高度的方法
- (CGFloat)b_tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (CGFloat)b_tableView:(UITableView *_Nullable)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)b_tableView:(UITableView *_Nullable)tableView heightForFooterInSection:(NSInteger)section;
//设置行高，头视图高度和尾视图高度的估计值(对于高度可变的情况下，提高效率)
- (CGFloat)b_tableView:(UITableView *_Nullable)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(7_0);
- (CGFloat)b_tableView:(UITableView *_Nullable)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
- (CGFloat)b_tableView:(UITableView *_Nullable)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//设置自定义头视图和尾视图
- (nullable UIView *)b_tableView:(UITableView *_Nullable)tableView viewForHeaderInSection:(NSInteger)section;
- (nullable UIView *)b_tableView:(UITableView *_Nullable)tableView viewForFooterInSection:(NSInteger)section;

- (UITableViewCellAccessoryType)b_tableView:(UITableView *_Nullable)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *_Nullable)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
- (void)b_tableView:(UITableView *_Nullable)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *_Nullable)indexPath;
//设置cell是否可以高亮
- (BOOL)b_tableView:(UITableView *_Nullable)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(6_0);
//cell高亮和取消高亮时分别调用的函数
- (void)b_tableView:(UITableView *_Nullable)tableView didHighlightRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(6_0);
- (void)b_tableView:(UITableView *_Nullable)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(6_0);
//当即将选中某行和取消选中某行时调用的函数，返回行所在分区，执行选中或者取消选中
- (nullable NSIndexPath *)b_tableView:(UITableView *_Nullable)tableView willSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (nullable NSIndexPath *)b_tableView:(UITableView *_Nullable)tableView willDeselectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(3_0);
//已经选中和已经取消选中后调用的函数
- (void)b_tableView:(UITableView *_Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (void)b_tableView:(UITableView *_Nullable)tableView didDeselectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(3_0);

//设置tableView被编辑时的状态风格，如果不设置，默认都是删除风格
- (UITableViewCellEditingStyle)b_tableView:(UITableView *_Nullable)tableView editingStyleForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
//自定义删除按钮的标题
- (nullable NSString *)b_tableView:(UITableView *_Nullable)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//下面这个方法是IOS8中的新方法，用于自定义创建tableView被编辑时右边的按钮，按钮类型为UITableViewRowAction。
- (nullable NSArray *)b_tableView:(UITableView *_Nullable)tableView editActionsForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;
//设置编辑时背景是否缩进
- (BOOL)b_tableView:(UITableView *_Nullable)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
//将要编辑和结束编辑时调用的方法
- (void)b_tableView:(UITableView*_Nullable)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *_Nullable)indexPath __TVOS_PROHIBITED;
- (void)b_tableView:(UITableView*_Nullable)tableView didEndEditingRowAtIndexPath:(NSIndexPath *_Nullable)indexPath __TVOS_PROHIBITED;
//移动特定的某行
- (NSIndexPath *_Nullable)b_tableView:(UITableView *_Nullable)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *_Nullable)sourceIndexPath toProposedIndexPath:(NSIndexPath *_Nullable)proposedDestinationIndexPath;
//行缩进
- (NSInteger)b_tableView:(UITableView *_Nullable)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;
//复制/粘贴
//通知委托是否在指定行显示菜单，返回值为YES时，长按显示菜单。
- (BOOL)b_tableView:(UITableView *_Nullable)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(5_0);
//弹出选择菜单时会调用此方法（复制、粘贴、全选、剪切）
- (BOOL)b_tableView:(UITableView *_Nullable)tableView canPerformAction:(SEL _Nullable )action forRowAtIndexPath:(NSIndexPath *_Nullable)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//选择菜单项完成之后调用此方法。
- (void)b_tableView:(UITableView *_Nullable)tableView performAction:(SEL _Nullable )action forRowAtIndexPath:(NSIndexPath *_Nullable)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//焦点
- (BOOL)b_tableView:(UITableView *_Nullable)tableView canFocusRowAtIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(9_0);
- (BOOL)b_tableView:(UITableView *_Nullable)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *_Nullable)context NS_AVAILABLE_IOS(9_0);
- (void)b_tableView:(UITableView *_Nullable)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *_Nullable)context withAnimationCoordinator:(UIFocusAnimationCoordinator *_Nullable)coordinator NS_AVAILABLE_IOS(9_0);
- (nullable NSIndexPath *)b_indexPathForPreferredFocusedViewInTableView:(UITableView *_Nullable)tableView NS_AVAILABLE_IOS(9_0);

@end


@interface JingGeBaseTableView : UIView

@property (strong, nonatomic) UITableView * _Nullable tableView;
@property (nonatomic, weak, nullable) id <JingGeTableViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <JingGeTableViewDelegate> delegate;
@property (strong, nonatomic) UIView * _Nullable refreshHeader;
@property (strong, nonatomic) UIView * _Nullable refreshFooter;

- (void)reloadData;

- (instancetype _Nullable )initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (void)reloadSectionIndexTitles NS_AVAILABLE_IOS(3_0);
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGRect)rectForSection:(NSInteger)section;                                    // includes header, footer and all rows
- (CGRect)rectForHeaderInSection:(NSInteger)section;
- (CGRect)rectForFooterInSection:(NSInteger)section;
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;

- (nullable NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;                         // returns nil if point is outside of any row in the table
- (nullable NSIndexPath *)indexPathForCell:(UITableViewCell *_Nullable)cell;                      // returns nil if cell is not visible
- (nullable NSArray<NSIndexPath *> *)indexPathsForRowsInRect:(CGRect)rect;                              // returns nil if rect not valid

- (nullable __kindof UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;   // returns nil if cell is not visible or index path is out of range


- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
- (nullable UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);

- (void)scrollToRowAtIndexPath:(NSIndexPath *_Nullable)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

// Row insertion/deletion/reloading.
- (void)beginUpdates;   // allow multiple insert/delete of rows and sections to be animated simultaneously. Nestable
- (void)endUpdates;     // only call insert/delete/reload calls or change the editing state inside an update block.  otherwise things like row count, etc. may be invalid.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
- (void)insertSections:(NSIndexSet *_Nullable)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteSections:(NSIndexSet *_Nullable)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSections:(NSIndexSet *_Nullable)sections withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection NS_AVAILABLE_IOS(5_0);

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *_Nullable)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *_Nullable)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *_Nullable)indexPaths withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
- (void)moveRowAtIndexPath:(NSIndexPath *_Nullable)indexPath toIndexPath:(NSIndexPath *_Nullable)newIndexPath NS_AVAILABLE_IOS(5_0);


// Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath animated:(BOOL)animated;


- (nullable __kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *_Nullable)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
- (__kindof UITableViewCell *_Nullable)dequeueReusableCellWithIdentifier:(NSString *_Nullable)identifier forIndexPath:(NSIndexPath *_Nullable)indexPath NS_AVAILABLE_IOS(6_0); // newer dequeue method guarantees a cell is returned and resized properly, assuming identifier is registered
- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *_Nullable)identifier NS_AVAILABLE_IOS(6_0);  // like dequeueReusableCellWithIdentifier:, but for headers/footers

// Beginning in iOS 6, clients can register a nib or class for each cell.
// If all reuse identifiers are registered, use the newer -dequeueReusableCellWithIdentifier:forIndexPath: to guarantee that a cell instance is returned.
// Instances returned from the new dequeue method will also be properly sized when they are returned.
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *_Nullable)identifier NS_AVAILABLE_IOS(5_0);
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *_Nullable)identifier NS_AVAILABLE_IOS(6_0);

- (void)registerNib:(nullable UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *_Nullable)identifier NS_AVAILABLE_IOS(6_0);
- (void)registerClass:(nullable Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *_Nullable)identifier NS_AVAILABLE_IOS(6_0);

// Focus




@end

