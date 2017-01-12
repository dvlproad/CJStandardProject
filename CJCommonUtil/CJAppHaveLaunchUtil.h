//
//  CJAppHaveLaunchUtil.h
//  LibraryAndUtilDemo
//
//  Created by 李超前 on 2016/12/14.
//  Copyright © 2016年 ciyouzen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAppHaveLaunchUtil : NSObject

+ (CJAppHaveLaunchUtil *)sharedInstance;

/**
 *  是否已经登录过
 *
 *  reurn 是否已经启动过
 */
- (BOOL)isAPPHaveLaunch;

/**
 *  在启动一次之后将启动状态设为YES
 */
- (void)setAPPHaveLaunchStateYES;

@end
