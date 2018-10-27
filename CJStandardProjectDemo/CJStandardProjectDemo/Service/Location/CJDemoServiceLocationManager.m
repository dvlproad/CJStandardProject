//
//  CJDemoServiceLocationManager.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoServiceLocationManager.h"

@implementation CJDemoServiceLocationManager

+ (CJDemoServiceLocationManager *)sharedInstance {
    static CJDemoServiceLocationManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end
