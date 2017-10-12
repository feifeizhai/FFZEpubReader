//
//  JingGeCollectionMenu.m
//  JGCloudProject
//
//  Created by 景格_徐薛波 on 2017/5/4.
//  Copyright © 2017年 jg_lxh. All rights reserved.
//

#import "JingGeCollectionMenu.h"
#import "JingGePopFlateButton.h"

#import "JingGeMacro.h"

@interface JingGeCollectionMenu ()<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate>



@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *subTitles;
@property (strong, nonatomic) NSArray *images;
@property (copy, nonatomic) selectAtIndex selectAtIndex;
@property (copy, nonatomic) creatAtIndex creatAtIndex;
@property (strong, nonatomic) JingGePopFlateButton *leftBtn;
@property (strong, nonatomic) UIButton *leftGroup;
@property (strong, nonatomic) JingGePopFlateButton *rightBtn;
@property (strong, nonatomic) UIButton *rightGroup;


@end

@implementation JingGeCollectionMenu

- (id)initWithCount:(NSInteger)count selectAtIndex:(selectAtIndex)index
{
    self = [super init];
    if (self) {
        self.count = count;
        self.selectAtIndex = index;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame count:(NSInteger)count selectAtIndex:(selectAtIndex)index
{
    self = [super initWithFrame:frame];
    if (self) {
      
        self.count = count;
        self.selectAtIndex = index;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame count:(NSInteger)count creatAtIndex:(creatAtIndex)creatAtIndex selectAtIndex:(selectAtIndex)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = count;
        self.selectAtIndex = index;
        self.creatAtIndex = creatAtIndex;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
    }
    return self;
}


- (UIButton *)leftGroup
{
    if (!_leftGroup) {
        self.leftGroup = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftGroup.frame = CGRectMake(0, 0, 32, self.frame.size.height);
        [_leftGroup addTarget:self action:@selector(pressLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftGroup];
    }
    return _leftGroup;
}

- (UIButton *)rightGroup
{
    if (!_rightGroup) {
        self.rightGroup = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightGroup.frame = CGRectMake(self.frame.size.width - 32, 0, 32, self.frame.size.height);
        [_rightGroup addTarget:self action:@selector(pressRightBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightGroup];
    }
    return _rightGroup;
}

- (JingGePopFlateButton *)leftBtn
{
    if (!_leftBtn) {
        self.leftBtn = [[JingGePopFlateButton alloc]initWithFrame:CGRectMake(kDefaultSpace * 2, 0, 20, 20) buttonType:buttonBackType buttonStyle:buttonPlainStyle animateToInitialState:NO];
        _leftBtn.center = CGPointMake(self.leftGroup.frame.size.width / 2, self.leftGroup.frame.size.height / 2);;
        _leftBtn.userInteractionEnabled = NO;
        [_leftBtn setTintColor:UIColorFromHex(0xbbbbbb) forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(pressLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.leftGroup addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (JingGePopFlateButton *)rightBtn
{
    if (!_rightBtn) {
        self.rightBtn = [[JingGePopFlateButton alloc]initWithFrame:CGRectMake(kDefaultSpace * 2, 0, 20, 20) buttonType:buttonForwardType buttonStyle:buttonPlainStyle animateToInitialState:NO];
        _rightBtn.center = CGPointMake(self.rightGroup.frame.size.width / 2, self.rightGroup.frame.size.height / 2);
        [_rightBtn addTarget:self action:@selector(pressRightBtn) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.userInteractionEnabled = NO;
        [_rightBtn setTintColor:UIColorFromHex(0xbbbbbb) forState:UIControlStateNormal];
        [self.rightGroup addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (JingGeMenuLayout *)layout
{
    if (!_layout) {
        self.layout = [[JingGeMenuLayout alloc]init];
        _layout.minimumLineSpacing = 40;
        _layout.itemSize = CGSizeMake(60, 60);
        
    }
    return _layout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JingGeMenuItem class] forCellWithReuseIdentifier:NSStringFromClass([JingGeMenuItem class])];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JingGeMenuItem *item =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JingGeMenuItem class]) forIndexPath:indexPath];
    
    if (self.creatAtIndex) {
          self.creatAtIndex(indexPath, item);
    }
    if (self.itemTitleFont) {
        item.titleLabel.font = self.itemTitleFont;
    }
    if (self.itemDetailFont) {
        item.detailLabel.font = self.itemDetailFont;
    }
    if (self.itemTitleColor) {
        item.titleLabel.textColor = self.itemTitleColor;
    }
    if (self.itemDetailTitleColor) {
        item.detailLabel.textColor = self.itemDetailTitleColor;
    }
    //item.backgroundColor = [UIColor redColor];
    if (self.titles.count > indexPath.row) {
        item.titleLabel.text = [self.titles objectAtIndex:indexPath.row];
    }
    if (self.subTitles.count > indexPath.row) {
        item.detailLabel.text = [self.subTitles objectAtIndex:indexPath.row];
    }
    if (self.images.count > indexPath.row) {
        item.imageView.image = [self.images objectAtIndex:indexPath.row];
        item.imageView.layer.cornerRadius = self.imageCorner;
        item.imageView.layer.masksToBounds = YES;
      ;
        //item.imageView.backgroundColor = kRandColor;
    }
    item.jingGeMenuItemType = self.jingGeMenuIteType;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal && self.collectionView.contentOffset.x + self.collectionView.frame.size.width < self.collectionView.contentSize.width){
        self.rightBtn.hidden = NO;
    }else{
        self.rightBtn.hidden = YES;
    }
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal && self.collectionView.contentOffset.x > 0) {
        self.leftBtn.hidden = NO;
    }else{
        self.leftBtn.hidden = YES;
    }
    
    return item;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JingGeMenuItem *item = (JingGeMenuItem *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectAtIndex(indexPath, item);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal && self.collectionView.contentSize.width > self.collectionView.frame.size.width) {
        if (scrollView.contentOffset.x <= 0) {
            self.leftBtn.hidden = YES;
        }else{
            self.leftBtn.hidden = NO;
        }
        
        if (scrollView.contentOffset.x + scrollView.frame.size.width >= scrollView.contentSize.width) {
            self.rightBtn.hidden = YES;
        }else{
            self.rightBtn.hidden = NO;
        }
    }
    

    
    
}

- (void)pressLeftBtn
{
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)pressRightBtn
{
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentSize.width - self.collectionView.frame.size.width, 0) animated:YES];
}

#pragma mark setter
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    self.layout.scrollDirection = scrollDirection;
    
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset
{
    _sectionInset = sectionInset;
    _layout.sectionInset = sectionInset;
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
{
    _minimumInteritemSpacing = minimumInteritemSpacing;
    self.layout.minimumInteritemSpacing = minimumInteritemSpacing;
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing
{
    _minimumLineSpacing = minimumLineSpacing;
    self.layout.minimumLineSpacing = minimumLineSpacing;
}
- (void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    _layout.itemSize = itemSize;
}



//- (void)setAutoSize:(BOOL)autoSize
//{
//    _autoSize = autoSize;
//   // self.collectionView.frame = CGRectMake(0, 0, self.collectionView.contentSize.width, self.collectionView.contentSize.height);
//    
//    
//   
//}

- (void)setDataSource:(NSArray *)titlesArray images:(NSArray *)images subTitlesArray:(NSArray *)subTitlsArray
{
    self.titles = titlesArray;
    self.images = images;
    self.subTitles = subTitlsArray;
    self.count = titlesArray.count;
    
    [self.collectionView reloadData];
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
