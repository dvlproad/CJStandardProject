//
//  STDemoLocation.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface STDemoLocation : NSObject

@property (nonatomic, strong, readonly) CLLocation *location;

- (instancetype)initWithLocation:(CLLocation *)location;

@end
