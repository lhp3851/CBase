//
//  DateTool.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/6/14.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject
//转化成系统时间,本地时间为GMT
+ (NSDate *)getLocaleDateFromUTCDate:(NSDate *)date;

//通过日期获取日期
+(NSDate *)getDateFromString:(NSString *)timeString;
//通过时间戳获取日期
+(NSDate *)getDateFromTimeStamp:(NSString *)timeStamp;
//通过时间间隔获取日期
+(NSDate *)getDateFromTimeInterval:(NSTimeInterval)timeInterval;

/**-----------------------------获取字符串时间--------------------------------**/
//根据时间字符串获取本地标准时间
+(NSString *)friendTimeFromString:(NSString *)timeString;
//根据时间戳获取本地标准时间
+(NSString *)friendTimeFromStamp:(NSString *)timeStamp;
//根据时间间隔获取本地标准时间
+(NSString *)friendTimeFromInterVal:(NSTimeInterval)timeInterVal;
/**-----------------------------时间组成成员--------------------------------**/

//通过时间字符串获取时间组成成员
+(NSDateComponents *)getDateComponnentWithString:(NSString *)string;
+(NSDateComponents *)getDateComponnentWithDate  :(NSDate *)date;
@end


@interface DateFormatter <__covariant ObjectType>: NSDateFormatter
+(void)dateFormatterInfo;

+( NSDateFormatter *)defaultDateFormatter;
@end

@interface TimeZone : NSTimeZone

+(void)timeZoneInfo;//timeZoneInfo

+(NSTimeZone *)defaultTimeZone;
@end

@interface TimeLocale : NSLocale
+(void)timeLocalInfo;

+(NSLocale *)defaultTimeLocal;
@end

@interface Date : NSDate
+(void)dateInfo;

+(NSDate *)curruntDate;

+(NSString *)curruntDateString;

+(NSString *)curruntDateAndTimeString;

+(NSMutableArray *)yeares;

+(NSMutableArray *)monthesWithYear:(NSString *)yearDate;

+(NSMutableArray *)dayesWithMoth:(NSString *)month andYear:(NSString *)year;

+ (NSString *)calculateWeek:(NSDate *)date;

+(BOOL)isWeekenday:(NSDate *)date;

+(BOOL)isWeekendayString:(NSString *)dateString;

/**
 将字符串格式日期2017-08-01转换成字符串

 @param date 日期字符串
 @return 字符串格式的日期
 */
+(NSString *)convertDateStringToFriendDateString:(NSString *)date;

/**
 将日期2017-08-01转换成字符串
 
 @param date 日期字符串
 @return 字符串格式的日期
 */
+(NSString *)convertDateToFriendDate:(NSDate *)date;

/**
 日期格式化

 @return 格式化后的日期
 */
+(NSString *)convertDateToFromatDate:(NSString *)date;


/**
 日期转化几天前格式

 @param str 日期字符串
 @return 格式化日期
 */
+ (NSString *)compareCurrentTime:(NSString *)str;

/**
 比较两个时间差10分钟之内

 @param frontStr 数组前面model的时间
 @param behindStr 后面model的时间
 @return bool值 <10 YES； >10分钟 NO
 */
+ (BOOL)isLessThanTenTimeIntervalWithFrontTime:(NSString *)frontStr Behind:(NSString *)behindStr;

/**
 比较两个时间大小

 @param fStr 第一个
 @param sStr 第二个
 @return 第一个是否比第二个大
 */
+ (BOOL)compareTimeWithFirstStr:(NSString *)fStr sStr:(NSString *)sStr;

+ (BOOL)isLeapYearFromYeah:(NSInteger)year;
@end

@interface Calendar : NSCalendar
+(void)calendarIfo;

+(NSCalendar *)defaultCalendar;
@end
