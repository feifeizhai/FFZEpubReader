//
//  JingGeEpubReaderControlView.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/20.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReaderControlView.h"
#import <JingGeNavigationBar.h>
#import <JingGeMacro.h>
#import "JingGeEpubReaderProgressView.h"
#import "JingGeEpubReaderConfig.h"
#import <JingGeSQLWork.h>
#import "JingGeEpubReaderColorChoiseCollectionViewCell.h"


#pragma mark ============JingGeEpubReaderFontChoiseView

@protocol JingGeEpubReaderFontChoiseViewDelegate <NSObject>

@optional

- (void)backItemActionAtView:(JingGeEpubReaderFontChoiseView *)view;

- (void)fontChoiseView:(JingGeEpubReaderFontChoiseView *)view selectAtIndex:(NSInteger)index;

@end

@interface JingGeEpubReaderFontChoiseView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) JingGeNavigationBar *topBar;
@property (strong, nonatomic) UITableView *fontTableView;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) JingGeEpubReaderConfig *config;
@property (assign, nonatomic) id<JingGeEpubReaderFontChoiseViewDelegate> delegate;
@end

@implementation JingGeEpubReaderFontChoiseView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self creatSubviews];
        [self subviewsLayout];
    }
    return self;
    
}

- (void)creatSubviews {
    [self addSubview:self.topBar];
    [self addSubview:self.fontTableView];
}

- (void)subviewsLayout {
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBar_HEIGHT + kStatusBar_HEIGHT);
    }];
    
    [_fontTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topBar.mas_bottom);
        make.trailing.leading.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)backItemAction:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backItemActionAtView:)]) {
        [self.delegate backItemActionAtView:self];
    }
}

//tableviwdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.config.fontArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    NSDictionary *fontDic = [self.config.fontArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [fontDic valueForKey:@"name"];
    cell.textLabel.font = [UIFont fontWithName:[fontDic valueForKey:@"fontName"] size:15];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
//tableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(fontChoiseView:selectAtIndex:)]) {
        cell.textLabel.textColor = self.config.backgroundColor;
        self.config.fontName = [[self.config.fontArray objectAtIndex:indexPath.row] valueForKey:@"fontName"];
        [self.delegate fontChoiseView:self selectAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
}

- (void)setConfig:(JingGeEpubReaderConfig *)config {
    _config = config;
    
    for (int i = 0; i < self.config.fontArray.count; i ++) {
        NSDictionary *fontDic = self.config.fontArray[i];
        NSString *fontName = [fontDic valueForKey:@"fontName"];
        if ([fontName isEqualToString:self.config.fontName]) {
            [self.fontTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            UITableViewCell *cell = [self.fontTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.textLabel.textColor = self.config.backgroundColor;
            return;
        }
    }
}

//懒加载
- (JingGeNavigationBar *)topBar {
    if (!_topBar) {
        _topBar = [JingGeNavigationBar new];
        _topBar.backItem = self.backBtn;
        _topBar.titleItem = self.titleLabel;
    }
    return _topBar;
}

- (UITableView *)fontTableView {
    if (!_fontTableView) {
        _fontTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _fontTableView.delegate = self;
        _fontTableView.dataSource = self;
        _fontTableView.backgroundColor = [UIColor blackColor];
    }
    return _fontTableView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:kGetImage(@"video_btn_close") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"字体";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor redColor];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end

#pragma mark ============JingGeFontSettingView
@protocol JingGeFontSettingViewDelegate <NSObject>

@optional

- (void)fontAddBtnActionWithView:(JingGeFontSettingView *)view;
- (void)fontMinusBtnActionWithView:(JingGeFontSettingView *)view;
- (void)fontChoiseBtnActionWithView:(JingGeFontSettingView *)view;

@end

@interface JingGeFontSettingView ()

@property (strong, nonatomic) UIButton *fontAddBtn;
@property (strong, nonatomic) UIButton *fontMinusBtn;
@property (strong, nonatomic) UIButton *fontChoiseBtn;
@property (strong, nonatomic) UILabel *fontSizeLabel;
@property (strong, nonatomic) UISegmentedControl *selectLineSpaceControl;
@property (strong, nonatomic) JingGeEpubReaderConfig *config;
@property (assign, nonatomic) id<JingGeFontSettingViewDelegate> delegate;

@end

@implementation JingGeFontSettingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
        [self addAction];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.fontAddBtn];
    [self addSubview:self.fontMinusBtn];
    [self addSubview:self.fontChoiseBtn];
    [self addSubview:self.fontSizeLabel];
}

- (void)subviewsLayout {
    
    [_fontMinusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo((kScreenWidth - 20 * 3 - 50) / 3);
        make.height.mas_equalTo(30);
    }];
    
    [_fontSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(_fontMinusBtn.mas_right);
        make.width.mas_equalTo(50);
    }];
    
    [_fontAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(_fontSizeLabel.mas_right);
        make.width.mas_equalTo(_fontMinusBtn.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    [_fontChoiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(_fontAddBtn.mas_right).offset(20);
        make.width.mas_equalTo(_fontMinusBtn.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    /*
    [_selectLineSpaceControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fontAddBtn.mas_top);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(- 20);
        make.height.mas_equalTo(30);
    }];
    */
}

- (void)addAction {
    [_fontAddBtn addTarget:self action:@selector(fontAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fontMinusBtn addTarget:self action:@selector(fontMinusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fontChoiseBtn addTarget:self action:@selector(fontChoiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)fontAddBtnAction:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fontAddBtnActionWithView:)]) {
        
        int fontSize = self.config.textSize + 2;
        if (fontSize > kFontSizeMax) {
            fontSize = kFontSizeMax;
            [self setUnUserWithButton:self.fontAddBtn];
        }
        
        [self setCanUserWithButton:self.fontMinusBtn];
        
       
        self.config.textSize = fontSize;
        self.fontSizeLabel.text = [NSString stringWithFormat:@"%d", fontSize];
        [self.delegate fontAddBtnActionWithView:self];
    }
}

- (void)fontMinusBtnAction:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fontMinusBtnActionWithView:)]) {
        
        int fontSize = self.config.textSize - 2;
        if (fontSize < kFontSizeMin) {
            fontSize = kFontSizeMin;
            [self setUnUserWithButton:self.fontMinusBtn];
        }
        [self setCanUserWithButton:self.fontAddBtn];
        self.config.textSize = fontSize;
        self.fontSizeLabel.text = [NSString stringWithFormat:@"%d", fontSize];
        [self.delegate fontMinusBtnActionWithView:self];
        
    }
}

- (void)fontChoiseBtnAction:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fontChoiseBtnActionWithView:)]) {
        [self.delegate fontChoiseBtnActionWithView:self];
    }
}

- (void)setCanUserWithButton:(UIButton *)btn {
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.userInteractionEnabled = YES;
}
- (void)setUnUserWithButton:(UIButton *)btn {
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.userInteractionEnabled = NO;
}


- (void)setConfig:(JingGeEpubReaderConfig *)config {
    _config = config;
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%d", (int)config.textSize];
    
    if (config.textSize >= kFontSizeMax) {
        [self setUnUserWithButton:self.fontAddBtn];
    }
    
    if (config.textSize <= kFontSizeMin) {
        [self setUnUserWithButton:self.fontMinusBtn];
    }
    
    
    
    
}

#pragma mark 懒加载
- (UIButton *)fontAddBtn {
    if (!_fontAddBtn) {
        _fontAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontAddBtn setTitle:@"Aa+" forState:UIControlStateNormal];
        [_fontAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
        _fontAddBtn.layer.cornerRadius = 3;
        _fontAddBtn.layer.borderWidth = 1;
        _fontAddBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _fontAddBtn;
}

- (UIButton *)fontMinusBtn {
    if (!_fontMinusBtn) {
        _fontMinusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontMinusBtn setTitle:@"Aa-" forState:UIControlStateNormal];
        [_fontMinusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        _fontMinusBtn.layer.cornerRadius = 3;
        _fontMinusBtn.layer.borderWidth = 1;
        _fontMinusBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _fontMinusBtn;
}

- (UIButton *)fontChoiseBtn {
    if (!_fontChoiseBtn) {
        _fontChoiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fontChoiseBtn setTitle:@"字体选择" forState:UIControlStateNormal];
        _fontChoiseBtn.titleLabel.font = UISYSTEM_FONT(12);
        _fontChoiseBtn.layer.cornerRadius = 3;
        _fontChoiseBtn.layer.borderWidth = 1;
        _fontChoiseBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _fontChoiseBtn;
}

- (UISegmentedControl *)selectLineSpaceControl {
    if (!_selectLineSpaceControl) {
        NSArray *segmentedArray = @[@"最小", @"较小", @"适中", @"较大", @"最大"];
      
        _selectLineSpaceControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
        
        
    }
    return _selectLineSpaceControl;
}

- (UILabel *)fontSizeLabel {
    if (!_fontSizeLabel) {
        _fontSizeLabel = [UILabel new];
        _fontSizeLabel.textAlignment = NSTextAlignmentCenter;
        _fontSizeLabel.textColor = [UIColor whiteColor];
    }
    return _fontSizeLabel;
}


@end

@protocol JinggeBottomBarDelegate <NSObject>
@optional
- (void)jingGeBottomBar:(JinggeBottomBar *)bar clickItemAtIndex:(NSInteger)index;

@end
#define kButtonSize CGSizeMake(50, 35)
@interface JinggeBottomBar () 

@property (assign, nonatomic) id<JinggeBottomBarDelegate> delegate;
@property (strong, nonatomic) JingGeEpubReaderConfig *config;

@end

@implementation JinggeBottomBar

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images selectImages:(NSArray *)selectImages {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatButton:images selectImages:selectImages];
    }
    return self;
}

- (void)setConfig:(JingGeEpubReaderConfig *)config {
    _config = config;
    UIButton *btn = [self viewWithTag:1000 + 1];
    btn.selected = config.displayStyle;
}

- (void)creatButton:(NSArray *)images selectImages:(NSArray *)selectImages{
    
    CGFloat space = (self.frame.size.width - kDefaultSpace * 8 - kButtonSize.width * images.count) / (images.count - 1);
    
    for (int i = 0; i < images.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:kGetImage(images[i]) forState:UIControlStateNormal];
        [button setImage:kGetImage(selectImages[i]) forState:UIControlStateSelected];
        button.frame = CGRectMake(kDefaultSpace * 4 + i * space + i * kButtonSize.width , 0, kButtonSize.width, kButtonSize.height);
        button.center = CGPointMake(button.center.x, self.bounds.size.height / 2);
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(jingGeBottomBar:clickItemAtIndex:)]) {
        [self.delegate jingGeBottomBar:self clickItemAtIndex:button.tag - 1000];
    }
}

@end

@protocol JingGeEpubReaderControlBottomViewDelegate <NSObject>

@optional

- (void)catalogItemAction:(JingGeEpubReaderControlBottomView *)bottomView;

- (void)settingItemAction:(JingGeEpubReaderControlBottomView *)bottomView;

- (void)lightItemAction:(JingGeEpubReaderControlBottomView *)bottomView;
@end

@interface JingGeEpubReaderControlBottomView ()<UITabBarDelegate, JinggeBottomBarDelegate>

@property (strong, nonatomic) JinggeBottomBar *bottomBar;
@property (strong, nonatomic) JingGeEpubReaderProgressView *progressView;
@property (assign, nonatomic) id<JingGeEpubReaderControlBottomViewDelegate> delegate;
@property (strong, nonatomic) JingGeEpubReaderConfig *config;

@end

@implementation JingGeEpubReaderControlBottomView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.bottomBar];
    //[self addSubview:self.progressView];
}

- (void)subviewsLayout {
    [_bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
        make.leading.trailing.mas_equalTo(0);
    }];
}

#pragma tabbardelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    switch (item.tag) {
        case 1000:
            [self catalogItemAction];
            break;
        case 2000:
            
            break;
        case 3000:
            [self settingItemAction];
            break;
            
        default:
            break;
    }
}

#pragma mark 代理实现
- (void)catalogItemAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(catalogItemAction:)]) {
        [self.delegate catalogItemAction:self];
    }
}

- (void)settingItemAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingItemAction:)]) {
        [self.delegate settingItemAction:self];
    }
}

- (void)lightItemAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(lightItemAction:)]) {
        [self.delegate lightItemAction:self];
    }
}


#pragma mark bottombarDelegate;

- (void)jingGeBottomBar:(JinggeBottomBar *)bar clickItemAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            [self catalogItemAction];
            break;
        case 1:
            [self lightItemAction];
            break;
        case 2:
            [self settingItemAction];
            break;
        default:
            break;
    }
}


- (void)setConfig:(JingGeEpubReaderConfig *)config {
    self.bottomBar.backgroundColor = config.naviColor;
    self.bottomBar.config = config;
}

#pragma mark 懒加载
- (JinggeBottomBar *)bottomBar {
    if (!_bottomBar) {
        
        _bottomBar = [[JinggeBottomBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kToolsBar_HEIGHT) images:@[@"read_bar_0", @"RM_13",@"read_bar_2"] selectImages:@[@"read_bar_0", @"RM_14",@"read_bar_2"]];
        _bottomBar.delegate = self;
        
        //_bottomBar.backgroundColor = [UIColor blueColor];
        
        
    }
    return _bottomBar;
}

- (JingGeEpubReaderProgressView *)progressView {
    if (!_progressView) {
        _progressView = [JingGeEpubReaderProgressView new];
    }
    return _progressView;
}

@end


#pragma mark =================== JingGeEpubReaderControlSettingView

@protocol JingGeEpubReaderControlSettingViewDelgate <NSObject>

@optional

- (void)settingViewChange:(JingGeEpubReaderControlSettingView *)settingView sholdReload:(BOOL)sholdReload;

- (void)showOtherView:(JingGeEpubReaderControlSettingView *)settingView;

- (void)hidOtherView:(JingGeEpubReaderControlSettingView *)settingView;

@end

@interface JingGeEpubReaderControlSettingView ()<UICollectionViewDelegate, UICollectionViewDataSource, JingGeFontSettingViewDelegate>

@property (strong, nonatomic) JingGeEpubReaderProgressView *lightProgressView;
@property (strong, nonatomic) UICollectionView *backgroundChoiseView;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) JingGeEpubReaderProgressView *fontProgressView;
@property (strong, nonatomic) UIButton *fontBtn;
@property (strong, nonatomic) JingGeFontSettingView *fontSettingView;
@property (strong, nonatomic) JingGeEpubReaderConfig *config;
@property (assign, nonatomic) id<JingGeEpubReaderControlSettingViewDelgate> delegate;
@property (strong, nonatomic) UISegmentedControl *lineSpaceControl;

@end

@implementation JingGeEpubReaderControlSettingView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.lightProgressView];
    //[self addSubview:self.fontProgressView];
    [self addSubview:self.fontSettingView];
    [self addSubview:self.backgroundChoiseView];
    [self addSubview:self.fontBtn];
    [self addSubview:self.lineSpaceControl];
}

- (void)subviewsLayout {
    
    [_lightProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
    }];
    
    [_fontSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0).offset(-kDefaultSpace);
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
    }];
    
    [_lineSpaceControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_fontSettingView.mas_top).offset(-kDefaultSpace);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    
    [_backgroundChoiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lightProgressView.mas_bottom);
        make.height.mas_equalTo(49);
        make.leading.trailing.mas_equalTo(0);
    }];
    
}

- (void)lineSpaceControlAction:(UISegmentedControl *)control {
    
    switch (control.selectedSegmentIndex) {
        case 0:
            self.config.lineSpace = EpubReaderLineSpaceTypeMin;
            break;
        case 1:
            self.config.lineSpace = EpubReaderLineSpaceTypeSmall;
            break;
        case 2:
            self.config.lineSpace = EpubReaderLineSpaceTypeMedium;
            break;
        case 3:
            self.config.lineSpace = EpubReaderLineSpaceTypeLarge;
            break;
        case 4:
            self.config.lineSpace = EpubReaderLineSpaceTypeMax;
            break;
            
        default:
            break;
    }
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
        [self.delegate settingViewChange:self sholdReload:YES];
    }
}

#pragma mark collectionViewdatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.config.backgoundColorArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JingGeEpubReaderColorChoiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JingGeEpubReaderColorChoiseCollectionViewCell class]) forIndexPath:indexPath];
    
    
    cell.backgroundColor = self.config.backgoundColorArray[indexPath.row];
    
    return cell;
}
#pragma mark collectionViewdelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JingGeEpubReaderColorChoiseCollectionViewCell *cell = (JingGeEpubReaderColorChoiseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.config.displayStyle = EpubReaderDisplayStyleNomal;
    self.config.backgroundColor = cell.backgroundColor;
  
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
        [self.delegate settingViewChange:self sholdReload:NO];
    }
    cell.contentView.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    JingGeEpubReaderColorChoiseCollectionViewCell *cell = (JingGeEpubReaderColorChoiseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
}
// fontsettingView delegate
- (void)fontAddBtnActionWithView:(JingGeFontSettingView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
        [self.delegate settingViewChange:self sholdReload:YES];
    }
}
- (void)fontMinusBtnActionWithView:(JingGeFontSettingView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
        [self.delegate settingViewChange:self sholdReload:YES];
    }
}
- (void)fontChoiseBtnActionWithView:(JingGeFontSettingView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showOtherView:)]) {
        [self.delegate showOtherView:self];
    }
}

#pragma mark 赋值

- (void)setConfig:(JingGeEpubReaderConfig *)config {
    _config = config;
    [self addSubviews];
    [self subviewsLayout];
    self.lightProgressView.value = config.lightNum;
    self.fontProgressView.value = (config.textSize - kFontSizeMin) / (kFontSizeMax - kFontSizeMin);
    self.fontSettingView.config = config;
    
    switch (config.lineSpace) {
        case EpubReaderLineSpaceTypeMin:
            [self.lineSpaceControl setSelectedSegmentIndex:0];
            break;
        case EpubReaderLineSpaceTypeSmall:
            [self.lineSpaceControl setSelectedSegmentIndex:1];
            break;
        case EpubReaderLineSpaceTypeMedium:
            [self.lineSpaceControl setSelectedSegmentIndex:2];
            break;
        case EpubReaderLineSpaceTypeLarge:
            [self.lineSpaceControl setSelectedSegmentIndex:3];
            break;
        case EpubReaderLineSpaceTypeMax:
            [self.lineSpaceControl setSelectedSegmentIndex:4];
            break;
           
            default:
            break;
    }

}

#pragma mark 懒加载
- (JingGeEpubReaderProgressView *)lightProgressView {
    if (!_lightProgressView) {
        kWeakSelf(ws);
        _lightProgressView = [[JingGeEpubReaderProgressView alloc] initWithSliderBlock:^(CGFloat value) {
            [[UIScreen mainScreen] setBrightness:value];
            ws.config.lightNum = value;
            [[JingGeSQLWork shareJingGeSQL] updateDBWithModel:ws.config where:nil];
        }];
    }
    return _lightProgressView;
}

- (JingGeEpubReaderProgressView *)fontProgressView {
    if (!_fontProgressView) {
        kWeakSelf(ws);
        _fontProgressView = [[JingGeEpubReaderProgressView alloc] initWithSliderBlock:^(CGFloat value) {
            ws.config.textSize = value * (kFontSizeMax - kFontSizeMin) + kFontSizeMin;
            if (ws.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
                [ws.delegate settingViewChange:self sholdReload:YES];
            }
        }];
    }
    return _fontProgressView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(35, 35);
        _layout.minimumInteritemSpacing = 9.5;
        _layout.minimumLineSpacing = (kScreenWidth - 35 * 6 - 20 * 2) / 5;
    }
    return _layout;
}

- (UICollectionView *)backgroundChoiseView {
    if (!_backgroundChoiseView) {
        _backgroundChoiseView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kToolsBar_HEIGHT) collectionViewLayout:self.layout];
        [_backgroundChoiseView registerClass:[JingGeEpubReaderColorChoiseCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JingGeEpubReaderColorChoiseCollectionViewCell class])];
        _backgroundChoiseView.backgroundColor = [UIColor clearColor];
        _backgroundChoiseView.delegate = self;
        _backgroundChoiseView.dataSource= self;
        _backgroundChoiseView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return _backgroundChoiseView;
}

- (JingGeFontSettingView *)fontSettingView {
    if (!_fontSettingView) {
        _fontSettingView = [JingGeFontSettingView new];
        _fontSettingView.delegate = self;
    }
    return _fontSettingView;
}

- (UISegmentedControl *)lineSpaceControl {
    if (!_lineSpaceControl) {
        NSArray *segmentedArray = @[@"最小", @"较小", @"适中", @"较大", @"最大"];
        _lineSpaceControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
        _lineSpaceControl.tintColor = [UIColor whiteColor];
        
        [_lineSpaceControl addTarget:self action:@selector(lineSpaceControlAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _lineSpaceControl;
}

- (UIButton *)fontBtn {
    if (!_fontBtn) {
        _fontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _fontBtn;
}


@end

#pragma mark =================== JingGeEpubReaderControlView

#define kSettingViewHeight kToolsBar_HEIGHT * 4 + 2 * kDefaultSpace
#define kAnimationTime 0.25
#define kFontChoiseViewHeight 240
@interface JingGeEpubReaderControlView ()<UIGestureRecognizerDelegate, JingGeEpubReaderControlBottomViewDelegate, JingGeEpubReaderControlSettingViewDelgate, JingGeEpubReaderFontChoiseViewDelegate>

@property (strong, nonatomic) JingGeNavigationBar *naviBar;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) JingGeEpubReaderControlBottomView *bottomView;
@property (strong, nonatomic) JingGeEpubReaderControlSettingView *settingView;
@property (strong, nonatomic) JingGeEpubReaderProgressView *lightView;
@property (strong, nonatomic) JingGeEpubReaderFontChoiseView *fontChoiseView;

@end

@implementation JingGeEpubReaderControlView

- (void)dealloc {
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self subviewsLayout];
        [self addGestureRecognizer];
        [self addAction];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.naviBar];
    [self addSubview:self.bottomView];
    [self addSubview:self.settingView];
    [self addSubview:self.lightView];
    [self addSubview:self.fontChoiseView];
}

- (void)subviewsLayout {
    
    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-kNavigationBar_HEIGHT - kStatusBar_HEIGHT);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBar_HEIGHT + kStatusBar_HEIGHT);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kToolsBar_HEIGHT);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
    }];
    
    [_lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kToolsBar_HEIGHT);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kToolsBar_HEIGHT);
    }];
    
    [_settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kSettingViewHeight);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kSettingViewHeight);
    }];
    
    [_fontChoiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kFontChoiseViewHeight);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kFontChoiseViewHeight);
    }];
    
    
    
}

- (void)addGestureRecognizer {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    singleTap.delegate = self;
    [self addGestureRecognizer:singleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap {
    [self hidSubviewWithAnimation:YES];
}

- (void)addAction {
    [self.backBtn addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backItemAction:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backItemAction:)]) {
        [self.delegate backItemAction:self];
    }
}

- (void)showControlWithView:(UIView *)view {
    if (!self.superview) {
        [view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.leading.trailing.mas_equalTo(0);
        }];
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [self showSubviewsWithAnimation:YES];
    }else {
        [self removeFromSuperview];
    }
   
}

#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UIBarButtonItem"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeNavigationBar"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITabBarButton"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITabBar"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeEpubReaderControlSettingView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeEpubReaderProgressView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UISlider"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JinggeBottomBar"] || [NSStringFromClass([[touch.view superview] superclass]) isEqualToString:@"UICollectionViewCell"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionView"]|| [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeFontSettingView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableView"]) {
        return NO;
    }
    return YES;
}
#pragma mark bottomViewDelegate

- (void)catalogItemAction:(JingGeEpubReaderControlBottomView *)bottomView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(catalogItemAction:)]) {
        [self.delegate catalogItemAction:self];
        [self hidSubviewWithAnimation:YES];
    }
}

- (void)settingItemAction:(JingGeEpubReaderControlBottomView *)bottomView {
    [self showSettingViewWithAnimation:YES];
}

- (void)lightItemAction:(JingGeEpubReaderControlBottomView *)bottomView {
    //[self showLightVIewWithAnimation:YES];
    if (self.config.displayStyle == EpubReaderDisplayStyleNomal) {
        self.config.displayStyle = EpubReaderDisplayStyleNight;
    }else {
        self.config.displayStyle = EpubReaderDisplayStyleNomal;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
        [self.delegate settingViewChange:self sholdReload:YES];
    }
}

#pragma mark settingViewDelegate

- (void)settingViewChange:(JingGeEpubReaderControlSettingView *)settingView sholdReload:(BOOL)sholdReload {
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
        [self.delegate settingViewChange:self sholdReload:sholdReload];
    }
}
- (void)showOtherView:(JingGeEpubReaderControlSettingView *)settingView {
    [self showFontChoiseViewWithAnimation:YES];
}

- (void)hidOtherView:(JingGeEpubReaderControlSettingView *)settingView {
    [self hidFontChoiseViewWithAnimation:YES];
}
#pragma mark fontchoisedelegate
- (void)backItemActionAtView:(JingGeEpubReaderFontChoiseView *)view {
    [self hidFontChoiseViewWithAnimation:YES];
}

- (void)fontChoiseView:(JingGeEpubReaderFontChoiseView *)view selectAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewChange:sholdReload:)]) {
        [self.delegate settingViewChange:self sholdReload:YES];
    }
}

#pragma mark 动画
- (void)showSubviewsWithAnimation:(BOOL)animation {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self.naviBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
    }];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidSubviewWithAnimation:(BOOL)animation {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self.naviBar mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(-kNavigationBar_HEIGHT - kStatusBar_HEIGHT);
    }];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kToolsBar_HEIGHT);
    }];
    
    [self.settingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kSettingViewHeight);
    }];
    
    [self.lightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kToolsBar_HEIGHT);
    }];
    
    [self.fontChoiseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kFontChoiseViewHeight);
    }];
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
          [self removeFromSuperview];
    }];
}

- (void)showSettingViewWithAnimation:(BOOL)animation {
    [self.settingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kToolsBar_HEIGHT);
    }];
    
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];

}

- (void)hidSettingViewWithAnimation:(BOOL)animation {
    [self.settingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kSettingViewHeight);
    }];
    
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
       // [self removeFromSuperview];
    }];

}

- (void)showLightVIewWithAnimation:(BOOL)animation {
    [self.lightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kToolsBar_HEIGHT);
    }];
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
}

- (void)hidLightVIewWithAnimation:(BOOL)animation {
    [self.lightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kToolsBar_HEIGHT);
    }];
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
        // [self removeFromSuperview];
    }];
}

- (void)showFontChoiseViewWithAnimation:(BOOL)animation {
    [self.fontChoiseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
 
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
}

- (void)hidFontChoiseViewWithAnimation:(BOOL)animation {
    [self.fontChoiseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(kFontChoiseViewHeight);
    }];
    kWeakSelf(ws);
    [UIView animateWithDuration:kAnimationTime animations:^{
        [ws setNeedsLayout];
        [ws layoutIfNeeded];
    } completion:^(BOOL finished) {
        // [self removeFromSuperview];
    }];
}

#pragma mark 赋值
- (void)setConfig:(JingGeEpubReaderConfig *)config {
    _config = config;
    self.settingView.config = config;
    self.bottomView.config = config;
    self.fontChoiseView.config = config;
    self.naviBar.backgroundColor = config.naviColor;
    self.settingView.backgroundColor = config.naviColor;
    self.lightView.backgroundColor = config.naviColor;
    self.lightView.value = config.lightNum;
    self.fontChoiseView.backgroundColor = config.naviColor;
}

#pragma mark 懒加载
- (JingGeNavigationBar *)naviBar {
    if (!_naviBar) {
        _naviBar = [JingGeNavigationBar new];
        _naviBar.backItem = self.backBtn;
    }
    return _naviBar;
}

- (JingGeEpubReaderFontChoiseView *)fontChoiseView {
    if (!_fontChoiseView) {
        _fontChoiseView = [JingGeEpubReaderFontChoiseView new];
        _fontChoiseView.delegate = self;
    }
    return _fontChoiseView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (JingGeEpubReaderControlBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [JingGeEpubReaderControlBottomView new];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (JingGeEpubReaderProgressView *)lightView {
    if (!_lightView) {
        kWeakSelf(ws);
        _lightView = [[JingGeEpubReaderProgressView alloc] initWithSliderBlock:^(CGFloat value) {
            [[UIScreen mainScreen] setBrightness:value];
            ws.config.lightNum = value;
            [[JingGeSQLWork shareJingGeSQL] updateDBWithModel:ws.config where:nil];
        }];
    }
    return _lightView;
}

- (JingGeEpubReaderControlSettingView *)settingView {
    if (!_settingView) {
        _settingView = [JingGeEpubReaderControlSettingView new];
        _settingView.delegate = self;

    }
    return _settingView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
