//
//  Target_STDemoLoginVCFactory.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明

#import <Foundation/Foundation.h>

@interface Target_STDemoLoginVCFactory : NSObject

///登录页
- (UIViewController *)Action_STDemo_loginViewController;

///忘记密码页
- (UIViewController *)Action_STDemo_forgetPasswordViewController;

///修改密码页(初始密码时候需要)
- (UIViewController *)Action_STDemo_changePasswordViewController;

///注册页
- (UIViewController *)Action_STDemo_registerViewController;

@end
