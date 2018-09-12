//
//  LoginLogicControl.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  LoginLogicControl处理逻辑

#import <Foundation/Foundation.h>
#import "CJDemoServiceUserManager.h"

@protocol LoginLogicControlDelegate <NSObject>

///登录按钮的enable发生变化需要更新按钮显示
- (void)logic_LoginButtonEnableChange:(BOOL)enable;

///尝试登录时候，未满足条件时候
- (void)logic_tryLoginFailureWithMessage:(NSString *)message;

///开始登录时候更新视图显示提示信息
- (void)logic_startLoginWithMessage:(NSString *)message;

///登录成功需要进入主页
- (void)logic_loginSuccessAndGoMainViewControllerWithMessage:(NSString *)message;

///登录成功需要回到主页
- (void)logic_loginSuccessAndBackMainViewControllerWithMessage:(NSString *)message;

///登录失败更新视图显示提示信息
- (void)logic_loginFailureWithMessage:(NSString *)message;

@end



@interface LoginLogicControl : NSObject {
    
}
@property (nonatomic, weak) id<LoginLogicControlDelegate> delegate;

#pragma mark - Get Default
- (NSString *)getDefaultLoginAccount;
- (NSString *)getDefaultPasswordForUserName:(NSString *)userName;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;

#pragma mark - Do
///执行登录
- (void)login;

@end
