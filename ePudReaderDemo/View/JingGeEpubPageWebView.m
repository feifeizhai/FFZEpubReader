//
//  JingGeEpubPageWebView.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubPageWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <JingGeDataManager.h>
#import <JingGeMacro.h>
#import "JingGeEpubReaderConfig.h"



@implementation UIWebView (SearchWebView)

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self stringByEvaluatingJavaScriptFromString:jsCode];
    
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@');",str];
    [self stringByEvaluatingJavaScriptFromString:startSearch];
    
    //    NSLog(@"%@", [self stringByEvaluatingJavaScriptFromString:@"console"]);
    return [[self stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount;"] intValue];
}

- (void)removeAllHighlights {
    [self stringByEvaluatingJavaScriptFromString:@"MyApp_RemoveAllHighlights()"];
}
/////////////////////////////////////

- (NSInteger)underlineAllOccurencesOfString:(NSString*)str
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self stringByEvaluatingJavaScriptFromString:jsCode];
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_UnderlineAllOccurencesOfString('%@');",str];
    [self stringByEvaluatingJavaScriptFromString:startSearch];
    
    //    NSLog(@"%@", [self stringByEvaluatingJavaScriptFromString:@"console"]);
    return [[self stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount;"] intValue];
}

@end

@interface JingGeEpubPageWebView ()<UIWebViewDelegate>

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation JingGeEpubPageWebView

- (void)dealloc {
   
    [self.timer invalidate];
    self.epubDelegate = nil;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Bridge" ofType:@"js"];
        NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        [self stringByEvaluatingJavaScriptFromString:jsCode];
    }
    return self;
}

#pragma mark - highlight
- (NSInteger)highlightAllOccurencesOfString:(NSString*)str {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self stringByEvaluatingJavaScriptFromString:jsCode];
    
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@');",str];
    [self stringByEvaluatingJavaScriptFromString:startSearch];
    
    //    NSLog(@"%@", [self stringByEvaluatingJavaScriptFromString:@"console"]);
    return [[self stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount;"] intValue];
}

- (void)removeAllHighlights {
    [self stringByEvaluatingJavaScriptFromString:@"MyApp_RemoveAllHighlights()"];
}
/////////////////////////////////////

- (NSInteger)underlineAllOccurencesOfString:(NSString*)str
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self stringByEvaluatingJavaScriptFromString:jsCode];
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_UnderlineAllOccurencesOfString('%@');",str];
    [self stringByEvaluatingJavaScriptFromString:startSearch];
    
    //    NSLog(@"%@", [self stringByEvaluatingJavaScriptFromString:@"console"]);
    return [[self stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount;"] intValue];
}
#pragma mark - UIWebViewDelegate

 - (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
 {
     
     if (navigationType == UIWebViewNavigationTypeLinkClicked )
     {
         //禁止内容里面的超链接
         
         return NO;
     }

      
     return YES;
 }
 -(void)webViewDidStartLoad:(UIWebView *)webView
 {
     NSString *insertRule1 = [NSString stringWithFormat:@"addCSSRule('html', 'padding: 0px; height: %fpx; -webkit-column-gap: 0px; -webkit-column-width: %fpx;')", self.frame.size.height, self.frame.size.width];
     
     NSString *setTextSizeRule = [NSString stringWithFormat:@"addCSSRule('body', 'line-height:%@px',' font-size:%@px;')", @(self.config.lineSpace + self.config.textSize),@(self.config.textSize)];
     NSString *setTextSizeRule2 = [NSString stringWithFormat:@"addCSSRule('p', ' font-size:%@px;')", @(self.config.textSize)];
     [self stringByEvaluatingJavaScriptFromString:insertRule1];
     [self stringByEvaluatingJavaScriptFromString:setTextSizeRule];
     [self stringByEvaluatingJavaScriptFromString:setTextSizeRule2];
    
     self.hidden = YES;
 //[self.indicatorView startAnimating];
 }
 - (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
 {
     NSLog(@"%@", error);
 //[self.indicatorView stopAnimating];
 }
 - (void)webViewDidFinishLoad:(UIWebView *)theWebView
 {
     if (self.epubDelegate && [self.epubDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
         [self.epubDelegate webViewDidFinishLoad:self];
     }
     [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
     [[NSUserDefaults standardUserDefaults] synchronize];
     //需要计算  页面的信息
     [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
     
     [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
     [self reloadWebView];
     NSString *insertRule1 = [NSString stringWithFormat:@"addCSSRule('html', 'padding: 0px; height: %fpx; -webkit-column-gap: 0px; -webkit-column-width: %fpx;')", theWebView.frame.size.height, theWebView.frame.size.width];
     [theWebView stringByEvaluatingJavaScriptFromString:insertRule1];
     //页码内跳转
     [self gotoOffYInPageWithOffYIndex:self.offYIndexInPage WithOffCountInPage:[[self.dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(self.pageRefIndex)]] integerValue]];
     self.hidden = NO;
    
 }

- (void)reloadWebView {
    //NSString *insertRule1 = [NSString stringWithFormat:@"addCSSRule('html', 'padding: 0px; height: %fpx; -webkit-column-gap: 0px; -webkit-column-width: %fpx;')", self.frame.size.height, self.frame.size.width];
    
    NSString *setTextSizeRule = [NSString stringWithFormat:@"addCSSRule('body', 'line-height:%@px',' font-size:%@px;')", @(self.config.lineSpace + self.config.textSize),@(self.config.textSize)];
    NSString *setTextSizeRule2 = [NSString stringWithFormat:@"addCSSRule('p', ' font-size:%@px;')", @(self.config.textSize)];
    
    //[self stringByEvaluatingJavaScriptFromString:insertRule1];
    [self stringByEvaluatingJavaScriptFromString:setTextSizeRule];
    [self stringByEvaluatingJavaScriptFromString:setTextSizeRule2];
    
    NSString *textcolor1=[NSString stringWithFormat:@"addCSSRule('h1', 'color: %@;')",[JingGeDataManager toStrByUIColor:self.config.textColor]];
    NSString *textcolor2=[NSString stringWithFormat:@"addCSSRule('p', 'color: %@;')",[JingGeDataManager toStrByUIColor:self.config.textColor]];
    
    
    [self stringByEvaluatingJavaScriptFromString:textcolor1];
    [self stringByEvaluatingJavaScriptFromString:textcolor2];
    
    NSString *textfont = [NSString stringWithFormat:@"addCSSRule('body', ' font-family:\"%@\";');",self.config.fontName];
    [self stringByEvaluatingJavaScriptFromString:textfont];
    
    NSInteger totalWidth = [[self stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollWidth"] integerValue];
    
    NSInteger theWebSizeWidth = self.bounds.size.width;
    int offCountInPage = (int)((float)totalWidth / theWebSizeWidth);
    //NSLog(@"%d", offCountInPage);
    //NSString *offYIndexInPage = [self.dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(self.pageRefIndex)]];
    //if (!offYIndexInPage) {
    [self.dictPageWithOffYCount setObject:[NSString stringWithFormat:@"%@",@(offCountInPage)] forKey:[NSString stringWithFormat:@"%@",@(self.pageRefIndex)]];

    if (self.offYIndexInPage >= [[self.dictPageWithOffYCount valueForKey:[NSString stringWithFormat:@"%@",@(self.pageRefIndex)]] integerValue]) {
        self.offYIndexInPage = [[self.dictPageWithOffYCount valueForKey:[NSString stringWithFormat:@"%@",@(self.pageRefIndex)]] integerValue] - 1;
    
    }
    
    if (self.offYIndexInPage < 0) {
        self.offYIndexInPage = 0;
    }
    @try {
        if (self.epubDelegate && [self.epubDelegate respondsToSelector:@selector(webViewDidReload:)]) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self.epubDelegate selector:@selector(webViewDidReload:) userInfo:nil repeats:NO];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    } @finally {
        
    }
    
    
}


- (NSString *)js:(NSString *)script {
    

    NSString *callBack = [self stringByEvaluatingJavaScriptFromString:script];
    
    return callBack;
}

- (void)gotoOffYInPageWithOffYIndex:(NSInteger)offyIndex WithOffCountInPage:(NSInteger)offCountInPage
 {
     //页码内跳转
     if(offyIndex >= offCountInPage)
     {
         offyIndex = offCountInPage - 1;
     }
 
   
     float pageOffset = 0;
     
     if (offyIndex == 0) {
         NSString *catalogStr = [NSString stringWithFormat:@"getAnchorOffset('%@', true)", self.fragmentID];
        // NSString *catalogStr = [NSString stringWithFormat:@"getoffsetLeft('%@', true)", self.fragmentID];
         CGFloat offset = [[self js:catalogStr] floatValue];
        
         self.offYIndexInPage = (offset / self.bounds.size.width) ;
         
         pageOffset = self.offYIndexInPage * self.bounds.size.width;
     }else {
          pageOffset = offyIndex * self.bounds.size.width;
     }
     NSString* goToOffsetFunc = [NSString stringWithFormat:@" function pageScroll(xOffset){ window.scroll(xOffset,0); } "];
     NSString* goTo =[NSString stringWithFormat:@"pageScroll(%f)", pageOffset];
 
     [self stringByEvaluatingJavaScriptFromString:goToOffsetFunc];
     [self stringByEvaluatingJavaScriptFromString:goTo];
     if (self.epubDelegate && [self.epubDelegate respondsToSelector:@selector(webViewDidReload:)]) {
         [self.epubDelegate webViewDidReload:self];
     }
     
 }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
