//
//  BestBlockLoginViewModel.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  LoginLogicControl处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@interface BestBlockLoginViewModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;


#pragma mark - Update
- (void)setupUpdateUserNameCompleteBlock:(void (^)(BOOL userNameValid, BOOL loginValid))updateUserNameCompleteBlock
             updatePasswordCompleteBlock:(void (^)(BOOL passwordValid, BOOL loginValid))updatePasswordCompleteBlock;
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;

#pragma mark - Do
- (void)setupTryFailure:(void (^)(NSString *tryFailureMessage))tryFailureBlock
             loginStart:(void (^)(NSString *startMessage))loginStartBlock
           loginSuccess:(void (^)(NSString *successMessage))loginSuccess
           loginFailure:(void (^)(NSString *errorMessage))loginFailure;
- (void)login;

@end
