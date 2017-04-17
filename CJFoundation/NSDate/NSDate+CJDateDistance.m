//
//  NSDate+CJDateDistance.m
//  CJFoundationDemo
//
//  Created by lichq on 14-12-16.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "NSDate+CJDateDistance.h"

@implementation NSDate (CJDateDistance)

- (NSDate *)cj_yesterday {
    return [self cj_dateDistance:-1 calculateUnit:NSCalendarUnitDay];
}

- (NSDate *)cj_tomorrow {
    return [self cj_dateDistance:1 calculateUnit:NSCalendarUnitDay];
}

/** 完整的描述请参见文件头部 */
- (NSDate *)cj_dateDistance:(NSInteger )distanceValue calculateUnit:(NSCalendarUnit)calculateUnit {
    //日期转换 年月日
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:self];
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    NSInteger second = [dateComponents second];
    //NSLog(@"当前日期的年月日为：%d,%d,%d", year, month, day);
    
    switch (calculateUnit) {
        case NSCalendarUnitDay: {
            day += distanceValue;
            break;
        }
        case NSCalendarUnitMonth: {
            month += distanceValue;
            break;
        }
        case NSCalendarUnitYear: {
            year += distanceValue;
            break;
        }
        case NSCalendarUnitHour: {
            hour += distanceValue;
            break;
        }
        case NSCalendarUnitMinute: {
            minute += distanceValue;
            break;
        }
        case NSCalendarUnitSecond: {
            second += distanceValue;
            break;
        }
            
        default:
            break;
    }
    
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    [dateComponents setDay:hour];
    [dateComponents setDay:minute];
    [dateComponents setDay:second];
    
    [dateComponents setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    
    
    //NSLog(@"newDate = %@",[self standString]);
    
    return newDate;
}

/** 完整的描述请参见文件头部 */
- (NSInteger)cj_age {
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    NSLog(@"计算出的年纪为%zd", iAge);
    NSInteger iAge2 = [[NSDate date] cj_countDistanceFromDate:self calculateUnit:NSCalendarUnitYear];
    NSLog(@"计算出的年纪为%zd", iAge2);
    
    return iAge;
}


/** 完整的描述请参见文件头部 */
- (NSInteger)cj_countDistanceFromDate:(NSDate *)fromDate calculateUnit:(NSCalendarUnit)calculateUnit {
    //*//方法①：
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger count = 0;
    switch (calculateUnit) {
        case NSCalendarUnitDay: {
            NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:self options:0];
            count = [components day];
            break;
        }
        case NSCalendarUnitMonth: {
            NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:fromDate toDate:self options:0];
            count = [components month];
            break;
        }
        case NSCalendarUnitYear: {
            NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:fromDate toDate:self options:0];
            count = [components year];
            break;
        }
        case NSCalendarUnitHour: {
            NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:fromDate toDate:self options:0];
            count = [components hour];
            break;
        }
        case NSCalendarUnitMinute: {
            NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:fromDate toDate:self options:0];
            count = [components minute];
            break;
        }
        case NSCalendarUnitSecond: {
            NSDateComponents *components = [calendar components:NSCalendarUnitSecond fromDate:fromDate toDate:self options:0];
            count = [components second];
            break;
        }
            
        default:
            break;
    }
    //*/
    
    /* //方法②：计算出相差多少秒，再根据秒来计算
     NSTimeInterval timeInterval = [self timeIntervalSinceDate:fromDate];
     
     NSInteger count = timeInterval/60/60/24;
     */
    
    return count;
}


@end
