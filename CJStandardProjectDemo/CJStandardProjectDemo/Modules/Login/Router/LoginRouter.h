//
//  LoginRouter.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  界面跳转

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoginRouter : NSObject

///进入主页
+ (void)goMainViewController;

///进入"忘记密码"界面
+ (void)goFindPasswordViewControllerFrom:(UIViewController *)fromViewController;

///进入"修改密码"界面(初始密码时候需要)
+ (void)goChangePasswordViewControllerFrom:(UIViewController *)fromViewController;

///进入"注册"界面
+ (void)goRegisterViewControllerFrom:(UIViewController *)fromViewController;

@end
