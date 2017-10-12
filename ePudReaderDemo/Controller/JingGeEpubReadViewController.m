//
//  JingGeEpubReaderViewController.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReadViewController.h"
#import "JingGeEpubReaderPageViewController.h"
#import "JingGeEpubReaderModel.h"
#import "JingGeEpubParser.h"
#import "JingGeEpubReaderControlView.h"
#import "JingGeEpubReaderConfig.h"
#import "JingGeEpubReadCatalogViewController.h"
#import <JingGePicReaderViewController.h>
#import <UIViewController+JingGeTransition.h>
#import "PlayerViewController.h"
#import "JingGeEpubPageWebView.h"
#import <MBProgressHUD.h>

#define kContentSize  CGSizeMake(kScreenWidth - kDefaultSpace * 4, kScreenHeight - kDefaultSpace * 12)
#define kBrightness @"brightness"

@interface JingGeEpubReadViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIGestureRecognizerDelegate, JingGeEpubReaderPageViewControllerDelegate, JingGeEpubReaderControlViewDelegate, JingGeEpubReadCatalogViewControllerDelegate, JingGeEpubPageWebViewDelegate>

@property (strong, nonatomic) JingGeEpubReaderModel *readerModel;
@property (strong, nonatomic) JingGeEpubParser *epubParser;
@property (nonatomic, strong) NSString *jsContent;            //js脚本
@property (nonatomic, strong) UIPageViewController * pageViewController;
@property (strong, nonatomic) JingGeEpubReaderControlView *controlView;
@property (strong, nonatomic) JingGeEpubReaderConfig *config;
@property (nonatomic) NSInteger pageRefIndex;    //当前页码索引
@property (nonatomic) NSInteger offYIndexInPage; //页码内 滚动索引
@property (strong, nonatomic) NSMutableDictionary *dictPageWithOffYCount;    //记录 ［页码，滚动次数］
@property int fontSelectIndex;
@property (strong, nonatomic) JingGeEpubPageWebView *webView;                //当前展示
@property (strong, nonatomic) JingGeEpubPageWebView *lastWebView;            //上个展示
@property (strong, nonatomic) JingGeEpubPageWebView *nextWebView;            //下个展示
@property (nonatomic, strong) NSMutableArray *epubCatalogs;  //epub目录信息
@property (nonatomic, strong) NSMutableArray *epubPageItems; //epub页码信息
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *fragmentID;
@property (assign, nonatomic) BOOL tempNumber;
@property (strong, nonatomic) UIImage *backImage;
@end

@implementation JingGeEpubReadViewController

- (void)dealloc {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
    _webView.delegate = nil;
    _nextWebView.delegate = nil;
    _lastWebView.delegate = nil;
    //_webView.epubDelegate = nil;
    //_nextWebView.epubDelegate = nil;
    //_nextWebView.epubDelegate = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    [_nextWebView loadHTMLString:@"" baseURL:nil];
    [_nextWebView stopLoading];
    [_nextWebView removeFromSuperview];
    [_lastWebView loadHTMLString:@"" baseURL:nil];
    [_lastWebView stopLoading];
    [_lastWebView removeFromSuperview];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    [self.webView removeFromSuperview];
    self.webView = nil;
    [self.lastWebView removeFromSuperview];
    self.lastWebView = nil;
    
    [self.lastWebView removeFromSuperview];
    self.lastWebView = nil;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //[[UIScreen mainScreen] setBrightness:[GET_USERDEFAULT_VALUE(kBrightness) floatValue]];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
   [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    SET_USERDEFAULT_VALUE([NSNumber numberWithFloat:[UIScreen mainScreen].brightness], kBrightness);
    
    self.config = [[[JingGeSQLWork shareJingGeSQL] searchDBWithModelClass:[JingGeEpubReaderConfig class] where:nil orderBy:nil offset:0 count:0] firstObject];
   
    //[[UIScreen mainScreen] setBrightness:self.config.lightNum];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tempNumber = 1;
   
    self.readerModel = [self.epubParser parserWithFilePath:self.fileFullPath];
    [self addGestureRecognizer];
    [self gotoPageWithPageRefIndex:[self.readerModel.pageRefIndex intValue] WithOffYIndexInPage:[self.readerModel.offYIndexInPage intValue]];
}


- (void)addGestureRecognizer {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
    
}


#define 手势方法
-(void)doTap:(UITapGestureRecognizer*)recognizer
{
    //轻击
    if (recognizer.numberOfTouchesRequired == 1 && recognizer.numberOfTapsRequired == 1) {
        
        [self singleTaped:recognizer];
        
    } else if(recognizer.numberOfTouchesRequired == 1 && recognizer.numberOfTapsRequired == 2) {
        
       // [self doubleTaped:recognizer];
        
    }
}

- (void)singleTaped:(UITapGestureRecognizer *)recognizer
{
    //[self singleTapInPageVC:nil location:EpubReaderTapRight];
    
    //单击
    
    //手指坐标
    if (recognizer.state == UIGestureRecognizerStateRecognized)
    {
        CGPoint ptLocation=[recognizer locationInView:self.view];
        ptLocation.x = ptLocation.x - self.webView.frame.origin.x;
        ptLocation.y = ptLocation.y - self.webView.frame.origin.y;
        
        if ([self getContentFromPoint:ptLocation]) {
            return;
        };
        
        CGRect viewRect=self.webView.bounds;
        CGFloat fBoundary=viewRect.size.width / 4.0;
        
        if (ptLocation.x >= fBoundary && ptLocation.x <= viewRect.size.width - fBoundary + self.webView.frame.origin.x * 2)
        {
           // if (self.delegate && [self.delegate respondsToSelector:@selector(singleTapInPageVC:location:)]) {
                [self singleTapInPageVC:nil location:EpubReaderTapCenter];
           // }
        }
    }
    
}

-(BOOL)getContentFromPoint:(CGPoint)pt1
{
    //得到 webview点击位置的内容
    CGPoint pt =pt1;
    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", pt.x, pt.y];
    
    NSString * tagName = [self.webView stringByEvaluatingJavaScriptFromString:js];
    //NSLog(@"tagName=%@, pt=%@",tagName,NSStringFromCGPoint(pt));
    
    if ([[tagName uppercaseString] isEqualToString:@"IMG"]) {
        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
        
        NSString *fileURLString = [self.webView stringByEvaluatingJavaScriptFromString:imgURL];
        
        NSString *fileFullPath=[fileURLString  stringByReplacingOccurrencesOfString:@"file://" withString:@"" ];
        
        NSString *fileFullPath2=[fileFullPath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //ok 解决中文路径
        
        NSString *type = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.elementFromPoint(%f, %f).getAttribute('type')", pt.x, pt.y]];
  
        NSString *resourcekey = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.elementFromPoint(%f, %f).getAttribute('resourcekey')", pt.x, pt.y]];
        
        NSString *str = [self.webView js:[NSString stringWithFormat:@"getPositionByLocation(%f,%f)", pt.x, pt.y]];
        CGRect rect = CGRectFromString(str);
        rect.origin.x = rect.origin.x + self.webView.frame.origin.x;
        rect.origin.y = rect.origin.y + self.webView.frame.origin.y;
        if ([type isEqualToString:@"video"]) {
            
            
            [self playVideoWithURL:resourcekey rect:rect placeHolderImage:[[UIImage alloc] initWithContentsOfFile:fileFullPath2]];
            
            return YES;
            
        } else if ([type isEqualToString:@"image"]) {
            
            if ([JingGeDataManager isFileExist:fileFullPath2]) {
                UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:fileFullPath2]];
                //imageView.contentMode = UIViewContentModeScaleAspectFit;
                //imageView.backgroundColor = [UIColor blueColor];
                imageView.frame = rect;
                //[self doubleTapInPageVC:nil filePath:fileFullPath2];
                [self previewWithImage:imageView filePath:fileFullPath2];
            }
            
            return YES;

        }
        
    }
    
    return NO;
}

#pragma mark gestureRecognizerdelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[JingGeEpubReaderControlView class]] || [NSStringFromClass([touch.view.superview superclass]) isEqualToString:@"UICollectionViewCell"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UIBarButtonItem"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeNavigationBar"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITabBarButton"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITabBar"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeEpubReaderControlSettingView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeEpubReaderProgressView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UISlider"] || [NSStringFromClass([touch.view class]) isEqualToString:@"JinggeBottomBar"] || [NSStringFromClass([[touch.view superview] superclass]) isEqualToString:@"UICollectionViewCell"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionView"]|| [NSStringFromClass([touch.view class]) isEqualToString:@"JingGeFontSettingView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableView"]) {
        //|| [NSStringFromClass([touch.view.superview.superview class]) isEqualToString:@"_UIPageViewControllerContentView"]
        return NO;
    }
    
    return YES;
}

#pragma mark uipageVC datasourse

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    JingGeEpubReaderPageViewController *pageCurVC=(JingGeEpubReaderPageViewController*)viewController;
    viewController.view.backgroundColor = self.config.backgroundColor;
    NSInteger offYIndexInPage = pageCurVC.offYIndexInPage;
    NSInteger pageRefIndex = pageCurVC.pageRefIndex;
    if (offYIndexInPage <= 0) {
        pageRefIndex = pageRefIndex - 1;
        if (pageRefIndex < 0){
            pageRefIndex= 0;
            return nil;
        }
    }else {}
    NSInteger offYIndexInPageCount = [[self.dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(pageRefIndex)]] integerValue];
    if(pageCurVC.webView) { // 背面
        JingGeEpubReaderPageViewController *pageEpubVC = [[JingGeEpubReaderPageViewController alloc]initWithControllerGoBack:^(id sender) {}];
        pageEpubVC.offYIndexInPage = pageCurVC.offYIndexInPage;
        pageEpubVC.pageRefIndex = pageCurVC.pageRefIndex;
        self.tempNumber = YES;
        return pageEpubVC;
    }else { // 内容
        if (offYIndexInPage > 0) {
            offYIndexInPage -= 1;
            self.offYIndexInPage = offYIndexInPage;
            self.pageRefIndex = pageRefIndex;
        }else {
            self.offYIndexInPage = offYIndexInPageCount - 1;
            self.pageRefIndex = pageRefIndex;
        }
        self.fragmentID = @"";
        self.readerModel.offYIndexInPage = [NSNumber numberWithInteger:self.offYIndexInPage];
        self.readerModel.pageRefIndex = [NSNumber numberWithInteger:self.pageRefIndex];
        [[JingGeSQLWork shareJingGeSQL] updateDBWithModel:self.readerModel where:[NSString stringWithFormat:@"fileName = %@", self.readerModel.fileName]];
        JingGeEpubReaderPageViewController *pageEpubVC = [self pageEpubVC];
        self.tempNumber = NO;

        return pageEpubVC;

    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    JingGeEpubReaderPageViewController *pageCurVC=(JingGeEpubReaderPageViewController*)viewController;
    NSInteger offYIndexInPage = pageCurVC.offYIndexInPage;
    NSInteger pageRefIndex = pageCurVC.pageRefIndex;
    NSInteger offYIndexInPageCount = [[self.dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(pageRefIndex)]] integerValue];
    if (offYIndexInPage < offYIndexInPageCount - 1) {
        
    }else {
        if (pageRefIndex < self.readerModel.epubPageRefs.count - 1) {
            
        }else {
            return nil;
        }
    }
    if(pageCurVC.webView) { // 背面
        JingGeEpubReaderPageViewController *pageEpubVC = [[JingGeEpubReaderPageViewController alloc]initWithControllerGoBack:^(id sender) {}];
        pageEpubVC.offYIndexInPage = pageCurVC.offYIndexInPage;
        pageEpubVC.pageRefIndex = pageCurVC.pageRefIndex;
        pageEpubVC.view.backgroundColor = self.config.backgroundColor;
        pageEpubVC.backImageView.image = [UIImage captureBackView:pageCurVC.view];
        self.tempNumber = YES;
        return pageEpubVC;
    }else {

        if (offYIndexInPage < offYIndexInPageCount - 1) {
            offYIndexInPage += 1;
            self.offYIndexInPage = offYIndexInPage;
            self.pageRefIndex = pageRefIndex;
        }else {
            if (self.pageRefIndex < self.readerModel.epubPageRefs.count-1) {
                self.pageRefIndex = pageRefIndex + 1;} else {return nil;}
            
            self.offYIndexInPage = 0;
        }
        self.fragmentID = @"";
        self.readerModel.offYIndexInPage = [NSNumber numberWithInteger:self.offYIndexInPage];
        self.readerModel.pageRefIndex = [NSNumber numberWithInteger:self.pageRefIndex];
        [[JingGeSQLWork shareJingGeSQL] updateDBWithModel:self.readerModel where:[NSString stringWithFormat:@"fileName = %@", self.readerModel.fileName]];
        JingGeEpubReaderPageViewController *pageEpubVC = [self pageEpubVC];
        self.tempNumber = NO;
        return pageEpubVC;
    }
    
}

#pragma mark uipageVC delegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    // 将要开始动画的时候关闭视图的交互性
    //pageViewController.view.userInteractionEnabled = NO;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    //动画结束后打开交互
    if (finished) {
       // UIViewController *vc = pageViewController.viewControllers.firstObject;
       // self.backImage = [UIImage captureBackView:vc.view];
    }
}

#pragma mark jinggePageVC delegate

- (void)singleTapInPageVC:(JingGeEpubReaderPageViewController *)pageVC location:(EpubReaderTapLocation)location {
   // kWeakSelf(ws);
    if (location == EpubReaderTapCenter) {
        [self.controlView showControlWithView:self.view];
    }
}

- (void)previewWithImage:(UIImageView *)image filePath:(NSString *)filePath {
   
    JingGePicReaderViewController *picReaderVC = [[JingGePicReaderViewController alloc] init];
    //picReaderVC.view.backgroundColor = UIColorFromHex(0x000000);
   // picReaderVC.backItemImage = kGetImage(@"btn_defaukt_back");
    
    picReaderVC.imageFilePath = filePath;
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    picReaderVC.image = img;

    __weak JingGePicReaderViewController *weakVC = picReaderVC;
    /*
    [self.navigationController JingGe_pushViewController:picReaderVC makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationTime = 0.5;
        //transition.animationType = JingGeTransitionAnimationTypeSysFade;
        transition.animationType = JingGeTransitionAnimationTypeViewMoveNormalToNextVC;
        transition.startView = image;
        transition.targetView = weakVC.imageView;
    }];
 */
    //picReaderVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self JingGe_presentViewController:picReaderVC makeTransition:^(JingGeTransitionProperty *transition) {
        transition.animationTime = 0.25;
        //transition.animationType = JingGeTransitionAnimationTypeSysFade;
        transition.animationType = JingGeTransitionAnimationTypeViewMoveNormalToNextVC;
        transition.startView = image;
        transition.targetView = weakVC.imageView;
    }];
    
}

- (void)playVideoWithURL:(NSString *)URL rect:(CGRect)rect placeHolderImage:(UIImage *)image{
    JingGeEpubReaderPageViewController *vc = [self.pageViewController.viewControllers firstObject];
    [vc playWithURL:URL rect:rect placeHolderImage:image];
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView {
    
    [self hidHUD];

}



#pragma mark catalogVC delegate
- (void)catalogVC:(JingGeEpubReadCatalogViewController *)catalogVC didSelectAtModel:(JingGeEpubReaderCatalogModel *)model {
    
    NSInteger pageRefIndex=[self pageRefIndexWithCatalogItem:model];
    self.fragmentID = model.fragmentID;
    [self gotoPageWithPageRefIndex:pageRefIndex WithOffYIndexInPage:0];
    
}
#pragma mark JingGeEpubReaderControlViewDelegate

- (void)backItemAction:(JingGeEpubReaderControlView *)controlView {
    [self popBack];
}

- (void)catalogItemAction:(JingGeEpubReaderControlView *)controlView {
 
    JingGeEpubReadCatalogViewController *catalogVC = [[JingGeEpubReadCatalogViewController alloc]initWithControllerGoBack:^(id sender) {
        //[ws gotoPageWithPageRefIndex:((JingGeEpubReadCatalogViewController *)sender).pageRefIndex WithOffYIndexInPage:0];
    }];
    
    catalogVC.delegate = self;
    
    catalogVC.dataArray = [self.epubCatalogs mutableCopy];
    
    [self presentViewController:catalogVC animated:YES completion:^{
        
    }];
}

- (void)settingViewChange:(JingGeEpubReaderControlView *)controlView sholdReload:(BOOL)sholdReload{
    
    JingGeEpubReaderPageViewController *pageVC = [self.pageViewController.viewControllers firstObject];
    [_webView reloadWebView];
    [_lastWebView reloadWebView];
    [_nextWebView reloadWebView];
    pageVC.view.backgroundColor = self.config.backgroundColor;
    self.controlView.config = self.config;
    [pageVC captureWithView];
    
    [[JingGeSQLWork shareJingGeSQL] updateDBWithModel:self.config where:nil];
    
}

#pragma mark
-(void)gotoPageWithPageRefIndex:(NSInteger)pageRefIndex WithOffYIndexInPage:(NSInteger)offYIndexInPage {
    _webView = nil;
    _nextWebView = nil;
    _lastWebView = nil;
    //跳转页码
    self.pageRefIndex = pageRefIndex;
    self.offYIndexInPage = offYIndexInPage;
   
    if (_pageViewController) {
        [_pageViewController.view removeFromSuperview];
        [_pageViewController removeFromParentViewController];

        self.jsContent = nil;
        self.pageViewController = nil;
    }
    [self showPageViewController];
}

-(void)showPageViewController {
    
    [self addChildViewController:self.pageViewController];
    
}

- (void)lastWebViewLoadHtml:(NSInteger)pageRefIndex {
    JingGeEpubPageWebView *lastWeb = [self creatWebView];
    lastWeb.pageRefIndex = (pageRefIndex - 1);
    NSString *pageURL = [self pageURLWithPageRefIndex:pageRefIndex - 1];
    if (!pageURL) {
        pageURL =  @"";
    }
    NSString *htmlContent = [self.epubParser HTMLContentFromFile:pageURL AddJsContent:self.jsContent];
    NSURL* baseURL = [NSURL fileURLWithPath:pageURL];
    [lastWeb loadHTMLString:htmlContent baseURL:baseURL];
    self.lastWebView = lastWeb;
}

- (void)nextWebViewLoadHtml:(NSInteger)pageRefIndex {
    JingGeEpubPageWebView *nextWeb = [self creatWebView];
    nextWeb.pageRefIndex = pageRefIndex + 1;
    NSString *pageURL = [self pageURLWithPageRefIndex:pageRefIndex + 1];
    if (!pageURL) {
        pageURL =  @"";
    }
    NSString *htmlContent = [self.epubParser HTMLContentFromFile:pageURL AddJsContent:self.jsContent];
    NSURL* baseURL = [NSURL fileURLWithPath:pageURL];
    
    [nextWeb loadHTMLString:htmlContent baseURL:baseURL];
    self.nextWebView = nextWeb;
}


#pragma mark 赋值
- (void)setReaderModel:(JingGeEpubReaderModel *)readerModel {
    _readerModel = readerModel;
    for (NSDictionary *catalogDic in readerModel.epubCatalogs) {
        JingGeEpubReaderCatalogModel *catalogModel = [[JingGeEpubReaderCatalogModel alloc]initWithDictionary:catalogDic];
        [self.epubCatalogs addObject:catalogModel];
    }
    for (NSDictionary *itemDic in readerModel.epubPageItems) {
        JingGeEpubReaderItemModel *itemModel = [[JingGeEpubReaderItemModel alloc]initWithDictionary:itemDic];
        [self.epubPageItems addObject:itemModel];
    }
    
    self.pageRefIndex = [readerModel.pageRefIndex integerValue];
    self.offYIndexInPage = [readerModel.offYIndexInPage integerValue];
}

- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)setPageRefIndex:(NSInteger)pageRefIndex {
 
    if (!_webView) {
        
        NSString *pageURL = [self pageURLWithPageRefIndex:pageRefIndex];
        if (!pageURL) {
            pageURL =  @"";
        }
        NSString *htmlContent = [self.epubParser HTMLContentFromFile:pageURL AddJsContent:self.jsContent];
        NSURL* baseURL = [NSURL fileURLWithPath:pageURL];
        self.webView.pageRefIndex = pageRefIndex;
        [self.webView loadHTMLString:htmlContent baseURL:baseURL];
        [self lastWebViewLoadHtml:pageRefIndex];
        [self nextWebViewLoadHtml:pageRefIndex];
        [self showHUD];
        
    }else {
        if (_pageRefIndex > pageRefIndex) {
                
            self.nextWebView = self.webView;
            self.webView = self.lastWebView;
            [self lastWebViewLoadHtml:pageRefIndex];
                
        }else if (_pageRefIndex < pageRefIndex) {
                
            self.lastWebView = self.webView;
            self.webView = self.nextWebView;
            [self nextWebViewLoadHtml:pageRefIndex];
                
        }
    }
    _pageRefIndex = pageRefIndex;
    NSLog(@"last = %d, current = %d, next  =%d", self.lastWebView.pageRefIndex, self.webView.pageRefIndex, self.nextWebView.pageRefIndex);
}

- (void)showHUD{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)hidHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark 懒加载

- (NSMutableArray *)epubCatalogs {
    if (!_epubCatalogs) {
        _epubCatalogs = [NSMutableArray array];
    }
    return _epubCatalogs;
}

- (NSMutableArray *)epubPageItems {
    if (!_epubPageItems) {
        _epubPageItems = [NSMutableArray array];
    }
    return _epubPageItems;
}

- (JingGeEpubReaderConfig *)config {
    if (!_config) {
        _config = [[[JingGeSQLWork shareJingGeSQL] searchDBWithModelClass:[JingGeEpubReaderConfig class] where:nil orderBy:nil offset:0 count:0] firstObject];
        if (!_config) {
            _config = [JingGeEpubReaderConfig new];
            [[JingGeSQLWork shareJingGeSQL] insertDBWithModel:_config];
        }
    }
    return _config;
}

- (JingGeEpubPageWebView *)webView {
    if (!_webView) {
       
        _webView = [[JingGeEpubPageWebView alloc] initWithFrame: CGRectMake(kDefaultSpace * 2, kDefaultSpace * 7, kContentSize.width, kContentSize.height)];;
        _webView.backgroundColor=[UIColor clearColor];
        _webView.opaque = NO;
        _webView.config = self.config;
        _webView.dictPageWithOffYCount = self.dictPageWithOffYCount;
        //_webView.paginationMode = UIWebPaginationModeLeftToRight;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.userInteractionEnabled = NO;
       
    }
    return _webView;
}

- (JingGeEpubPageWebView *)creatWebView {
  
    JingGeEpubPageWebView * webView = [[JingGeEpubPageWebView alloc] initWithFrame: CGRectMake(kDefaultSpace * 2, kDefaultSpace * 7, kContentSize.width, kContentSize.height)];
    webView.backgroundColor=[UIColor clearColor];
    webView.opaque = NO;
    webView.config = self.config;
    //webView.paginationMode = UIWebPaginationModeLeftToRight;
    webView.dictPageWithOffYCount = self.dictPageWithOffYCount;
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    webView.epubDelegate = self;
    webView.userInteractionEnabled = NO;
    return webView;
}


- (JingGeEpubParser *)epubParser {
    if (!_epubParser) {
        _epubParser = [JingGeEpubParser new];
    }
    return _epubParser;
}

- (NSString *)jsContent {
    if (!_jsContent) {
        _jsContent = [self jsContentWithViewRect:CGRectMake(0, 0, kContentSize.width, kContentSize.height)];
    }
    return _jsContent;
}


- (JingGeEpubReaderPageViewController *)pageEpubVC {
    JingGeEpubReaderPageViewController *pageEpubVC = [[JingGeEpubReaderPageViewController alloc]initWithControllerGoBack:^(id sender) {
        
    }];
    pageEpubVC.offYIndexInPage = self.offYIndexInPage;
    pageEpubVC.pageRefIndex = self.pageRefIndex;
    pageEpubVC.jsContent = self.jsContent;
    pageEpubVC.pageURL = [self pageURLWithPageRefIndex:self.pageRefIndex];
    pageEpubVC.epubParser = self.epubParser;
    pageEpubVC.contentSize = kContentSize;
    pageEpubVC.dictPageWithOffYCount = self.dictPageWithOffYCount;
    pageEpubVC.delegate = self;
    pageEpubVC.config = self.config;
    pageEpubVC.webView = self.webView;
    pageEpubVC.fragmentID = self.fragmentID;
    pageEpubVC.chapterTitle = [self titleWithPage:self.pageRefIndex];
   
    //self.webView.pageRefIndex = self.pageRefIndex;
    //self.webView.offYIndexInPage = self.offYIndexInPage;
    return pageEpubVC;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        
        NSDictionary *options = [NSDictionary dictionaryWithObject: [NSNumber numberWithInteger: UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        for (UIGestureRecognizer *ges in self.pageViewController.gestureRecognizers) {
            if ([ges isKindOfClass:[UITapGestureRecognizer class]]) {
                //ges.delegate = self;
            }
        }
        _pageViewController.doubleSided = YES;
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        [self.view sendSubviewToBack:_pageViewController.view];
        [_pageViewController setViewControllers:@[[self pageEpubVC]] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
        [_pageViewController didMoveToParentViewController:self];
        _pageViewController.view.backgroundColor = [UIColor clearColor];

    }
    return _pageViewController;
}

- (JingGeEpubReaderControlView *)controlView {
    if (!_controlView) {
        _controlView = [JingGeEpubReaderControlView new];
        _controlView.delegate = self;
        _controlView.config = self.config;
    }
    return _controlView;
}

- (NSMutableDictionary *)dictPageWithOffYCount {
    if (!_dictPageWithOffYCount) {
        _dictPageWithOffYCount = [NSMutableDictionary dictionary];
    }
    return _dictPageWithOffYCount;
}



-(NSInteger)pageRefIndexWithCatalogItem:(JingGeEpubReaderCatalogModel *)itemCatalog
{
    //根据目录，返回对应的 pageRef
    for (int i=0 ; i< [self.readerModel.epubPageItems count]; i ++) {
        JingGeEpubReaderItemModel *itemModel = self.epubPageItems[i];
        if ([itemCatalog.href isEqualToString:itemModel.href])
        {
            if ([self.readerModel.epubPageRefs containsObject:itemModel.ID]) {
                for (int index = 0; index < self.readerModel.epubPageRefs.count; index ++) {
                    if ([itemModel.ID isEqualToString:self.readerModel.epubPageRefs[index]]) {
                        return index;
                    }
                }
            }
        }
    }
    return 0;
}

- (NSString *)titleWithPage:(NSInteger)page {
    NSString *ID = [self.readerModel.epubPageRefs objectAtIndex:page];
    for (int i=0 ; i< [self.epubPageItems count]; i ++) {
        JingGeEpubReaderItemModel *itemModel = self.epubPageItems[i];
        if ([itemModel.ID isEqualToString:ID]) {
            for (JingGeEpubReaderCatalogModel *catalogModel in self.epubCatalogs) {
                if ([itemModel.href isEqualToString:catalogModel.href]) {
                    return catalogModel.text;
                }
            }
        }
    }
    return @"";
}


-(NSMutableDictionary*)catalogWithPageRef:(NSInteger)pageRefIndex
{
    //根据 pageRef  返回对应的 目录信息
    
    NSString *pageRef=[self.readerModel.epubPageRefs objectAtIndex:pageRefIndex];
    for (NSMutableDictionary *catalog1 in self.readerModel.epubCatalogs) {
        
        NSString *itemID=catalog1[@"id"];
        //NSString *itemhref=item1[@"src"];
        
        if ([itemID isEqualToString:pageRef]) {
            return catalog1;
        }
    }
    return nil;
}


-(JingGeEpubReaderItemModel *)pageItemWithPageRef:(NSString*)pageRef
{
    
    //根据 pageRef  返回对应的 pageItem
    for (JingGeEpubReaderItemModel *itemModel in self.epubPageItems) {
        
        NSString *itemID=itemModel.ID;
        //NSString *itemhref=item1[@"href"];
        if ([itemID isEqualToString:pageRef]) {
            return itemModel;
        }
    }
    return nil;
}

-(NSString*)pageURLWithPageRefIndex:(NSInteger)pageRefIndex
{
    //得到当前页码索引的路径
    if (pageRefIndex <0 || pageRefIndex >= [self.readerModel.epubPageRefs count]) {
        return nil;
    }
    NSString *pageRef=[self.readerModel.epubPageRefs objectAtIndex:pageRefIndex];
    ///NSLog(@"%@", self.readerModel.epubPageRefs);
    JingGeEpubReaderItemModel *itemModel = [self pageItemWithPageRef:pageRef];
    if (itemModel) {
        
        NSString *href=itemModel.href;
        
        NSString *pageURL=[NSString stringWithFormat:@"%@/%@",[JingGeDataManager parentFolderWithFilePath:self.readerModel.opfFilePath],href];
        if ([JingGeDataManager isFileExist:pageURL]) {
            //  NSLog(@"%@", pageURL);
            return pageURL;
        }
    }
    return nil;
}

-(NSString*)jsFontStyle:(NSString*)fontFilePath
{
    //注意 fontName, DFPShaoNvW5.ttf 如果改为 aa.ttf, 那么fontname也应该是“DFPShaoNvW5”，
    //fontName是系统认的名称,非文件名， 我这里把文件名改了，参考本文件的 customFontWithPath 方法得到真正的fontName
    
    NSString *fontFile=[fontFilePath lastPathComponent];
    NSString *fontName=[fontFile stringByDeletingPathExtension];
    //NSString *jsFont=@"<style type=\"text/css\"> @font-face{ font-family: 'DFPShaoNvW5'; src: url('DFPShaoNvW5-GB.ttf'); } </style> ";
    NSString *jsFontStyle=[NSString stringWithFormat:@"<style type=\"text/css\"> @font-face{ font-family: '%@'; src: url('%@'); } </style>",fontName,fontFile];
    
    return jsFontStyle;
}

-(NSString*)jsContentWithViewRect:(CGRect)rectView {
    
    NSString *js0 = @"";
    NSString *js1 = @"<style>img {  max-width:100%; }</style>\n";
    NSMutableArray *arrJs=[NSMutableArray array];
    [arrJs addObject:@"<script>"];
    [arrJs addObject:@"var mySheet = document.styleSheets[0];"];
    [arrJs addObject:@"function addCSSRule(selector, newRule){"];
    [arrJs addObject:@"if (mySheet.addRule){"];
    [arrJs addObject:@"mySheet.addRule(selector, newRule);"];
    [arrJs addObject:@"} else {"];
    [arrJs addObject:@"ruleIndex = mySheet.cssRules.length;"];
    [arrJs addObject:@"mySheet.insertRule(selector + '{' + newRule + ';}', ruleIndex);"];
    [arrJs addObject:@"}"];
    [arrJs addObject:@"}"];
    
    [arrJs addObject:@"addCSSRule('p', 'text-align: justify;');"];
    [arrJs addObject:@"addCSSRule('highlight', 'background-color: yellow;');"];
    [arrJs addObject:[NSString stringWithFormat:@"addCSSRule('highlight', 'background-color: %@;')",[JingGeDataManager toStrByUIColor:self.config.textColor]]];
    {
        NSString *css1=[NSString stringWithFormat:@"addCSSRule('body', ' font-size:%@px;');",@(self.config.textSize)];
        [arrJs addObject:css1];
    }
    {
        
        NSString *fontName= [[self.config.fontArray objectAtIndex:self.fontSelectIndex] objectForKey:@"fontName"];
        NSString *css1=[NSString stringWithFormat:@"addCSSRule('body', ' font-family:\"%@\";');",fontName];
        
        [arrJs addObject:css1];
    }
    
    //[arrJs addObject:@"addCSSRule('body', ' margin:2.2em 5%% 0 5%%;');"]; //上，右，下，左 顺时针
    [arrJs addObject:@"addCSSRule('body', ' margin:0 0 0 0;');"];
    {
        //[arrJs addObject:@"addCSSRule('html', 'padding: 0px; height: 480px; -webkit-column-gap: 0px; -webkit-column-width: 320px;');"];
        NSString *css1=[NSString stringWithFormat:@"addCSSRule('html', 'padding: 0px; height: %@px; -webkit-column-gap: 0px; -webkit-column-width: %@px;');",@(rectView.size.height),@(rectView.size.width)];
        [arrJs addObject:css1];
    }
    
    [arrJs addObject:@"</script>"];
    
    NSString *jsJoin=[arrJs componentsJoinedByString:@"\n"];
    
    //NSString *jsRet=[NSString stringWithFormat:@"%@\n%@",js1,jsJoin];
    NSString *jsRet=[NSString stringWithFormat:@"%@\n%@\n%@",js0,js1,jsJoin];
    return jsRet;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
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
