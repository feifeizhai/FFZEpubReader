//
//  JingGeEpubReaderConfig.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReaderConfig.h"
#import <JingGeMacro.h>

@interface JingGeEpubReaderConfig ()

//@property (strong, nonatomic) UIFont *textFont;                      //字体

@end

#define kNomalBackgroundColor UIColorFromHex(0x7f7f7f)
#define kNightBackgroundColor UIColorFromHex(0x111111)
#define kDaylightBackgroundColor UIColorFromHex(0xf6f6f6)

#define kNomalTextColor UIColorFromHex(0x222222)
#define kNightTextColor UIColorFromHex(0x73736d)
#define kDaylightTextColor UIColorFromHex(0x999990)

#define kNomalSelectTextColor UIColorFromHex(0x222222)
#define kNightSelectTextColor UIColorFromHex(0x222222)
#define kDaylightSelectTextColor UIColorFromHex(0x222222)

@implementation JingGeEpubReaderConfig
@synthesize displayStyle = _displayStyle, textSize= _textSize, fontName = _fontName, backgroundColor = _backgroundColor;

- (UIImage *)backgroundImage {
    if (!_backgroundImage) {
        _backgroundImage = [UIImage imageNamed:@""];
    }
    return _backgroundImage;
}

- (UIFont *)textFont {
    /*
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:16];
    }
    */
    UIFont *textFont = [UIFont systemFontOfSize:16];
    
    return textFont;
}

- (CGFloat)textSize {
    if (!_textSize) {
        _textSize = self.textFont.pointSize;
    }
    return _textSize;
}

- (NSString *)fontName {
    if (!_fontName) {
        _fontName = self.textFont.fontName;
    }
    return _fontName;
}

- (UIColor *)textColor {
    switch (self.displayStyle) {
        case EpubReaderDisplayStyleNomal:
            _textColor = self.nomalTextColor;
            break;
        case EpubReaderDisplayStyleNight:
            _textColor = self.nightTextColor;
            break;
        case EpubReaderDisplayStyleDaylight:
            _textColor = self.daylightTextColor;
            break;
        default:
            _textColor = self.nomalTextColor;
            break;
    }
    return _textColor;
}

- (UIColor *)backgroundColor {
    switch (self.displayStyle) {
        case EpubReaderDisplayStyleNomal:
            _backgroundColor = self.nomalBackgroudColor;
            break;
        case EpubReaderDisplayStyleNight:
            _backgroundColor = self.nightBackgroudColor;
            break;
        case EpubReaderDisplayStyleDaylight:
            _backgroundColor = self.daylightBackgroudColor;
            break;
        default:
            _backgroundColor = self.nomalBackgroudColor;
            break;
    }
    return _backgroundColor;
}
- (UIColor *)textSelectColor {
    if (!_textSelectColor) {
        _textSelectColor = kNomalSelectTextColor;
    }
    return _textSelectColor;
}

- (EpubReaderLineSpaceType)lineSpace {
    if (!_lineSpace) {
        _lineSpace = EpubReaderLineSpaceTypeMedium;
    }
    return _lineSpace;
}

- (UIColor *)nomalTextColor {
    if (!_nomalTextColor) {
        _nomalTextColor = kNomalTextColor;
    }
    return _nomalTextColor;
}

- (UIColor *)nomalBackgroudColor {
    if (!_nomalBackgroudColor) {
        _nomalBackgroudColor = kNomalBackgroundColor;
    }
    return _nomalBackgroudColor;
}

- (UIColor *)nightTextColor {
    if (!_nightTextColor) {
        _nightTextColor = kNightTextColor;
    }
    return _nightTextColor;
}

- (UIColor *)nightBackgroudColor {
    if (!_nightBackgroudColor) {
        _nightBackgroudColor = kNightBackgroundColor;
    }
    return _nightBackgroudColor;
}

- (UIColor *)daylightTextColor {
    if (!_daylightTextColor) {
        _daylightTextColor = kDaylightTextColor;
    }
    return _daylightTextColor;
}

- (UIColor *)daylightBackgroudColor {
    if (!_daylightBackgroudColor) {
        _daylightBackgroudColor = kDaylightBackgroundColor;
    }
    return _daylightBackgroudColor;
}

- (NSArray *)backgoundColorArray {
    if (!_backgoundColorArray) {
       
        _backgoundColorArray = @[UIColorFromHex(0x7f7f7f), UIColorFromHex(0x746e5c),UIColorFromHex(0x637058 ),UIColorFromHex(0x7c6464),UIColorFromHex(0x726652),UIColorFromHex(0x7a6a55)];
    }
    return _backgoundColorArray;
}



- (NSArray *)fontArray {
    if (!_fontArray) {
        
        NSMutableArray *fonts = [NSMutableArray array];
        {
            NSMutableDictionary *fontItem=[NSMutableDictionary dictionary];
            [fontItem setObject:@"0" forKey:@"type"];   // 0 系统自带 ， 1 为 custom
            [fontItem setObject:NSLocalizedString(@"系统字体", @"") forKey:@"name"];
            [fontItem setObject:@".SFUIText" forKey:@"fontName"];
            
            [fonts addObject:fontItem];
        }
        {
            NSMutableDictionary *fontItem=[NSMutableDictionary dictionary];
            [fontItem setObject:@"1" forKey:@"type"];   // 0 系统自带 ， 1 为 custom
            [fontItem setObject:NSLocalizedString(@"华康少女体", @"") forKey:@"name"];
            [fontItem setObject:@"DFPShaoNvW5" forKey:@"fontName"];
            [fontItem setObject:@"DFPShaoNvW5.ttf" forKey:@"fontFile"];
            [fonts addObject:fontItem];
        }
        /*
       
        {
            NSMutableDictionary *fontItem=[NSMutableDictionary dictionary];
            [fontItem setObject:@"1" forKey:@"type"];   // 0 系统自带 ， 1 为 custom
            [fontItem setObject:NSLocalizedString(@"汉仪书宋", @"") forKey:@"name"];
            [fontItem setObject:@"ETrump ShuSongEr" forKey:@"fontName"];
            [fontItem setObject:@"HYShuSE18030F.ttf" forKey:@"fontFile"];
            [fonts addObject:fontItem];
        }
        {
            NSMutableDictionary *fontItem=[NSMutableDictionary dictionary];
            [fontItem setObject:@"1" forKey:@"type"];   // 0 系统自带 ， 1 为 custom
            [fontItem setObject:NSLocalizedString(@"汉仪旗黑", @"") forKey:@"name"];
            [fontItem setObject:@"HY QiHei45" forKey:@"fontName"];
            [fontItem setObject:@"HYQiH18030F45.ttf" forKey:@"fontFile"];
            [fonts addObject:fontItem];
        }
        
        {
            NSMutableDictionary *fontItem=[NSMutableDictionary dictionary];
            [fontItem setObject:@"1" forKey:@"type"];   // 0 系统自带 ， 1 为 custom
            [fontItem setObject:NSLocalizedString(@"汉仪楷体", @"") forKey:@"name"];
            [fontItem setObject:@"ETrump KaiTi" forKey:@"fontName"];
            [fontItem setObject:@"HYKaiT18030F.ttf" forKey:@"fontFile"];
            [fonts addObject:fontItem];
        }
        */
        _fontArray = [fonts copy];
    }
    return _fontArray;
}



- (EpubReaderDisplayStyle)displayStyle {
    if (!_displayStyle) {
        _displayStyle = EpubReaderDisplayStyleNomal;
    }
    return _displayStyle;
}

- (EpubReaderTransitionType)transitionType {
    if (!_transitionType) {
        _transitionType = EpubReaderTransitionTypePageCurl;
    }
    return _transitionType;
}

- (UIColor *)naviColor {
    if (!_naviColor) {
        _naviColor = UIColorFromHexAlpha(0x000000, 0.7);
    }
    return _naviColor;
}

- (UIColor *)tabBarTintColor {
    if (!_tabBarTintColor) {
        _tabBarTintColor = UIColorFromHex(0x73736d);
    }
    return _tabBarTintColor;
}

- (float)lightNum {
    if (!_lightNum) {
        _lightNum = [UIScreen mainScreen].brightness;
    }
    return _lightNum;
}
/*
- (void)setDisplayStyle:(EpubReaderDisplayStyle)displayStyle {
    _displayStyle = displayStyle;
    switch (displayStyle) {
        case EpubReaderDisplayStyleNomal:
            _backgroundColor = kNomalBackgroundColor;
            _textColor = kNomalTextColor;
            break;
        case EpubReaderDisplayStyleNight:
            self.backgroundColor = kNightBackgroundColor;
            self.textColor = kNightTextColor;
            break;
        case EpubReaderDisplayStyleDaylight:
            self.backgroundColor = kDaylightBackgroundColor;
            self.textColor = kDaylightTextColor;
            break;
        default:
            break;
    }
}

*/
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _displayStyle = EpubReaderDisplayStyleNomal;
    _nomalBackgroudColor = backgroundColor;
    _backgroundColor = backgroundColor;
}



- (void)setTextSize:(CGFloat)textSize {
    if (textSize < kFontSizeMin) {
        textSize = kFontSizeMin;
    }
    
    if (textSize > kFontSizeMax) {
        textSize = kFontSizeMax;
    }
    _textSize = textSize;
   // self.textFont = [UIFont fontWithName:self.fontName size:textSize];
}

- (void)setFontName:(NSString *)fontName {
    _fontName = fontName;
    //self.textFont = [UIFont fontWithName:fontName size:self.textSize];
}

@end
