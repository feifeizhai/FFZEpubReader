//
//  JingGeDateManager.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeDateManager.h"

@implementation JingGeDateManager

+ (NSString*)updateTimeDate:(NSString*)timestr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    NSRange range = [timestr rangeOfString:@"/"];
    if (range.length > 0)
    {
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    }
    else
    {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    NSDate *date=[formatter dateFromString:timestr];
    
    NSString *title = @"";
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitHour
                                               fromDate:date toDate:[NSDate date] options:0];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if (year == 0 && month == 0 && day < 3) {
        if (day == 0) {
            //得到与当前时间差
            NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
            timeInterval = timeInterval<0?-timeInterval:timeInterval;
            //标准时间和北京时间差8个小时
            //            timeInterval = timeInterval - 8*60*60;
            long temp = 0;
            if (timeInterval < 60)
                title = [NSString stringWithFormat:@"刚刚"];
            else if((temp = timeInterval/60) <60)
                title = [NSString stringWithFormat:@"%ld分钟前",temp];
            else if((temp = temp/60) <24)
                title = [NSString stringWithFormat:@"%ld小时前",temp];
            
        } else if (day == 1) {
            title = @"昨天";
        } else if (day == 2) {
            title = @"前天";
        }
    }
    else
        title = timestr;
    return title;
}

+ (NSString*)getTimestr:(NSString*)timestr
{
    NSArray*aArray=[timestr  componentsSeparatedByString:@":"];
    NSMutableArray*Arr=[NSMutableArray arrayWithArray:aArray];
    
    NSString*last=[Arr lastObject];
    NSArray*lastArray=[last  componentsSeparatedByString:@" "];
    if ([[lastArray lastObject] isEqualToString:@"PM"]) {
        NSString*first=[Arr firstObject];
        NSArray*A=[first  componentsSeparatedByString:@" "];
        NSMutableArray*firstArr=[NSMutableArray arrayWithArray:A];
        NSString*hh=[NSString stringWithFormat:@"%ld",(long)([[firstArr lastObject] integerValue]+12)];
        if ([hh isEqualToString:@"24"]) {
            hh = @"00";
        }
        [firstArr replaceObjectAtIndex:firstArr.count-1 withObject:hh];
        first=[firstArr componentsJoinedByString:@" "];
        
        [Arr replaceObjectAtIndex:0 withObject:first];
    }
    
    [Arr removeLastObject];
    timestr=[Arr componentsJoinedByString:@":"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    NSRange range = [timestr rangeOfString:@"/"];
    if (range.length > 0)
    {
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    }
    else
    {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    NSDate *date=[formatter dateFromString:timestr];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init] ;
    [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
    timestr=[formatter2 stringFromDate:date];
    return timestr;
}

+ (NSString*)getDaytimestr:(NSString*)timestr
{
    NSArray*aArray=[timestr  componentsSeparatedByString:@" "];
    timestr=[aArray objectAtIndex:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    //    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSRange range = [timestr rangeOfString:@"/"];
    if (range.length > 0)
    {
        [formatter setDateFormat:@"yyyy/MM/dd"];
    }
    else
    {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *date=[formatter dateFromString:timestr];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init] ;
    [formatter2 setDateFormat:@"yyyy-MM-dd"];
    timestr=[formatter2 stringFromDate:date];
    return timestr;
}

+ (NSString *)currentDate {
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

+(NSString*)weekDayStr:(NSString *)format
{
    NSString *weekDayStr = nil;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    //    NSString *str = format;
    if (format.length >= 10) {
        NSString *nowString = [format substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            long year = [[array objectAtIndex:0] integerValue];
            long month = [[array objectAtIndex:1] integerValue];
            long day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    long week = [weekdayComponents weekday];
    //    week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
}


+ (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}


@end
