//
//  CTMediator+CJDemoModuleLogin.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/3/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <CTMediator/CTMediator.h>

@interface CTMediator (CJDemoModuleLogin)

/**
 *  返回"引导控制器"
 *
 *  @param params        引导控制器所需要的参数
 *
 *  @return 引导控制器
 */
- (UIViewController *)cjDemo_guideViewControllerWithParams:(NSDictionary *)params;

/**
 *  返回"引导进行登录或登录的控制器"（如一个页面点击'登录'进入登录页，点击'注册'进入注册页）
 *
 *  @param params        引导进行登录或注册控制器所需要的参数
 *
 *  @return 引导进行登录或登录的控制器
 */
- (UIViewController *)cjDemo_guideMainViewControllerWithParams:(NSDictionary *)params;

/**
 *  返回"登录控制器"
 *
 *  @param params        登录控制器所需要的参数
 *
 *  @return 登录控制器
 */
- (UIViewController *)cjDemo_loginViewControllerWithParams:(NSDictionary *)params;

- (UIViewController *)cjDemo_forgetPasswordViewControllerWithParams:(NSDictionary *)params;

- (UIViewController *)cjDemo_registerViewControllerWithParams:(NSDictionary *)params;

///修改密码页(初始密码时候需要)
- (UIViewController *)cjDemo_changePasswordViewControllerWithParams:(NSDictionary *)params;

@end
