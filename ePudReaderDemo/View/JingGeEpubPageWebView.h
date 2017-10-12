//
//  JingGeEpubPageWebView.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JingGeEpubReaderConfig;
@interface UIWebView (SearchWebView)

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;
- (void)removeAllHighlights;

- (NSInteger)underlineAllOccurencesOfString:(NSString*)str;
@end

@protocol JingGeEpubPageWebViewDelegate <NSObject>

@optional

- (void)webViewDidFinishLoad:(UIWebView *)theWebView;
- (void)webViewDidReload:(UIWebView *)theWebView;

@end

@interface JingGeEpubPageWebView : UIWebView
@property (strong, nonatomic) JingGeEpubReaderConfig *config;
@property (nonatomic) NSInteger pageRefIndex;    //当前页码索引
@property (nonatomic) NSInteger offYIndexInPage; //页码内 滚动索引
@property (strong, nonatomic) NSMutableDictionary *dictPageWithOffYCount;    //记录 ［页码，滚动次数］
@property (weak, nonatomic) id<JingGeEpubPageWebViewDelegate> epubDelegate;
@property (nonatomic, strong) NSString *fragmentID;
- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;
- (void)removeAllHighlights;

- (NSInteger)underlineAllOccurencesOfString:(NSString*)str;

- (void)gotoOffYInPageWithOffYIndex:(NSInteger)offyIndex WithOffCountInPage:(NSInteger)offCountInPage;

- (void)reloadWebView;

- (NSString *)js:(NSString *)script;
@end
