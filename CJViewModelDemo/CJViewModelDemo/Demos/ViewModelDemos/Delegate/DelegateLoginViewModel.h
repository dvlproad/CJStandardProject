//
//  DelegateLoginViewModel.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  DelegateLoginViewModel处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@protocol DelegateLoginViewModelDelegate <NSObject>

/// userName 的有效性发生变化
- (void)vm_checkUserNameWithValid:(BOOL)valid;

/// password 的有效性发生变化
- (void)vm_checkPasswordWithValid:(BOOL)valid;

/// 登录按钮 的有效性发生变化
- (void)vm_checkLoginWithValid:(BOOL)valid;

///尝试登录时候，未满足条件时候
- (void)vm_tryLoginFailureWithMessage:(NSString *)message;

///开始登录时候更新视图显示提示信息
- (void)vm_startLoginWithMessage:(NSString *)message;

///登录成功更新视图显示提示信息
- (void)vm_loginSuccessWithMessage:(NSString *)message;

///登录失败更新视图显示提示信息
- (void)vm_loginFailureWithMessage:(NSString *)message;

@end



@interface DelegateLoginViewModel : NSObject {
    
}
@property (nonatomic, weak) id<DelegateLoginViewModelDelegate> delegate;
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;

#pragma mark - Do
- (void)login;

@end
