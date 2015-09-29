//
//  AppLog.h
//  Lee
//
//  Created by lichq on 14-12-6.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface AppLog : NSObject
//
//@end

#define APPLOG_DEBUG  0
#define APPLOG_TRACE  1
#define APPLOG_INFO   2
#define APPLOG_ERROR  3

#define APPLOG_FL   [NSString stringWithFormat:@"%s:%d", __func__, __LINE__]

void AppLog(int type, NSString *tag, NSString *format, ...);


