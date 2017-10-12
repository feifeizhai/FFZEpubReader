//
//  JingGeUtilsMacro.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

/**
 这是一个方便的宏文件
 */

#define WXDEBUG 0

#if WXDEBUG
#define kRandColor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#else
#define kRandColor  [UIColor clearColor]
#endif // #ifdef DEBUG

#ifdef DEBUG
#define Log(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String])
#else
#define Log(s, ... )
#endif

#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define UIColorFromHexAlpha(hexValue,alpha) RGBA((float)((hexValue & 0xFF0000) >> 16), (float)((hexValue & 0xFF0000) >> 16), (float)((hexValue & 0xFF0000) >> 16), alpha)

//带有RGBA的颜色设置
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)



#define kWindow [UIApplication sharedApplication].keyWindow
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kNavigationBar_HEIGHT 44.0f
#define kNavigationBarItemSize 28.0f
#define kTabBar_HEIGHT 49.0f
#define kStatusBar_HEIGHT 20.0f
#define kToolsBar_HEIGHT 44.0f

#define IS_FIRST_USE @"IS_FIRST_USE" //NO是第一次
#define kAppDelegate ((Jg_RspAppdelegate *)[UIApplication sharedApplication].delegate)
#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define kStrongSelf(type)  __strong typeof(type)type = weak##type

#define kDegreesToRadian(x) (M_PI * (x) / 180.0) //角度转换弧度
#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)//弧度转换角度

#define SET_USERDEFAULT_VALUE(value,key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]

#define GET_USERDEFAULT_VALUE(key)  [[NSUserDefaults standardUserDefaults] valueForKey:key]

#define SET_USERDEFAULT_BOOL(value,key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]
#define GET_USERDEFAULT_BOOL(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define SYNCHRONIZE_USERDEFAULT  [[NSUserDefaults standardUserDefaults] synchronize]
#define REMOVE_USERDEFAULT_VALUE(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]


//系统默认字体
#define UISYSTEM_FONT(size) [UIFont systemFontOfSize:size]
//系统默认黑体
#define UIBOLD_SYSTEM_FONT(size) [UIFont boldSystemFontOfSize:size]

//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define kDeviceSystenName [[UIDevice currentDevice] systemName]
#define kDevicesystemVersion [[UIDevice currentDevice] systemVersion]
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
// 判断是否为 iPhone 4
#define iPhone4 [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 480.0f
// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
//判断 iOS 10 或更高的系统版本
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=10.0)? (YES):(NO))
//获取app版本号
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取appBuild号
#define APP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//获取沙盒 temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//判断是否是dictionary
#define kIsDictionary(dic) [dic isKindOfClass:[NSDictionary class]]
//设置导航栏字体
#define kNaviTitleFont(font, color) [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font],NSForegroundColorAttributeName:color}]
