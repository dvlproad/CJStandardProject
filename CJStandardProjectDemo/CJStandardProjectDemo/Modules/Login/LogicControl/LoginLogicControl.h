//
//  LoginLogicControl.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  LoginLogicControl处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@protocol LoginLogicControlDelegate <NSObject>

/// userName 的有效性发生变化
- (void)vm_checkUserNameWithValid:(BOOL)valid;

/// password 的有效性发生变化
- (void)vm_checkPasswordWithValid:(BOOL)valid;

/// 登录按钮 的有效性发生变化
- (void)vm_checkLoginWithValid:(BOOL)valid;

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
- (void)loginWithTryFailure:(void (^)(NSString *tryFailureMessage))tryFailureBlock
                 loginStart:(void (^)(NSString *startMessage))loginStartBlock
               loginSuccess:(void (^)(NSString *successMessage))loginSuccess
               loginFailure:(void (^)(NSString *errorMessage))loginFailure;

@end
