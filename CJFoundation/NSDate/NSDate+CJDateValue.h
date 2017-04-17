//
//  NSDate+CJDateValue.h
//  CJFoundationDemo
//
//  Created by lichq on 14-12-16.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CJDateValue)

/**
 *  将NSDate转化成标准字符串NSString
 */
- (NSString *)cj_standString;

/**
 *  该日期是星期几
 */
- (NSString *)cj_weekdayString;


@end
