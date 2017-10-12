//
//  JingGeAnswerSheetView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerSheetView.h"
#import "JingGeMacro.h"
#import "JingGeAnswerSheetCollectionView.h"

#define kbtnSize  CGSizeMake(80, 40)

@interface JingGeAnswerSheetView ()<JingGeAnswerSheetCollectionViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *topBar;
@property (strong, nonatomic) JingGeAnswerSheetCollectionView *sheetView;
@property (strong, nonatomic) UIView *lucencyView;
@property (assign, nonatomic) BOOL isShow;
@property (assign, nonatomic) UIView *parentView;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UILabel *pageLabel;
@property (strong, nonatomic) UIButton *sheetButton;
@end
@implementation JingGeAnswerSheetView
- (void)dealloc {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.lucencyView removeFromSuperview];
    self.lucencyView = nil;
}

- (id)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
        [self addAction];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.topBar];
    [self addSubview:self.sheetView];
    [self.topBar addSubview:self.submitButton];
    [self.topBar addSubview:self.pageLabel];
    [self.topBar addSubview:self.sheetButton];
}
- (void)subviewsLayout {
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
        make.trailing.leading.mas_equalTo(0);
    }];
    
    [_sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topBar.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
    }];
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kDefaultSpace);
        make.centerY.mas_equalTo(self.topBar);
        make.size.mas_equalTo (kbtnSize);
    }];
    [_sheetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- kDefaultSpace);
        make.centerY.mas_equalTo(self.topBar);
        make.size.mas_equalTo (kbtnSize);
    }];
    [_pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.submitButton.mas_right);
        make.centerY.mas_equalTo(self.submitButton);
        make.right.mas_equalTo(self.sheetButton.mas_left);
    }];
}

- (void)addAction {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *lucencyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [self.lucencyView addGestureRecognizer:lucencyTap];
    
    
    [self.submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    if (self.isShow) {
        [self hidSheetViewWithView:self.superview];
    }else {
        [self showSheetViewWithView:self.superview];
    }
    
}

- (void)submitButtonAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitButtonActionSheetView:)]) {
        [self.delegate submitButtonActionSheetView:self];
    }
}

- (void)showSheetViewWithView:(UIView *)view {
    self.isShow = YES;
    
    if ([self.delegate respondsToSelector:@selector(showSheetView:)]) {
        [self.delegate showSheetView:self];
    }
    self.parentView = view;
    [kWindow.rootViewController.view addSubview:self.lucencyView];
    //[view insertSubview:self.lucencyView belowSubview:self];
    [kWindow.rootViewController.view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.leading.trailing.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [kWindow.rootViewController.view setNeedsLayout];
        [kWindow.rootViewController.view layoutIfNeeded];
        _lucencyView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    //self.sheetView.parsingType = self.model.parsingType;
    [self.sheetView reloadData];
}

- (void)hidSheetViewWithView:(UIView *)view {
    self.isShow = NO;
    if ([self.delegate respondsToSelector:@selector(hidSheetView:)]) {
        [self.delegate hidSheetView:self];
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.frame.size.height - kToolsBar_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [view setNeedsLayout];
        [view layoutIfNeeded];
        _lucencyView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_lucencyView removeFromSuperview];
        // [self removeFromSuperview];
        [self.parentView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.frame.size.height - kToolsBar_HEIGHT);
            make.leading.trailing.mas_equalTo(0);
        }];
    }];
}

#pragma mark gestureRecogizer delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([[[touch.view.superview  superview] class] isSubclassOfClass:[UICollectionView class]]) {
        
        return NO;
    }
    return YES;
}
#pragma mark
- (void)answerSheetView:(JingGeAnswerSheetCollectionView *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(answerSheetView:didSelectItemAtIndexPath:)]) {
        [self hidSheetViewWithView:self.superview];
        [self.delegate answerSheetView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark 赋值
- (void)setModel:(JingGeAnswerModel *)model {
    _model = model;
    self.sheetView.model = model;
}



- (void)setPageNum:(NSString *)pageNum {
    _pageNum = pageNum;
    self.pageLabel.text = pageNum;
}

- (void)setConfig:(JingGeAnswerConfig *)config {
    _config = config;
    _sheetView.config = self.config;
}

#pragma mark lazyloading
- (UIView *)topBar {
    if (!_topBar) {
        _topBar = [UIView new];
        // _topBar.backgroundColor = [UIColor whiteColor];
    }
    return _topBar;
}

- (JingGeAnswerSheetCollectionView *)sheetView {
    if (!_sheetView) {
        _sheetView = [[JingGeAnswerSheetCollectionView alloc] initWithFrame:self.bounds];
        _sheetView.sheetDelegate = self;
        //_sheetView.config = self.config;
    }
    return _sheetView;
}

- (UIView *)lucencyView {
    if (!_lucencyView) {
        _lucencyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _lucencyView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _lucencyView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"  交卷" forState:UIControlStateNormal];
        [_submitButton setTitleColor:kColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = UISYSTEM_FONT(16);
        [_submitButton setImage:kGetImage(@"img_submit") forState:UIControlStateNormal];
        [_submitButton sizeToFit];
    }
    return _submitButton;
}

- (UILabel *)pageLabel {
    if (!_pageLabel) {
        _pageLabel = [UILabel new];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.textColor = UIColorFromHex(0x73736d);
        _pageLabel.font = UISYSTEM_FONT(13);
    }
    return _pageLabel;
}

- (UIButton *)sheetButton {
    if (!_sheetButton) {
        _sheetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sheetButton.titleLabel.font = UISYSTEM_FONT(16);
        [_sheetButton setTitle:@"  题卡" forState:UIControlStateNormal];
        [_sheetButton setTitleColor:UIColorFromHex(0x73736d) forState:UIControlStateNormal];
        [_sheetButton setImage:kGetImage(@"img_sheet_card") forState:UIControlStateNormal];
        [_sheetButton sizeToFit];
        
        _sheetButton.userInteractionEnabled = NO;
    }
    return _sheetButton;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, UIColorFromHex(0xe0e0e0).CGColor);
    CGContextStrokeRect(context,CGRectMake(0,0, rect.size.width,0.5));
    CGContextStrokeRect(context,CGRectMake(0,kToolsBar_HEIGHT - 0.5, rect.size.width,0.5));
}


@end
