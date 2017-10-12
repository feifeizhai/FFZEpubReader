//
//  JingGeEpubReaderControlView.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/20.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JingGeEpubReaderControlView, JingGeEpubReaderConfig;



@interface JingGeEpubReaderFontChoiseView : UIView

@end

@interface JingGeFontSettingView : UIView

@end

@interface JinggeBottomBar : UIView

@end

@interface JingGeEpubReaderControlBottomView : UIView

@end

@interface JingGeEpubReaderControlSettingView : UIView

@end


@protocol JingGeEpubReaderControlViewDelegate <NSObject>

@optional

- (void)backItemAction:(JingGeEpubReaderControlView *)controlView;

- (void)catalogItemAction:(JingGeEpubReaderControlView *)controlView;

- (void)settingViewChange:(JingGeEpubReaderControlView *)controlView sholdReload:(BOOL)sholdReload;

@end

@interface JingGeEpubReaderControlView : UIView

@property (assign, nonatomic) id<JingGeEpubReaderControlViewDelegate> delegate;

@property (strong, nonatomic) JingGeEpubReaderConfig *config;

- (void)showControlWithView:(UIView *)view;

@end
