//
//  DemoLocation.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DemoLocation : NSObject

@property (nonatomic, strong, readonly) CLLocation *location;

- (instancetype)initWithLocation:(CLLocation *)location;

@end
