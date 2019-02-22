//
//  LoginViewModel.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  LoginViewModel处理逻辑

#import <Foundation/Foundation.h>
#import "CJDemoServiceUserManager.h"

@protocol LoginViewModelDelegate <NSObject>

/// userName 的有效性发生变化
- (void)logic_checkUserNameWithValid:(BOOL)valid;

/// password 的有效性发生变化
- (void)logic_checkPasswordWithValid:(BOOL)valid;

/// 登录按钮 的有效性发生变化
- (void)logic_checkLoginWithValid:(BOOL)valid;

@end



@interface LoginViewModel : NSObject {
    
}
@property (nonatomic, weak) id<LoginViewModelDelegate> delegate;
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;

#pragma mark - Do
/// 检查是否可登录
- (NSString *)checkLoginCondition;

/// 执行登录
- (void)loginWitLoginSuccess:(void (^)(NSString *successMessage, DemoUser *user))loginSuccess
                loginFailure:(void (^)(NSString *errorMessage))loginFailure;

@end
