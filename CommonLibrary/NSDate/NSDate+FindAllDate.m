//
//  NSDate+FindAllDate.m
//  Lee
//
//  Created by lichq on 15/4/9.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "NSDate+FindAllDate.h"

@implementation NSDate (FindAllDate)

- (NSMutableArray *)findAllDateFromDate:(NSDate *)startDate{
    NSDate *endDate = self;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    
    NSDateComponents *dCom0 = [calendar components:calendarUnit fromDate:startDate];
    NSInteger year0  = [dCom0 year];
    NSInteger month0 = [dCom0 month];
    NSInteger day0 = [dCom0 day];   //注意：day、month和year都是实际value值
    
    NSDateComponents *dCom1 = [calendar components:calendarUnit fromDate:endDate];
    NSInteger year1  = [dCom1 year];
    NSInteger month1 = [dCom1 month];
    NSInteger day1 = [dCom1 day];
    
    NSMutableArray *contentArray = [[NSMutableArray alloc]init];
    NSUInteger dayIndex = 0;
    
    for (int value_Y = year0; value_Y <= year1; value_Y++) {
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        
        [dateComponents setYear:year0 + value_Y];
        
        NSInteger start_M = 1;
        NSInteger end_M = 12;
        if (year1 == year0) {
            start_M = month0;
            end_M = month1;
        }else if (value_Y == year0){
            start_M = month0;
            end_M = 12;
        }else if (value_Y == year1){
            start_M = 1;
            end_M = month1;
        }
        
        for (int value_M = start_M; value_M <= end_M; value_M++) {
            [dateComponents setMonth:value_M];
            [dateComponents setDay:1];
            
            NSDate *tmpMonthFirstDay = [calendar dateFromComponents:dateComponents];
            
            NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:tmpMonthFirstDay];
            
            NSInteger start_D = 1;
            NSInteger end_D = range.length;
            if (month1 == month0) {
                start_D = day0;
                end_D = day1;
            }else if (value_M == month0){
                start_D = day0;
                end_D = range.length;
            }else if (value_M == month1){
                start_D = 1;
                end_D = day1;
            }
            for (NSUInteger value_D = start_D; value_D <= end_D; value_D++ ) { //range.length该月天数
                
                NSNumber *xVal = @(dayIndex);
                
                //TODO增加了几个字段，比如day字段
                BOOL isFirstDay = value_D == 1;
                BOOL isMiddleDayInMonth = value_D == (range.length - 0)/2;
                BOOL isFirstMonth = value_M == 1;
                [contentArray addObject:
                 @{ @"x"         :xVal,
                    @"value_D"   :[NSNumber numberWithInt:value_D],
                    @"isFirstDay":[NSNumber numberWithBool:isFirstDay],
                    @"isMiddleDayInMonth":[NSNumber numberWithBool:isMiddleDayInMonth],
                    @"value_M"   :[NSNumber numberWithInt:value_M],
                    @"isFirstMonth":[NSNumber numberWithBool:isFirstMonth],
                    @"value_Y"   :[NSNumber numberWithInt:value_Y]}];
                
                
                dayIndex += 1;
            }
        }
    }
    NSLog(@"现在总共有%d天", dayIndex);
    
    return contentArray;
}




@end
