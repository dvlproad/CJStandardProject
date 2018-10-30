//
//  STDemoLoginVCFactory.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STDemoLoginVCFactory : NSObject

///登录页
+ (UIViewController *)loginViewController;

///忘记密码页
+ (UIViewController *)forgetPasswordViewController;

///修改密码页(初始密码时候需要)
+ (UIViewController *)changePasswordViewController;

///注册页
+ (UIViewController *)registerViewController;

@end
