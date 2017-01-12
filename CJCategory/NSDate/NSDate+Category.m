//
//  NSDate+Category.m
//  Lee
//
//  Created by lichq on 14-12-16.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

#pragma mark - 将NSDate转化成标准字符串NSString
- (NSString *)standString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [dateFormatter stringFromDate:self];
    return string;
}

#pragma mark - 星期几
- (NSString *)weekday{
    //日期转换 年月日
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday; //这边要改成weekday
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:self];
    NSInteger weekday = [dateComponents weekday];
    
    NSString *weekdayString = nil;
    switch (weekday) {
        case 1:
            weekdayString = @"天";
            break;
        case 2:
            weekdayString = @"一";
            break;
        case 3:
            weekdayString = @"二";
            break;
        case 4:
            weekdayString = @"三";
            break;
        case 5:
            weekdayString = @"四";
            break;
        case 6:
            weekdayString = @"五";
            break;
        case 7:
            weekdayString = @"六";
            break;
        default:
            break;
    }
    return weekdayString;
}

#pragma mark - 今天
- (NSDate *)today{
    return [self dateDistances:0 type:eDistanceDay];
}

#pragma mark - 前一天
- (NSDate *)yesterday{
    return [self dateDistances:-1 type:eDistanceDay];
}

#pragma mark - 后一天
- (NSDate *)tomorrow{
    return [self dateDistances:1 type:eDistanceDay];
}

#pragma mark - 获取距离当前日期N天的日期
- (NSDate *)dateDistances:(NSInteger )num type:(NSInteger)type{
    //日期转换 年月日
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:self];
    NSInteger year  = [dateComponents year];
    NSInteger month = [dateComponents month];
    NSInteger day   = [dateComponents day];
    //NSLog(@"当前日期的年月日为：%d,%d,%d", year, month, day);
    
    if (type == eDistanceDay) {
        day += num;
    }else if(type == eDistanceMonth){
        month += num;
    }else if (type == eDistanceYear){
        year += num;
    }
    
    
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    
    
    //NSLog(@"newDate = %@",[self standString]);
    
    return newDate;
}

#pragma mark - 计算年龄,设计到月份(周岁计算)
- (NSInteger)age{
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
    
    return iAge;
}


#pragma mark - 计算两个时间的天数差
- (NSInteger)dayDistanceFromDate:(NSDate *)fromDate{
//    /* //方法①：
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlag = NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlag fromDate:fromDate toDate:self options:0];//beginDate
    NSInteger count = [components day] + 1;
//    */
    
    /* //方法②：
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:fromDate];
    
    NSInteger count = timeInterval/60/60/24;
    */
    
    
    return count;
}

@end
