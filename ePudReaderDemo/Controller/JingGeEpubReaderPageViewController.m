//
//  JingGeEpubReaderPageViewController.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReaderPageViewController.h"
#import "JingGeEpubPageWebView.h"
#import "JingGeEpubParser.h"
#import "JingGeEpubReaderConfig.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "KRVideoPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MBProgressHUD.h>
#import <UIView+CustomControlView.h>
#import <ZFPlayer.h>

@interface JingGeEpubReaderPageViewController ()<JingGeEpubPageWebViewDelegate,UIGestureRecognizerDelegate, ZFPlayerDelegate>

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) KRVideoPlayerController *videoController;

@property (strong, nonatomic) UILabel *titleLabel;           //
@property (strong, nonatomic) UILabel *pageStatusLabel;      //
@property (strong, nonatomic) UILabel *timeStatusLabel;      //
@property (strong, nonatomic) UIImageView *placeHolderImageView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (strong, nonatomic) UIView *playerFatherView;
@property (strong, nonatomic) ZFPlayerView *playerView;
@end

@implementation JingGeEpubReaderPageViewController

- (void)dealloc {
    /*
    if (_webView) {
        _webView.epubDelegate = nil;
    }
     */
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.placeHolderImageView.image = [UIImage captureWithView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.placeHolderImageView.hidden = YES;
    [self webViewLoadHTML];
    
    [self.view addSubview:self.webView];
    
     [self.view bringSubviewToFront:self.playerFatherView];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.placeHolderImageView.hidden = NO;
    //[_webView loadRequest:nil];
    
    if (_webView && _webView.epubDelegate == self) {
        _webView.epubDelegate = nil;
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.config.backgroundColor;
    //self.view.layer.backgroundColor = self.config.backgroundColor.CGColor;
    [self addSubviews];
    [self subviewsLayout];
    

    // Do any additional setup after loading the view.
}

- (void)addSubviews {
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.placeHolderImageView];
    [self.view addSubview:self.contentView];

    [self.contentView addSubview:self.titleLabel];
    //[self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.timeStatusLabel];
    [self.contentView addSubview:self.pageStatusLabel];
    [self.view addSubview:self.playerFatherView];
    
}

- (void)subviewsLayout {
 
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
    }];
    [self.placeHolderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
    }];
  
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kDefaultSpace * 2);
        make.left.mas_equalTo(kDefaultSpace * 2);
        make.right.mas_equalTo(- kDefaultSpace * 2);
    }];
    
    [self.timeStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    [self.pageStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kDefaultSpace);
        make.right.mas_equalTo(-kDefaultSpace * 2);
    }];
    
}


- (void)webViewLoadHTML {

    if (self.webView) {
      
        self.webView.epubDelegate = self;
        self.webView.fragmentID = self.fragmentID;
        self.webView.pageRefIndex = self.pageRefIndex;
        self.webView.offYIndexInPage = self.offYIndexInPage;
        self.webView.config = self.config;
        [self.webView gotoOffYInPageWithOffYIndex:self.offYIndexInPage WithOffCountInPage:[[self.dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(self.pageRefIndex)]] integerValue]];
    }
  
    
}

- (void)showHUD{
    [MBProgressHUD hideHUDForView:self.contentView animated:YES];
    [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
}
- (void)hidHUD {
    [MBProgressHUD hideHUDForView:self.contentView animated:YES];
}

- (void)captureWithView {
     self.placeHolderImageView.image = [UIImage captureWithView:self.view];
}


#pragma mark webviewDelegae

- (void)webViewDidFinishLoad:(UIWebView *)theWebView {
    //[self hidHUD];
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:_webView];
    }
    self.offYIndexInPage = self.webView.offYIndexInPage;
    //self.placeHolderImageView.image = [UIImage captureWithView:self.view];
    
    
}
- (void)webViewDidReload:(UIWebView *)theWebView; {
  
    
    self.offYIndexInPage = self.webView.offYIndexInPage;
    //self.dictPageWithOffYCount = self.webView.dictPageWithOffYCount;
    _pageStatusLabel.text = [NSString stringWithFormat:@"%@/%d", @(self.offYIndexInPage + 1), [[self.dictPageWithOffYCount valueForKey:[NSString stringWithFormat:@"%@", @(self.pageRefIndex)]] intValue]];
    self.placeHolderImageView.image = [UIImage captureWithView:self.view];

}

- (void)setBackImage:(UIImage *)backImage {
  
   
}

- (void)playWithURL:(NSString *)URL rect:(CGRect)rect placeHolderImage:(UIImage *)placeHolderImage {
    self.playerFatherView.frame = rect;
   
    _playerModel                  = [[ZFPlayerModel alloc] init];
    _playerModel.title            = @"这里设置视频标题";
    _playerModel.videoURL         = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456117847747a_x264.mp4"];
    _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
    _playerModel.fatherView       = self.playerFatherView;
    //[self.playerView resetPlayer];
    [self.playerView autoPlayTheVideo];
    
}


/** 返回按钮事件 */
- (void)zf_playerBackAction {
    [self.playerView resetPlayer];
    
}
/** 下载视频 */
- (void)zf_playerDownload:(NSString *)url {

}
/** 控制层即将显示 */
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {

}
/** 控制层即将隐藏 */
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    
}

#pragma mark 懒加载
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:self.view.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = self.chapterTitle;
        _titleLabel.font = UISYSTEM_FONT(9);
    }
    return _titleLabel;
}

- (UILabel *)timeStatusLabel {
    if (!_timeStatusLabel) {
        _timeStatusLabel = [UILabel new];
    }
    return _timeStatusLabel;
}

- (UILabel *)pageStatusLabel {
    if (!_pageStatusLabel) {
        _pageStatusLabel = [UILabel new];
        _pageStatusLabel.text = [NSString stringWithFormat:@"%@/%d", @(self.offYIndexInPage + 1), [[self.dictPageWithOffYCount valueForKey:[NSString stringWithFormat:@"%@", @(self.pageRefIndex)]] intValue]];
        _pageStatusLabel.font = UISYSTEM_FONT(9);
    }
    return _pageStatusLabel;
}

- (UIImageView *)placeHolderImageView {
    if (!_placeHolderImageView) {
        _placeHolderImageView = [UIImageView new];
    }
    return _placeHolderImageView;
}

- (UIView *)playerFatherView {
    if (!_playerFatherView) {
        _playerFatherView = [UIView new];
    }
    return _playerFatherView;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView new];
        
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        //ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
        //[controlView zf_playerBottomShrinkPlay];
        //[_playerView playerControlView:nil playerModel:self.playerModel];
    
        // 设置代理
        _playerView.delegate = self;
        
        //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
        
        // 打开下载功能（默认没有这个功能）
        //_playerView.hasDownload    = YES;
        
        // 打开预览图
        //self.playerView.hasPreviewView = YES;
        
    }
     [_playerView playerControlView:nil playerModel:self.playerModel];
     _playerView.hasPreviewView = YES;
    return _playerView;
}


- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.alpha = 0.5;
        _backImageView.backgroundColor = self.config.backgroundColor;
    }
    return _backImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
