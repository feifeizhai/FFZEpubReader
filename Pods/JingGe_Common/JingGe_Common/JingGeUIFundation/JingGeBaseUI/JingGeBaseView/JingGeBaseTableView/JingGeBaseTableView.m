//
//  JingGeBaseTableView.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/5/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeBaseTableView.h"
#import "MJRefresh.h"
#import "Masonry.h"

@interface JingGeBaseTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) UITableViewStyle style;

@end

@implementation JingGeBaseTableView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        [self addSubview:self.tableView];
        [self subviewsLayout];
    }
    return self;
}


- (void)subviewsLayout {
    /*
     [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.mas_equalTo(0);
     make.bottom.mas_equalTo(0);
     make.trailing.leading.mas_equalTo(0);
     }];
     */
    /*
     [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.mas_equalTo(0);
     make.bottom.mas_equalTo(0);
     make.trailing.leading.mas_equalTo(0);
     }];
     */
}
#pragma mark lazyloading

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        //_scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        [_scrollView sizeToFit];
        [_scrollView addSubview:self.tableView];
        //_scrollView.backgroundColor = [UIColor greenColor];
    }
    return _scrollView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:self.style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_tableView:numberOfRowsInSection:)]) {
        return [self.dataSource b_tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataSource && [self.dataSource b_TableView:tableView cellForRowAtIndexPath:indexPath]) {
        return [self.dataSource b_TableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_numberOfSectionsInTableView:)]) {
        return [self.dataSource b_numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.dataSource &&[self.dataSource respondsToSelector:@selector(b_tableView:titleForHeaderInSection:)]) {
        return [self.dataSource b_tableView:tableView titleForHeaderInSection:section];
    }
    return nil;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_tableView:titleForFooterInSection:)]) {
        return [self.dataSource b_tableView:tableView titleForFooterInSection:section];
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_tableView:canEditRowAtIndexPath:)]) {
        return [self.dataSource b_tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_tableView:canMoveRowAtIndexPath:)]) {
        return [self.dataSource b_tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return nil;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_sectionIndexTitlesForTableView:)]) {
        return [self.dataSource b_sectionIndexTitlesForTableView:tableView];
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.dataSource b_tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.dataSource b_tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(b_tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.dataSource b_tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark tableViewDelegate
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:willDisplayHeaderView:forSection:)]) {
        [self.delegate b_tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:willDisplayFooterView:forSection:)]) {
        [self.delegate b_tableView:tableView willDisplayFooterView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.delegate b_tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.delegate b_tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return self.tableView.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:heightForHeaderInSection:)]) {
        return [self.delegate b_tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:heightForFooterInSection:)]) {
        return [self.delegate b_tableView:tableView heightForFooterInSection:section];
    }
    return 0;
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:estimatedHeightForHeaderInSection:)]) {
        return [self.delegate b_tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(b_tableView:estimatedHeightForFooterInSection:)]) {
        return [self.delegate b_tableView:tableView estimatedHeightForFooterInSection:section];
    }
    return 0;
}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:viewForHeaderInSection:)]) {
        return [self.delegate b_tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}// custom view for header. will be adjusted to default or specified header height
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:viewForFooterInSection:)]) {
        return [self.delegate b_tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}// custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures).

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:accessoryTypeForRowWithIndexPath:)]) {
        return [self.delegate b_tableView:tableView accessoryTypeForRowWithIndexPath:indexPath];
    }
    return UITableViewCellAccessoryNone;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.delegate b_tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:shouldHighlightRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:didHighlightRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:didUnhighlightRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}
/*
 - (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if ([self.delegate respondsToSelector:@selector(b_tableView:willSelectRowAtIndexPath:)]) {
 return [self.delegate b_tableView:tableView willSelectRowAtIndexPath:indexPath];
 }
 return nil;
 }
 - (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
 {
 if ([self.delegate respondsToSelector:@selector(b_tableView:willDeselectRowAtIndexPath:)]) {
 return [self.delegate b_tableView:tableView willDeselectRowAtIndexPath:indexPath];
 }
 return nil;
 }
 */
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:didDeselectRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return nil;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:editActionsForRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:willBeginEditingRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:didEndEditingRowAtIndexPath:)]) {
        [self.delegate b_tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [self.delegate b_tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return nil;
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:indentationLevelForRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return 0;
}// return 'depth' of row for hierarchies

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [self.delegate b_tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [self.delegate b_tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:canFocusRowAtIndexPath:)]) {
        return [self.delegate b_tableView:tableView canFocusRowAtIndexPath:indexPath];
    }
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:shouldUpdateFocusInContext:)]) {
        return [self.delegate b_tableView:tableView shouldUpdateFocusInContext:context];
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0)
{
    if ([self.delegate respondsToSelector:@selector(b_tableView:didUpdateFocusInContext:withAnimationCoordinator:)]) {
        [self.delegate b_tableView:tableView didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    }
    
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0)
{
    if ([self.delegate respondsToSelector:@selector(b_indexPathForPreferredFocusedViewInTableView:)]) {
        return [self.delegate b_indexPathForPreferredFocusedViewInTableView:tableView];
    }
    return nil;
}

#pragma  mark methed
- (void)reloadSectionIndexTitles NS_AVAILABLE_IOS(3_0)
{
    [self.tableView reloadSectionIndexTitles];
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.tableView numberOfRowsInSection:section];
}

- (CGRect)rectForSection:(NSInteger)section
{
    return [self.tableView rectForSection:section];
}
- (CGRect)rectForHeaderInSection:(NSInteger)section
{
    return [self.tableView rectForHeaderInSection:section];
}
- (CGRect)rectForFooterInSection:(NSInteger)section
{
    return [self.tableView rectForFooterInSection:section];
}
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableView rectForRowAtIndexPath:indexPath];
}

- (nullable NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point
{
    return [self.tableView indexPathForRowAtPoint:point];
}

- (nullable NSIndexPath *)indexPathForCell:(UITableViewCell *)cell
{
    return [self.tableView indexPathForCell:cell];
}

- (nullable NSArray<NSIndexPath *> *)indexPathsForRowsInRect:(CGRect)rect
{
    return [self.tableView indexPathsForRowsInRect:rect];
}

- (nullable __kindof UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableView cellForRowAtIndexPath:indexPath];
}


- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    return [self.tableView headerViewForSection:section];
}
- (nullable UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    return [self.tableView footerViewForSection:section];
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}
- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    [self.tableView scrollToNearestSelectedRowAtScrollPosition:scrollPosition animated:animated];
}

- (void)beginUpdates
{
    [self.tableView beginUpdates];
}
- (void)endUpdates
{
    [self.tableView endUpdates];
}

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.tableView insertSections:sections withRowAnimation:animation];
}
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.tableView deleteSections:sections withRowAnimation:animation];
}
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0)
{
    [self.tableView reloadSections:sections withRowAnimation:animation];
}
- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection NS_AVAILABLE_IOS(5_0)
{
    [self.tableView moveSection:section toSection:newSection];
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0)
{
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}
- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath NS_AVAILABLE_IOS(5_0)
{
    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}


// Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    [self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
}
- (void)deselectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath animated:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
}


- (nullable __kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    return [self.tableView dequeueReusableCellWithIdentifier:identifier];
}
- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    return [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}
- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0)
{
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}


- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(5_0)
{
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0)
{
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerNib:(nullable UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0)
{
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
}
- (void)registerClass:(nullable Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0)
{
    [self.tableView registerClass:aClass forHeaderFooterViewReuseIdentifier:identifier];
}
- (void)reloadData {
    [self.tableView reloadData];
}
#pragma mark setter

- (void)setRefreshHeader:(UIView *)refreshHeader
{
    _refreshHeader = refreshHeader;
    self.scrollView.mj_header = (MJRefreshHeader *)refreshHeader;
}

- (void)setRefreshFooter:(UIView *)refreshFooter
{
    _refreshFooter = refreshFooter;
    self.scrollView.mj_footer = (MJRefreshFooter *)refreshFooter;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
