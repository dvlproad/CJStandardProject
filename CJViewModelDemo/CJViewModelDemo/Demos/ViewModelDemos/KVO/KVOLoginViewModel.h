//
//  KVOLoginViewModel.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  KVOLoginViewModel处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@interface KVOLoginViewModel : NSObject {
    
}
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) BOOL userNameValid;
@property (nonatomic, assign) BOOL passwordValid;
@property (nonatomic, assign) BOOL loginValid;
//@property (nonatomic, copy, readonly) void (^tryFailureBlock)(NSString *tryFailureMessage);
//@property (nonatomic, copy, readonly) void (^loginStartBlock)(NSString *startMessage);
//@property (nonatomic, copy, readonly) void (^loginSuccess)(NSString *successMessage);
//@property (nonatomic, copy, readonly) void (^loginFailure)(NSString *errorMessage);
@property (nonatomic, copy, readonly) NSString *tryFailureMessage;
@property (nonatomic, copy, readonly) NSString *startMessage;
@property (nonatomic, copy, readonly) NSString *successMessage;
@property (nonatomic, copy, readonly) NSString *errorMessage;

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;

#pragma mark - Do
- (void)login;

@end
