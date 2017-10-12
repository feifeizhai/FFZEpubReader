//
//  JingGePicReaderViewController.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/14.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGePicReaderViewController.h"
#import "JingGeMacro.h"
#import "UIImageView+WebCache.h"
#import "JingGeNavigationBar.h"


@protocol PicReaderScrollViewDelegate <NSObject, UIScrollViewDelegate>

@optional

- (void)scrollView:(PicReaderScrollView *)scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)scrollView:(PicReaderScrollView *)scrollView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface PicReaderScrollView ()

@property (weak, nonatomic, nullable) id<PicReaderScrollViewDelegate> delegate;

@end

@implementation PicReaderScrollView
@dynamic delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:touchesBegan:withEvent:)]) {
        
        [self.delegate scrollView:self touchesBegan:touches withEvent:event];
    }
    //做你想要的操作
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:touchesEnded:withEvent:)]) {
        [self.delegate scrollView:self touchesBegan:touches withEvent:event];
    }
    
    //做你想要的操作
}

@end

@interface JingGePicReaderViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) PicReaderScrollView  *scrollView;
@property (nonatomic, strong) JingGeNavigationBar *naviBar;
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation JingGePicReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    [self addSubviews];
    [self subviewsLayout];
   // [self addAction];
    // Do any additional setup after loading the view.
}
- (void)addSubviews {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.naviBar];
}

- (void)subviewsLayout {
    [self.scrollView layoutIfNeeded];
    [self.scrollView setNeedsLayout];
    /*
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
    }];
    */
    /*
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.scrollView);
        make.top.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_lessThanOrEqualTo(0);
        make.left.mas_greaterThanOrEqualTo(0);
        make.right.mas_lessThanOrEqualTo(0);
        make.height.mas_equalTo(_imageView.mas_width).multipliedBy(_imageView.frame.size.height / _imageView.frame.size.width);
    }];
    */
    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.leading.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBar_HEIGHT + kStatusBar_HEIGHT);
    }];
    [self.scrollView layoutIfNeeded];
    [self.scrollView setNeedsLayout];
    //_scrollView.contentSize = CGSizeMake(_imageView.frame.size.width, _imageView.frame.size.height);
   
}

- (void)addAction {
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImageView:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    [self.backBtn addTarget:self action:@selector(dismissBack) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)fun1
{
    
    NSLog(@"click1");
}
//双击事件
-(void)fun2
{
    NSLog(@"click2");
}

- (void)scrollView:(PicReaderScrollView *)scrollView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([[touches anyObject] tapCount] == 1) {
        [self performSelector:@selector(dismissBack) withObject:nil afterDelay:0.2];
    }
    else if ([[touches anyObject] tapCount] ==2)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissBack) object:nil];
        [self performSelector:@selector(scaleImageView:) withObject:nil afterDelay:0.01];
    }
}

//单击和双击方法之一
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([[touches anyObject] tapCount] == 1) {
        [self performSelector:@selector(fun1) withObject:nil afterDelay:1];
    }
    else if ([[touches anyObject] tapCount] ==2)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fun1) object:nil];
        [self performSelector:@selector(fun2) withObject:nil afterDelay:1];
    }
}

- (void)scaleImageView:(UITapGestureRecognizer *)tapGesture
{
    CGPoint tapPoint = [tapGesture locationInView:self.scrollView];
    if (self.scrollView.zoomScale > 1.f)
    {
        [self.scrollView setZoomScale:1.f animated:YES];
    }
    else
    {
        [self zoomScrollView:self.scrollView toPoint:tapPoint withScale:2.f animated:YES];
    }
}


- (void)back {
    if (self.navigationController) {
        [self popBack];
    }else {
        [self dismissBack];
    }
}

#pragma mark - UIScrolViewDelegate
- (void)zoomScrollView:(UIScrollView*)view toPoint:(CGPoint)zoomPoint withScale: (CGFloat)scale animated: (BOOL)animated
{
    CGSize contentSize = CGSizeZero;
    
    contentSize.width = (view.contentSize.width / view.zoomScale);
    contentSize.height = (view.contentSize.height / view.zoomScale);
    
    if (view.contentSize.width < view.bounds.size.width)
    {
        zoomPoint.x = (zoomPoint.x / view.bounds.size.width) * contentSize.width;
    }
    else
    {
        zoomPoint.x = (zoomPoint.x / view.contentSize.width) * contentSize.width;
    }
    if (view.contentSize.height < view.bounds.size.height)
    {
        zoomPoint.y = (zoomPoint.y / view.bounds.size.height) * contentSize.height;
    }
    else
    {
        zoomPoint.y = (zoomPoint.y / view.contentSize.height) * contentSize.height;
    }
    
    CGSize zoomSize = CGSizeZero;
    zoomSize.width = view.bounds.size.width / scale;
    zoomSize.height = view.bounds.size.height / scale;
    
    //offset the zoom rect so the actual zoom point is in the middle of the rectangle
    CGRect zoomRect = CGRectZero;
    zoomRect.origin.x = zoomPoint.x - zoomSize.width / 2.0f;
    zoomRect.origin.y = zoomPoint.y - zoomSize.height / 2.0f;
    zoomRect.size.width = zoomSize.width;
    zoomRect.size.height = zoomSize.height;
    
    //apply the resize
    [view zoomToRect: zoomRect animated: animated];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5f : 0.f;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5f : 0.f;
    
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5f + offsetX, scrollView.contentSize.height * 0.5f + offsetY);
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
    NSLog(@"scale is %f",_imageView.frame.size.height);
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
        return NO;
    }
    return YES;
}
#pragma mark 懒加载
- (PicReaderScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[PicReaderScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.zoomScale = 1.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 2.0f;
        _scrollView.backgroundColor = [UIColor blackColor];
        
        //[_scrollView sizeToFit];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        //_imageView.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
       
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:self.image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        
        if (self.imageFilePath) {
            _imageView.image = [UIImage imageWithContentsOfFile:self.imageFilePath];
           
        }
        
        [_imageView sizeToFit];
        CGRect rect = _imageView.frame;
        if (rect.size.width > self.scrollView.frame.size.width) {
            rect.size.width = self.scrollView.frame.size.width;
            rect.size.height = rect.size.height * (rect.size.width / _imageView.frame.size.width);
        }
        _imageView.frame = rect;
        _imageView.center = CGPointMake(self.scrollView.frame.size.width / 2, self.scrollView.frame.size.height / 2);
    
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        //_imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (JingGeNavigationBar *)naviBar {
    if (!_naviBar) {
        _naviBar = [JingGeNavigationBar new];
        _naviBar.backItem = self.backBtn;
        _naviBar.backgroundColor = self.naviColor;
    }
    return _naviBar;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:self.backItemImage forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
