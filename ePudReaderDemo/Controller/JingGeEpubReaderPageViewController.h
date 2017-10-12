//
//  JingGeEpubReaderPageViewController.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <JingGe_Common/JingGe_Common.h>

typedef enum : NSUInteger {
    EpubReaderTapLeft,
    EpubReaderTapRight,
    EpubReaderTapCenter,
} EpubReaderTapLocation;

@class JingGeEpubParser, JingGeEpubReaderPageViewController, JingGeEpubReaderConfig, JingGeEpubPageWebView;

@protocol JingGeEpubReaderPageViewControllerDelegate <NSObject>

@optional
- (void)webViewDidFinishLoad:(UIWebView *)theWebView;
@end

@interface JingGeEpubReaderPageViewController : JingGeBaseViewController

@property (assign, nonatomic) CGSize contentSize;
@property (nonatomic,strong) NSString *jsContent;
@property (strong, nonatomic) NSString *pageURL;
@property (strong, nonatomic) JingGeEpubParser *epubParser;
@property (nonatomic) NSInteger pageRefIndex;    //当前页码索引
@property (nonatomic) NSInteger offYIndexInPage; //页码内 滚动索引
@property (strong, nonatomic) NSMutableDictionary *dictPageWithOffYCount;    //记录 ［页码，滚动次数］
@property (assign, nonatomic) id<JingGeEpubReaderPageViewControllerDelegate> delegate;
@property (strong, nonatomic) JingGeEpubReaderConfig *config;
@property (strong, nonatomic) JingGeEpubPageWebView *webView;
@property (strong, nonatomic) NSString *chapterTitle;
@property (nonatomic, strong) NSString *fragmentID;
@property (strong, nonatomic) UIImageView *backImageView; //背面图片

- (void)captureWithView;

- (void)playWithURL:(NSString *)URL rect:(CGRect)rect placeHolderImage:(UIImage *)placeHolderImage;

@end
