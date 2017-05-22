//
//  NSDate+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSDate+MAREX.h"

@implementation NSDate (MAREX)

- (NSInteger)mar_year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)mar_month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)mar_day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)mar_hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)mar_minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)mar_second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)mar_nanosecond
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitNanosecond fromDate:self] nanosecond];
}

- (NSInteger)mar_weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)mar_weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)mar_weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)mar_weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)mar_yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)mar_quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)mar_isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)mar_isLeapYear
{
    NSUInteger year = self.mar_year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)mar_isToday
{
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].mar_day == self.mar_day;
}

- (BOOL)mar_isYesterday
{
    NSDate *added = [self mar_dateByAddingDays:1];
    return [added mar_isToday];
}

- (NSDate *)mar_dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)mar_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)mar_dateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekday:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)mar_dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)mar_dateByAddingHours:(NSInteger)hours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)mar_dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)mar_dateByAddingSeconds:(NSInteger)seconds {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSString *)mar_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)mar_stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

- (NSString *)mar_stringWithISOFormat
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter stringFromDate:self];
}

+ (NSDate *)mar_dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)mar_dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)mar_dateWithISOFormatString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter dateFromString:dateString];
}

@end

#define MARLocalizedString(key, comment) NSLocalizedString(key, comment)

@implementation NSDate (MAREX_briefTime)

+ (NSString *)mar_timeInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds {
    NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);
    if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
        if (!includeSeconds) {
            return intervalInMinutes <= 0 ? MARLocalizedString(@"刚刚", @"less than a minute") : MARLocalizedString(@"刚刚", @"1 minute");
        }
        if (intervalInSeconds >= 0 && intervalInSeconds < 5) {
            return [NSString stringWithFormat:MARLocalizedString(@"少于%d分钟", @"less than %d seconds"), 5];
        } else if (intervalInSeconds >= 5 && intervalInSeconds < 10) {
            return [NSString stringWithFormat:MARLocalizedString(@"少于%d分钟", @"less than %d seconds"), 10];
        } else if (intervalInSeconds >= 10 && intervalInSeconds < 20) {
            return [NSString stringWithFormat:@"少于%d分钟", 20];
        } else if (intervalInSeconds >= 20 && intervalInSeconds < 40) {
            return MARLocalizedString(@"刚刚", @"half a minute");
        } else if (intervalInSeconds >= 40 && intervalInSeconds < 60) {
            return MARLocalizedString(@"刚刚", @"less than a minute");
        } else {
            return MARLocalizedString(@"刚刚", @"1 minute");
        }
    } else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) {
        return [NSString stringWithFormat:MARLocalizedString(@"%ld分钟前", @"%d minutes"), (long)intervalInMinutes];
    } else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) {
        return MARLocalizedString(@"大约一小时前", @"about 1 hour");
    } else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) {
        return [NSString stringWithFormat:MARLocalizedString(@"大约%ld小时前", @"about %d hours"), (long)round(intervalInMinutes / 60.0f)];
    } else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
        return MARLocalizedString(@"一天前", @"1 day");
    } else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
        return [NSString stringWithFormat:MARLocalizedString(@"%ld天前", @"%d days"), (long)round(intervalInMinutes / 1440.0f)];
    } else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
        return MARLocalizedString(@"大约一个月前", @"about 1 month");
    } else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
        return [NSString stringWithFormat:MARLocalizedString(@"%ld月前", @"%d months"), (long)round(intervalInMinutes / 43200.0f)];
    } else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
        return MARLocalizedString(@"大约一年前", @"about 1 year");
    } else {
        return [NSString stringWithFormat:MARLocalizedString(@"超过%ld年", @"over %d years"), (long)round(intervalInMinutes / 525600.0f)];
    }
    return nil;
}


- (NSString *)mar_timeInWords {
    return [self mar_timeInWordsIncludingSeconds:YES];
}


- (NSString *)mar_timeInWordsIncludingSeconds:(BOOL)includeSeconds {
    return [[self class] mar_timeInWordsFromTimeInterval:fabs([self timeIntervalSinceNow]) includingSeconds:includeSeconds];
}


@end
