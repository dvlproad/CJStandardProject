//
//  AppLog.m
//  Lee
//
//  Created by lichq on 14-12-6.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "AppLog.h"

//@implementation AppLog
//
//
//@end

#include <stdarg.h>

static NSString *logType[4]={@"DEBUG", @"TRACE", @"INFO", @"ERROR"};


void AppLog(int type, NSString *tag, NSString *format, ...) //tag即APPLOG_FL
{
    va_list ap;
    va_start(ap, format);
    
    NSString *string = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    
    NSLog(@"%@ %@: %@",logType[type], tag, string);
    
    /*
    NSString *output = [NSString stringWithFormat:@"%@ %@: %@", logType[type], tag, string];
    printf ("%s\n", [output cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    */
}
