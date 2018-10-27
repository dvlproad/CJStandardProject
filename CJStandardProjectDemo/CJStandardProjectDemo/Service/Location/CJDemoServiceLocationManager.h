//
//  CJDemoServiceLocationManager.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoLocation.h"
#import "DemoLocationCityModel.h"

@interface CJDemoServiceLocationManager : NSObject {
    
}
@property (nonatomic, strong, readonly) DemoLocation *serviceLocation;  /**< 服务的位置 */
@property (nonatomic, assign, readonly) BOOL locationServicesEnabled; /**< 是否开启定位服务 */
@property (nonatomic, assign, readonly) CLAuthorizationStatus authorizationStatus;  /**< 定位授权状态 */


+ (CJDemoServiceLocationManager *)sharedInstance;

@end
