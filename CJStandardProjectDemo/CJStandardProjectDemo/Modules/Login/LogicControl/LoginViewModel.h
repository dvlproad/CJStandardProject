//
//  LoginViewModel.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  LoginLogicControl处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@protocol LoginViewModelDelegate <NSObject>

///登录按钮的enable发生变化需要更新按钮显示
- (void)view_loginButtonEnableChange:(BOOL)enable;

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
- (void)loginWitLoginSuccess:(void (^)(NSString *successMessage))loginSuccess
                loginFailure:(void (^)(NSString *errorMessage))loginFailure;

@end
