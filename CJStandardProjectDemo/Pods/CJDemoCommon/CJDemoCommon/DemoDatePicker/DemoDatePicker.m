//
//  DemoDatePicker.m
//  CJTotalDemo
//
//  Created by ciyouzen on 2017/11/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoDatePicker.h"

@implementation DemoDatePicker

+ (CJDefaultDatePicker *)createBirthdayPicker
{
    NSDateFormatter *birthdayDateFormatter = [[NSDateFormatter alloc] init];
    //NSDateFormatter *birthdayDateFormatter = [CJDateFormatterUtil sharedInstance].dateFormatter;
    //birthdayDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
    
    CJDefaultDatePicker *birthdayPicker = [[CJDefaultDatePicker alloc] init];
    
    //为 birthdayPicker 添加 toolbar
    CJDefaultToolbar *toolbar = [[CJDefaultToolbar alloc] initWithFrame:CGRectZero];
    toolbar.option = CJDefaultToolbarOptionConfirm | CJDefaultToolbarOptionValue | CJDefaultToolbarOptionCancel;
    [birthdayPicker addToolbar:toolbar];
    
    /* 设置 birthdayPicker 的回调 */
    [birthdayPicker setValueChangedHandel:^(UIDatePicker *datePicker) {
        UIDatePicker *m_datePicker = datePicker;
        
        NSDate *date = m_datePicker.date;
        NSDate *maximumDate = m_datePicker.maximumDate;
        NSDate *minimumDate = m_datePicker.minimumDate;
        
        NSTimeZone *zone =[NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        NSDate *localDate =[date dateByAddingTimeInterval: interval];
        
        NSLog(@"1当前选择:%@", localDate);
        
        if ([date compare:minimumDate] == NSOrderedAscending) {
            NSLog(@"当前选择日期太小");
        }else if ([date compare:maximumDate] == NSOrderedDescending) {
            NSLog(@"当前选择日期太大");
        }
        
        NSString *dateString = [birthdayDateFormatter stringFromDate:localDate];
        [toolbar updateShowingValue:dateString];
    }];
    
    birthdayPicker.datePicker.datePickerMode = UIDatePickerModeDate;
    birthdayPicker.datePicker.maximumDate = [NSDate date];
    birthdayPicker.datePicker.minimumDate = [birthdayDateFormatter dateFromString:@"1900-01-01"];;
    
    return birthdayPicker;
}

@end
