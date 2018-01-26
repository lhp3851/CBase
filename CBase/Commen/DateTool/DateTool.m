//
//  DateTool.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/6/14.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool
/**-----------------------------把date转化成系统时间,本地时间为GMT--------------------------------**/
+ (NSDate *)getLocaleDateFromUTCDate:(NSDate *)date
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [TimeZone defaultTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    return  destinationDateNow;
}
/**-----------------------------获取日期--------------------------------**/
//通过日期获取本地标准的日期
+(NSDate *)getDateFromString:(NSString *)timeString{
    NSDateFormatter *dateFormatter=[DateFormatter defaultDateFormatter];
    NSDate *orignalDate=[dateFormatter dateFromString:timeString];
    NSDate *systemDate=[self getLocaleDateFromUTCDate:orignalDate];
    return systemDate;
}
//通过时间戳获取本地标准的日期
+(NSDate *)getDateFromTimeStamp:(NSString *)timeStamp{
    NSDateFormatter *dateFormatter=[DateFormatter defaultDateFormatter];
    NSTimeInterval adjustTimeInterVal=[dateFormatter.timeZone secondsFromGMT];
    NSTimeInterval secondInterVal = timeStamp.doubleValue/ 1000+adjustTimeInterVal;
    NSDate *orignalDate=[NSDate dateWithTimeIntervalSince1970:secondInterVal];
    return orignalDate;
}
//通过时间间隔获取本地标准的日期
+(NSDate *)getDateFromTimeInterval:(NSTimeInterval)timeInterval{
    NSTimeInterval secondInterVal = timeInterval/ 1000;
    NSDate *orignalDate=[NSDate dateWithTimeIntervalSince1970:secondInterVal];
    NSDate *systemDate=[self getLocaleDateFromUTCDate:orignalDate];
    return systemDate;
}
/**-----------------------------获取字符串时间--------------------------------**/
//根据时间字符串获取本地标准的时间
+(NSString *)friendTimeFromString:(NSString *)timeString{
    NSDateFormatter *dateFormatter=[DateFormatter defaultDateFormatter];
    NSDate *orignalDate=[dateFormatter dateFromString:timeString];
    NSDate *systemDate=[self getLocaleDateFromUTCDate:orignalDate];
    NSString *stringTime=[dateFormatter stringFromDate:systemDate];
    return stringTime;
}
//根据时间戳获取本地标准时间
+(NSString *)friendTimeFromStamp:(NSString *)timeStamp{//毫秒
    NSTimeInterval secondInterVal = timeStamp.doubleValue/ 1000;
    NSDateFormatter *dateFormatter=[DateFormatter defaultDateFormatter];
    NSDate *orignalDate=[NSDate dateWithTimeIntervalSince1970:secondInterVal];
    NSDate *systemDate=[self getLocaleDateFromUTCDate:orignalDate];
    NSString *stringTime=[dateFormatter stringFromDate:systemDate];
    return stringTime;
}
//根据时间间隔获取本地标准时间
+(NSString *)friendTimeFromInterVal:(NSTimeInterval)timeInterVal{//毫秒
    NSTimeInterval secondInterVal = timeInterVal/ 1000;
    NSDateFormatter *dateFormatter=[DateFormatter defaultDateFormatter];
    NSDate *orignalDate=[NSDate dateWithTimeIntervalSince1970:secondInterVal];
    NSDate *systemDate=[self getLocaleDateFromUTCDate:orignalDate];
    NSString *stringTime=[dateFormatter stringFromDate:systemDate];
    return stringTime;
}

/**-----------------------------通过时间字符串获取时间组成成员--------------------------------**/
+(NSDateComponents *)getDateComponnentWithString:(NSString *)string{
    NSDateFormatter *defaultDateFormatter=[DateFormatter defaultDateFormatter];
    NSCalendar *currentCalendar=[Calendar defaultCalendar];
    NSDate *currentDate        =[defaultDateFormatter dateFromString:string];
    NSDate *systemDate         =[self getLocaleDateFromUTCDate:currentDate];
    NSDateComponents *calendarComponents=[currentCalendar components:(NSCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay|NSCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekOfYear| NSCalendarUnitQuarter|NSCalendarUnitYearForWeekOfYear|NSCalendarUnitNanosecond|NSCalendarUnitCalendar|NSCalendarUnitTimeZone) fromDate:systemDate];
    return calendarComponents;
}

+(NSDateComponents *)getDateComponnentWithDate:(NSDate *)date{
    NSCalendar *currentCalendar=[Calendar defaultCalendar];
    NSDateComponents *calendarComponents=[currentCalendar components:(NSCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay|NSCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekOfYear| NSCalendarUnitQuarter|NSCalendarUnitYearForWeekOfYear|NSCalendarUnitNanosecond|NSCalendarUnitCalendar|NSCalendarUnitTimeZone) fromDate:date];
    return calendarComponents;
}

/**-----------------------------通过日期获取友好时间--------------------------------**/
+ (NSString*)getTimeStringWithDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [DateFormatter defaultDateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    dateFormatter.locale = [TimeLocale defaultTimeLocal];
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [Calendar defaultCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate *createDate = date;//目标时间
    NSDate *nowDate = [NSDate date];// 当前时间
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    NSTimeInterval time=[nowDate timeIntervalSinceDate:date];
    
    int hours=((int)time)/3600;
    if ([createDate isThisYear]) {
        if ([createDate isThreeDaysAgo]) {
            return @"3天前";
        }else if([createDate isTwoDaysAgo]){
            return @"2天前";
        }else if ([createDate isYesterday] && hours >= 24) {
            return @"1天前";
        } else if (hours < 24) {
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else{
            NSTimeInterval stamp = [createDate timeIntervalSince1970] + [KKTimer getOffsetBetweenServerAndLocaltime];
            NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:stamp];
            dateFormatter.dateFormat = @"MM-dd HH:mm";
            return [dateFormatter stringFromDate:newDate];
        }
    } else { // 非今年
        NSTimeInterval stamp = [createDate timeIntervalSince1970] + [KKTimer getOffsetBetweenServerAndLocaltime];
        NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:stamp];
        dateFormatter.dateFormat = @"MM-dd HH:mm";
        return [dateFormatter stringFromDate:newDate];
    }
}


@end

#pragma mark DefaultDateFormatter
@implementation DateFormatter
+(void)dateFormatterInfo{
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate *date = [NSDate date];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"Formatted date string for locale :%@, %@", [[dateFormatter locale] localeIdentifier], formattedDateString);
    //en_US, June 14, 2016<--NSDateFormatterBehavior10_4|NSDateFormatterBehaviorDefault
    //NSDateFormatterBehaviorDefault (TARGET_OS_MAC && !(TARGET_OS_EMBEDDED || TARGET_OS_IPHONE))
}


+(NSDateFormatter *)defaultDateFormatter{
    if (self) {
        //NSDateFormatterNoStyle     = kCFDateFormatterNoStyle,
        //NSDateFormatterShortStyle  = kCFDateFormatterShortStyle,//“11/23/37” or “3:30pm”
        //NSDateFormatterMediumStyle = kCFDateFormatterMediumStyle,//"Nov 23, 1937"
        //NSDateFormatterLongStyle   = kCFDateFormatterLongStyle,//"November 23, 1937” or “3:30:32pm"
        //NSDateFormatterFullStyle   = kCFDateFormatterFullStyle//“Tuesday, April 12, 1952 AD” or “3:30:42pm PST”
        NSDateFormatter *dateFormatter=[NSDateFormatter new];
        dateFormatter.locale    =[TimeLocale defaultTimeLocal];
        dateFormatter.timeZone  =[NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        dateFormatter.calendar  =[Calendar defaultCalendar];
        dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss z EEEE";//yyyy-MM-dd HH:mm:ss z EEEE
        return dateFormatter;
    }
    return nil;
}
@end

@implementation TimeZone
+(void)timeZoneInfo{
    NSLog(@"当前iOS系统已知的时区名称：%@",[NSTimeZone knownTimeZoneNames]);
    
    NSLog(@"abbreviationDictionary:%@",[NSTimeZone abbreviationDictionary]);
    
    NSLog(@"systemTimeZone:%@",[NSTimeZone systemTimeZone]);
    
    NSLog(@"defaultTimeZone:%@",[NSTimeZone defaultTimeZone]);
    
    NSLog(@"localTimeZone:%@",[NSTimeZone localTimeZone]);
    
    NSLog(@"timeZoneDataVersion:%@",[NSTimeZone timeZoneDataVersion]);
    
    NSLog(@"systemTimeZone secondsFromGMT:%ld and daylightSavingTimeOffset:%f",[NSTimeZone systemTimeZone].secondsFromGMT,[NSTimeZone systemTimeZone].daylightSavingTimeOffset);
    
    NSLog(@"systemTimeZone daylightSavingTime:%d",[NSTimeZone systemTimeZone].daylightSavingTime);
    
    NSLog(@"systemTimeZone description:%@",[NSTimeZone systemTimeZone].description);
    
    NSLog(@"systemTimeZone data and name:%@,%@",[NSTimeZone systemTimeZone].data,[NSTimeZone systemTimeZone].name);
}

+(NSTimeZone *)defaultTimeZone{
    return [NSTimeZone defaultTimeZone];
}
@end

@implementation TimeLocale
+(void)timeLocalInfo{
    NSLocale *currentLoacle=[NSLocale currentLocale];
    NSLog(@"currentLocale:%@",currentLoacle);
    
    NSLog(@"autoupdatingCurrentLocale:%@",[NSLocale autoupdatingCurrentLocale]);
    
    NSLog(@"systemLocale:%@",[NSLocale systemLocale]);
    
    NSLog(@"systemLocale localeIdentifier:%@",[NSLocale systemLocale].localeIdentifier);
    
    NSLog(@"availableLocaleIdentifiers:%@",[NSLocale availableLocaleIdentifiers]);
    
    NSLog(@"ISOLanguageCodes:%@",[NSLocale ISOLanguageCodes]);
    
    NSLog(@"ISOCountryCodes:%@",[NSLocale ISOCountryCodes]);
    
    NSLog(@"ISOCurrencyCodes:%@",[NSLocale ISOCurrencyCodes]);
    
    NSLog(@"commonISOCurrencyCodes:%@",[NSLocale commonISOCurrencyCodes]);
    
    NSLog(@"local preferredLanguages:%@  and preferredLocalizations:%@ localizedInfoDictionary:%@",[NSLocale preferredLanguages],[[NSBundle mainBundle] preferredLocalizations],[[NSBundle mainBundle] localizedInfoDictionary]);
    
    NSLog(@"NSLocale:description:%@",[NSLocale description]);
    
}

+(NSLocale *)defaultTimeLocal{
    return [NSLocale autoupdatingCurrentLocale];//实时更新的
}
@end

@implementation Date

+(void)dateInfo{
    NSDate *currentDate=[self curruntDate];
    NSLog(@"date timeIntervalSinceNow:%f",currentDate.timeIntervalSinceNow);
    
    NSLog(@"date timeIntervalSinceReferenceDate:%f",currentDate.timeIntervalSinceReferenceDate);
    
    NSLog(@"date timeIntervalSince1970:%f",currentDate.timeIntervalSince1970);
    
    NSLog(@"date description:%@",currentDate.description);
    
    NSLog(@"date distantPast:%@",[NSDate distantPast]);
    
    NSLog(@"date distantPast:%@",[NSDate distantFuture]);
}

+(NSDate *)curruntDate{
    return  [self getLocaleDateFromUTCDate:[NSDate date]];
}


+(NSString *)curruntDateString{
    NSString *dateString = nil;
    NSDate *date = [self curruntDate];
    NSDateFormatter *formatter = [DateFormatter defaultDateFormatter];
    dateString = [formatter stringFromDate:date];
    dateString = [dateString substringToIndex:10];
    return dateString;
}

+(NSString *)curruntDateAndTimeString{
    NSString *dateString = nil;
    NSDate *date = [self curruntDate];
    NSDateFormatter *formatter = [DateFormatter defaultDateFormatter];
    dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSMutableArray *)yeares{
    NSString *endYear = [[self curruntDateString] substringToIndex:4];
    
    NSString *startYear = @"2017年";
    
    NSMutableArray *yearsArray = [NSMutableArray arrayWithObject:startYear];
    
    NSInteger delta = endYear.integerValue - startYear.integerValue;
    
    for (NSInteger i=1; i<=delta; i++) {
        NSString *year = [NSString stringWithFormat:@"%ld年",startYear.integerValue + i];
        [yearsArray addObject:year];
    }
    return yearsArray;
}

+(NSMutableArray *)monthesWithYear:(NSString *)yearDate{
    NSString *currentDate = [Date curruntDateString];
    NSString *currentYear = [currentDate substringWithRange:NSMakeRange(0, 4)];
    NSString *currentMonth= [currentDate substringWithRange:NSMakeRange(5, 2)];
    
    NSString *year  = [yearDate substringWithRange:NSMakeRange(0, 4)];
    NSMutableArray *montes = [NSMutableArray arrayWithObjects:@"01月",@"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月", nil];
    
    
    if ([year isEqualToString:@"2017"]) {
        montes = [NSMutableArray arrayWithObjects:@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月", nil];
        NSMutableArray *subMonth = [NSMutableArray array];
        if (year.integerValue<currentYear.integerValue) {
            return montes;
        }else {
            for (int i=0; i<currentMonth.integerValue - 4; i++) {
                [subMonth addObject:montes[i]];
            }
        }
        return subMonth;
    }
    else{
        if (year.integerValue<currentYear.integerValue) {
            return montes;
        }
        else{
            NSMutableArray *subMonth = [NSMutableArray array];
            for (int i = 0; i<currentMonth.integerValue; i++) {
                [subMonth addObject:montes[i]];
            }
            return subMonth;
        }
    }
}

+(NSMutableArray *)dayesWithMoth:(NSString *)month andYear:(NSString *)year{
    NSString *currentDate = [Date curruntDateString];
    NSString *currentYear = [currentDate substringWithRange:NSMakeRange(0, 4)];
    NSString *currentMonth= [currentDate substringWithRange:NSMakeRange(5, 2)];
    NSString *currentDay  = [currentDate substringWithRange:NSMakeRange(8, 2)];
    
    month = [month stringByReplacingOccurrencesOfString:@"月" withString:@""];
    year  = [year  stringByReplacingOccurrencesOfString:@"年" withString:@""];
    
    NSMutableArray *dayes = [NSMutableArray array];
    dayes = [NSMutableArray arrayWithObjects:@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日", nil];
    if ([year isEqualToString:currentYear] && [month isEqualToString:currentMonth]) {
        NSMutableArray *subDayes = [NSMutableArray array];
        for (int i =0; i<currentDay.integerValue; i++) {
            [subDayes addObject:dayes[i]];
        }
        return subDayes;
    }
    else{
        if ([self isBigMonth:month]) {
            dayes = [NSMutableArray arrayWithObjects:@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日", nil];
        }
        else if ([self isSmallMonth:month]){
            dayes = [NSMutableArray arrayWithObjects:@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日", nil];
            if ([self isLeapYearFromYeah:year.integerValue]) {
                dayes = [NSMutableArray arrayWithObjects:@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日", nil];
            }
        }
        else{
            dayes = [NSMutableArray arrayWithObjects:@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日", nil];
        }
    }
    return dayes;
}

+(BOOL)isBigMonth:(NSString *)month{
    NSInteger monthNum = month.integerValue;
    if (monthNum ==1 || monthNum ==3 ||monthNum ==5 || monthNum ==7 || monthNum ==8||monthNum ==10 ||monthNum ==12) {
        return YES;
    }
    return NO;
}

+(BOOL)isNormalMonth:(NSString *)month{
    NSInteger monthNum = month.integerValue;
    if (monthNum ==4 || monthNum ==6 ||monthNum ==9 || monthNum ==11) {
        return YES;
    }
    return NO;
}

+(BOOL)isSmallMonth:(NSString *)month{
    if (month.integerValue==2) {
        return YES;
    }
    return NO;
}


+ (NSString *)calculateWeek:(NSDate *)date{
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:date] weekday];
    NSString *weekDate = [NSString string];
    switch (week) {
        case 1:
        {
            weekDate = @"周日";
        }
            break;
        case 2:
        {
            weekDate = @"周一";
        }
            break;
        case 3:
        {
            weekDate = @"周二";
        }
            break;
        case 4:
        {
            weekDate = @"周三";
        }
            break;
        case 5:
        {
            weekDate = @"周四";
        }
            break;
        case 6:
        {
            weekDate = @"周五";
        }
            break;
        case 7:
        {
            weekDate = @"周六";
        }
            break;
    }
    return weekDate;
}

+(BOOL)isWeekendayString:(NSString *)dateString{
    if (dateString == nil) {
        return NO;
    }
    NSDateFormatter *dateFormater = [DateFormatter defaultDateFormatter];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormater dateFromString:dateString];
    return [self isWeekenday:date];
}


+(BOOL)isWeekenday:(NSDate *)date{
    if (date == nil) {
        return NO;
    }
    NSString *weekString = [self calculateWeek:date];
    if ([weekString isEqualToString:@"周日"] ||[weekString isEqualToString:@"周六"]) {
        return YES;
    }
    else{
        return NO;
    }
}

+(NSString *)convertDateToFromatDate:(NSString *)date{
    date=[date stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    date=[date stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    date=[date stringByReplacingOccurrencesOfString:@"日" withString:@""];
    return date;
}


+(NSString *)convertDateStringToFriendDateString:(NSString *)date{
    date= [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSMutableString *mutableDefaultString = [NSMutableString stringWithString:date];
    [mutableDefaultString insertString:@"年" atIndex:4];
    [mutableDefaultString insertString:@"月" atIndex:7];
    [mutableDefaultString insertString:@"日" atIndex:10];
    return mutableDefaultString;
}

+(NSString *)convertDateToFriendDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [DateFormatter defaultDateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return [self convertDateStringToFriendDateString:dateString];
}
+ (NSString *)compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString * result = [dateFormatter stringFromDate:timeDate];
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval;
    long temp = 0;
    NSDate * nowDate = [NSDate date];
    NSString * nowStr = [dateFormatter stringFromDate:nowDate];
    NSString * topStr = [dateFormatter stringFromDate:timeDate];
    NSString * nowMStr = [[[[nowStr componentsSeparatedByString:@"月"] lastObject] componentsSeparatedByString:@"日"] firstObject];
    NSString * topMStr = [[[[topStr componentsSeparatedByString:@"月"] lastObject] componentsSeparatedByString:@"日"] firstObject];
    NSString * topHStr = [[[[topStr componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"] firstObject];
    if (timeInterval < 60) {
        [dateFormatter setDateFormat:@"HH:mm"];
        result = [dateFormatter stringFromDate:timeDate];
    }
    else if((temp = timeInterval/60) <60){
        [dateFormatter setDateFormat:@"HH:mm"];
        result = [dateFormatter stringFromDate:timeDate];
    }
    else if((temp = temp/60) <24){
        [dateFormatter setDateFormat:@"HH:mm"];
        result = [dateFormatter stringFromDate:timeDate];
        if ([nowMStr integerValue] - [topMStr integerValue] == 1) {
            if ([topHStr integerValue] < 12) {
                [dateFormatter setDateFormat:@"昨天 HH:mm"];
                result = [dateFormatter stringFromDate:timeDate];
            }else{
                [dateFormatter setDateFormat:@"昨天 HH:mm"];
                result = [dateFormatter stringFromDate:timeDate];
            }
        }
    }
    else if((temp = temp/24) <2){
        result = [dateFormatter stringFromDate:timeDate];
        if ([nowMStr integerValue] - [topMStr integerValue] == 1) {
            if ([topHStr integerValue] < 12) {
                [dateFormatter setDateFormat:@"昨天 HH:mm"];
                result = [dateFormatter stringFromDate:timeDate];
            }else{
                [dateFormatter setDateFormat:@"昨天 HH:mm"];
                result = [dateFormatter stringFromDate:timeDate];
            }
        }
    }
    return result;
}
+ (BOOL)isLessThanTenTimeIntervalWithFrontTime:(NSString *)frontStr Behind:(NSString *)behindStr
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *frontDate = [dateFormatter dateFromString:frontStr];
    NSDate *behindDate = [dateFormatter dateFromString:behindStr];
    //得到与当前时间差
    NSTimeInterval  timeInterval = [frontDate timeIntervalSinceDate:behindDate];
    
    if (timeInterval/60 < 10) {
        return YES;
    }
    return NO;
}
+ (BOOL)compareTimeWithFirstStr:(NSString *)fStr sStr:(NSString *)sStr
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *frontDate = [dateFormatter dateFromString:fStr];
    NSDate *behindDate = [dateFormatter dateFromString:sStr];
    //得到与当前时间差
    NSTimeInterval  timeInterval = [frontDate timeIntervalSinceDate:behindDate];
    if (timeInterval <= 0) {
        return YES;
    }
    return NO;
}
+ (BOOL)isLeapYearFromYeah:(NSInteger)year
{
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }
    return NO;
}
@end


@implementation Calendar
+(void)calendarIfo{
    NSCalendar *defaultCalendar=[self defaultCalendar];
    NSLog(@"currentCalendar:%@",[NSCalendar currentCalendar]);
    
    NSLog(@"autoupdatingCurrentCalendar:%@",[NSCalendar autoupdatingCurrentCalendar]);
    
    NSLog(@"calendar Identifier:%@",defaultCalendar.calendarIdentifier);
    
    NSLog(@"calendar locale:%@",defaultCalendar.locale);
    
    NSLog(@"calendar timeZone:%@",defaultCalendar.timeZone);
    
    NSLog(@"calendar firstWeekday:%lui",(unsigned long)defaultCalendar.firstWeekday);
    
    NSLog(@"calendar minimumDaysInFirstWeek:%lui",(unsigned long)defaultCalendar.minimumDaysInFirstWeek);
    
    NSLog(@"calendar eraSymbols：%@,calendar longEraSymbols：%@",defaultCalendar.eraSymbols,defaultCalendar.longEraSymbols);
    
    NSLog(@"calendar monthSymbols:%@\n,calendar shortMonthSymbols:%@\n,calendar veryShortMonthSymbols:%@\n,calendar standaloneMonthSymbols:%@\n,calendar shortStandaloneMonthSymbols:%@\n,calendar veryShortStandaloneMonthSymbols:%@",defaultCalendar.monthSymbols,defaultCalendar.shortMonthSymbols,defaultCalendar.veryShortMonthSymbols,defaultCalendar.standaloneMonthSymbols,defaultCalendar.shortStandaloneMonthSymbols,defaultCalendar.veryShortStandaloneMonthSymbols);
    
    NSLog(@"calendar weekdaySymbols:%@",defaultCalendar.weekdaySymbols);
    
    NSLog(@"calendar quarterSymbols:%@",defaultCalendar.quarterSymbols);
    
    NSLog(@"calendar PMSymbol:%@",defaultCalendar.PMSymbol);
    
    NSLog(@"calendar AMSymbol:%@",defaultCalendar.AMSymbol);
    
}

+(NSCalendar *)defaultCalendar{
    return [NSCalendar autoupdatingCurrentCalendar];
}

@end

