//
//  CJDemoServiceOrderManager.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/6.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "CJDemoServiceOrderManager.h"

@implementation CJDemoServiceOrderManager

+ (CJDemoServiceOrderManager *)sharedInstance {
    static CJDemoServiceOrderManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end
