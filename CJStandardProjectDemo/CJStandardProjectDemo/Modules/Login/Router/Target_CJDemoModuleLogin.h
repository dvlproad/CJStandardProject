//
//  Target_CJDemoModuleLogin.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/3/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  外部可能需要用到本模块中的视图控制器，我们通过此类来提供

#import <UIKit/UIKit.h>

@interface Target_CJDemoModuleLogin : NSObject

///引导视图
- (UIViewController *)Action_guideViewController:(NSDictionary *)params;

///引导注册或登录视图
- (UIViewController *)Action_guideMainViewController:(NSDictionary *)params;

///登录视图
- (UIViewController *)Action_loginViewController:(NSDictionary *)params;

///修改密码页(初始密码时候需要)
- (UIViewController *)Action_changePasswordViewController:(NSDictionary *)params;

///注册页
- (UIViewController *)Action_registerViewController:(NSDictionary *)params;

///忘记密码页
- (UIViewController *)Action_forgetPasswordViewController:(NSDictionary *)params;

@end
