//
//  STDemoLocation.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "STDemoLocation.h"

@implementation STDemoLocation

- (instancetype)initWithLocation:(CLLocation *)location {
    self = [super init];
    if (self) {
        _location = location;
    }
    return self;
}

@end
