//
//  JingGeAnswerSheetCollectionView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerSheetCollectionView.h"
#import "JingGeAnswerSheetCollectionViewCell.h"
#import "JingGeAnswerModel.h"
#import "JingGeMacro.h"

#define kCollectionViewSpace 20

@interface JingGeAnswerSheetCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>



@end

@implementation JingGeAnswerSheetCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        [self registerClass:[JingGeAnswerSheetCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JingGeAnswerSheetCollectionViewCell class])];
        self.dataSource = self;
        self.delegate = self;
        //self.contentInset = UIEdgeInsetsMake(15, 17.5, 0, 17.5);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark collectionview datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.questionList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JingGeAnswerSheetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JingGeAnswerSheetCollectionViewCell class]) forIndexPath:indexPath];
    cell.parsingType = self.model.parsingType;
    
    cell.config = self.config;
    JingGeQuestionModel *questionModel = [self.model.questionList objectAtIndex:indexPath.row];
    cell.model = questionModel;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.sheetDelegate && [self.sheetDelegate respondsToSelector:@selector(answerSheetView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.sheetDelegate answerSheetView:self viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    return [UICollectionReusableView new];
}

#pragma mark collectionview delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sheetDelegate respondsToSelector:@selector(answerSheetView:didSelectItemAtIndexPath:)]) {
        [self.sheetDelegate answerSheetView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark scrollviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.sheetDelegate respondsToSelector:@selector(answerSheetViewDidScroll:)]) {
        [self.sheetDelegate answerSheetViewDidScroll:scrollView];
    }
}
#pragma mark 赋值
- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    [self reloadData];
}

#pragma mark 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake(40, 40);
        _layout.minimumLineSpacing = kCollectionViewSpace;
        _layout.minimumInteritemSpacing = kCollectionViewSpace;
        _layout.sectionInset = UIEdgeInsetsMake(15, 17.5, kToolsBar_HEIGHT, 17.5);
    }
    return _layout;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
