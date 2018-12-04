//
//  MidRACLoginViewModel.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  MidRACLoginViewModel处理逻辑

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface MidRACLoginViewModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

// 属性要用来监听的话，要确保其setter会被调用
@property (nonatomic, assign) BOOL userNameValid;
@property (nonatomic, assign) BOOL passwordValid;
@property (nonatomic, assign) BOOL loginValid;
//@property (nonatomic, strong) RACSubject *userNameValidObject;
//@property (nonatomic, strong) RACSubject *passwordValidObject;
//@property (nonatomic, strong) RACSubject *loginValidObject;

@property (nonatomic, strong) RACSubject *tryFailureObject;
@property (nonatomic, strong) RACSubject *startObject;
@property (nonatomic, strong) RACSubject *successObject;
@property (nonatomic, strong) RACSubject *failureObject;
//@property (nonatomic, strong) RACSubject *errorObject;

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;

#pragma mark - Do
- (void)login;

@end
