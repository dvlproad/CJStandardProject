//
//  STDemoLocationCityModel.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STDemoLocationCityModel : NSObject

@property (nonatomic, assign) NSInteger cityId;       //城市ID
@property (nonatomic, copy) NSString *name;         //城市名称

@property (nonatomic, copy) NSString *enName;       //英文名称
@property (nonatomic, copy) NSString *longtitude;   //经度
@property (nonatomic, copy) NSString *latitude;     //纬度
@property (nonatomic, assign) NSInteger provinceId;   //省份id
@property (nonatomic, copy) NSString *provinceName; //省份名称
@property (nonatomic, copy) NSString *status;       //状态名称
@property (nonatomic, copy) NSString *cityLevel;    //城市级别
@property (nonatomic, assign) NSInteger isBusiness;   //是否运营城市

@end
