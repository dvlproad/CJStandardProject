//
//  RegisterViewModel.h
//  CJTotalDemo
//
//  Created by ciyouzen on 2017/11/8.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterViewModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) void (^registerButtonEnableChangeBlock)(BOOL loginButtonEnable);

@property (nonatomic, copy) void (^successBlock)(BOOL registerSuccess, NSString *successMessage);
@property (nonatomic, copy) void (^failureBlock)(NSString *errorMessage);
@property (nonatomic, copy) void (^errorBlock)( NSError *error);

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;
- (void)updateEmail:(NSString *)email;

#pragma mark - Do
/// 检查是否可注册
- (NSString *)checkRegisterCondition;

/// 执行注册
- (void)didRegister;


@end
