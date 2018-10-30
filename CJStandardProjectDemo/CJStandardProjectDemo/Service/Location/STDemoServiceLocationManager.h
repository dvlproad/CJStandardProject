//
//  STDemoServiceLocationManager.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STDemoLocation.h"
#import "STDemoLocationCityModel.h"

@interface STDemoServiceLocationManager : NSObject {
    
}
@property (nonatomic, strong, readonly) STDemoLocation *serviceLocation;  /**< 服务的位置 */
@property (nonatomic, assign, readonly) BOOL locationServicesEnabled; /**< 是否开启定位服务 */
@property (nonatomic, assign, readonly) CLAuthorizationStatus authorizationStatus;  /**< 定位授权状态 */


+ (STDemoServiceLocationManager *)sharedInstance;

@end
