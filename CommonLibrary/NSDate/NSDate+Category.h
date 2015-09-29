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


- (NSInteger)dayDistanceFromDate:(NSDate *)fromDate;

@end
