//
//  JingGeDateManager.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingGeDateManager : NSObject
+ (NSString*)updateTimeDate:(NSString*)timestr;
+ (NSString*)getTimestr:(NSString*)timestr;
+ (NSString*)getDaytimestr:(NSString*)timestr;
+ (NSString*)weekDayStr:(NSString *)format;
+ (NSString *)timeFormatted:(int)totalSeconds;
+ (NSString *)currentDate;
@end
