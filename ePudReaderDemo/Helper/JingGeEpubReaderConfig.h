//
//  JingGeEpubReaderConfig.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kFontSizeMax 36
#define kFontSizeMin 10
typedef enum : NSUInteger {
    EpubReaderDisplayStyleNomal,
    EpubReaderDisplayStyleNight,
    EpubReaderDisplayStyleDaylight,
} EpubReaderDisplayStyle;

typedef enum : NSUInteger {
    EpubReaderTransitionTypePageCurl,    //仿真
    EpubReaderTransitionTypeScroll,      //滚动
    EpubReaderTransitionTypeCover,       //覆盖
} EpubReaderTransitionType;

typedef enum : NSUInteger {
    EpubReaderLineSpaceTypeMin         = 6,            //最小
    EpubReaderLineSpaceTypeSmall   = 8,         //较小
    EpubReaderLineSpaceTypeMedium      = 10,       //适中
    EpubReaderLineSpaceTypeLarge       = 12,        //较大
    EpubReaderLineSpaceTypeMax         = 14,          //最大
} EpubReaderLineSpaceType;

typedef void(^EpubReaderSliderBlock)(CGFloat value);

@interface JingGeEpubReaderConfig : NSObject

{
    NSArray *_backgoundColorArray;
}

@property (assign, nonatomic) EpubReaderDisplayStyle displayStyle;           //当前显示样式改变

@property (assign, nonatomic) EpubReaderTransitionType transitionType;       //翻页样式

@property (assign, nonatomic) CGFloat textSize;                      //字号

@property (strong, nonatomic) NSString *fontName;                    //字体名称

@property (strong, nonatomic) UIColor *textColor;                    //字体颜色

@property (assign, nonatomic) EpubReaderLineSpaceType lineSpace;     //行间距

@property (strong, nonatomic) UIColor *textSelectColor;              //字体选中颜色

@property (strong, nonatomic) UIImage *backgroundImage;              //背景图片

@property (strong, nonatomic) UIColor *backgroundColor;              //背景颜色

//@property (strong, nonatomic) NSArray *backgoundColorArray;          //背景颜色数组

@property (strong, nonatomic) NSArray *fontArray;                    //字体数组

@property (assign, nonatomic) float lightNum;                        //亮度

@property (strong, nonatomic) UIColor *naviColor;                    //导航栏颜色

@property (strong, nonatomic) UIColor *tabBarTintColor;              //标签栏tintColor;

@property (strong, nonatomic) UIColor *nomalTextColor;

@property (strong, nonatomic) UIColor *nomalBackgroudColor;

@property (strong, nonatomic) UIColor *nightTextColor;

@property (strong, nonatomic) UIColor *nightBackgroudColor;

@property (strong, nonatomic) UIColor *daylightTextColor;

@property (strong, nonatomic) UIColor *daylightBackgroudColor;

- (NSArray *)backgoundColorArray;
@end
