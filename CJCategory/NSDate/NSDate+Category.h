//
//  NSDate+Category.h
//  Lee
//
//  Created by lichq on 14-12-16.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum DateDistanceType{
    eDistanceDay = 0,
    eDistanceMonth,
    eDistanceYear
}DateDistanceType;

@interface NSDate (Category)

- (NSString *)standString;

- (NSInteger)age;

- (NSString *)weekday;

- (NSDate *)today;
- (NSDate *)yesterday;
- (NSDate *)tomorrow;
- (NSDate *)dateDistances:(NSInteger )num type:(NSInteger)type;

/**
 *  计算从fromDate到当前时间的两个时间的天数差
 *
 *  @param fromDate    计算的开始时间
 *
 *  return 返回相差有多少天(如果是计算总共有多少天则需要加1)
 */
- (NSInteger)dayDistanceFromDate:(NSDate *)fromDate;

@end
