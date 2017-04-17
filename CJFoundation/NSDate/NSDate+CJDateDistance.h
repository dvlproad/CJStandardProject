//
//  NSDate+CJDateDistance.h
//  CJFoundationDemo
//
//  Created by lichq on 14-12-16.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (CJDateDistance)

- (NSDate *)cj_yesterday;
- (NSDate *)cj_tomorrow;

- (NSInteger)cj_age;

/**
 *  获取距离本日期多少个单位的日期
 *
 *  @param distanceValue    多少个单位
 *  @param calculateUnit    计算的单位
 */
- (NSDate *)cj_dateDistance:(NSInteger )distanceValue calculateUnit:(NSCalendarUnit)calculateUnit;


/**
 *  计算从fromDate到本时间，两个时间的天数差（附：如果是计算总共有多少单位则需要加1）
 *
 *  @param fromDate         计算的开始时间
 *  @param calculateUnit    计算的单位
 *
 *  return 返回相差有多少单位
 */
- (NSInteger)cj_countDistanceFromDate:(NSDate *)fromDate calculateUnit:(NSCalendarUnit)calculateUnit;

@end
