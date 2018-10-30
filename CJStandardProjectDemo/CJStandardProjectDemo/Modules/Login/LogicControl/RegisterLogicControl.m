//
//  RegisterLogicControl.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "RegisterLogicControl.h"
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"
#import <CJBaseUtil/CJAppLastUtil.h>

@interface RegisterLogicControl () {
    
}
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *email;

@end


@implementation RegisterLogicControl

#pragma mark - Get Default



#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    [self checkAllowClickRegisterButton];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    [self checkAllowClickRegisterButton];
}

- (void)updateEmail:(NSString *)email {
    _email = email;
    [self checkAllowClickRegisterButton];
}

///检查是否允许点击注册按钮
- (void)checkAllowClickRegisterButton {
    BOOL registerUserNameEnable = self.userName.length >= 4;
    BOOL registerPasswordEnable = self.password.length >= 4;
    BOOL registerEmailEnable = self.email.length >= 4;

    BOOL allowClickLoginButton = registerUserNameEnable && registerPasswordEnable && registerEmailEnable;
    //NSLog(@"allowClickLoginButton = %@, %@, %@", allowClickLoginButton ? @"YES" : @"NO", self.userName, self.password);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_registerButtonEnableChange:)]) {
        [self.delegate logic_registerButtonEnableChange:allowClickLoginButton];
    }
}

#pragma mark - Do
///执行注册
- (void)didRegister
{
    NSString *account = self.userName;
    NSString *password = self.password;
    NSString *email = self.email;
    
    NSString *failureMessage = [self checkRegisterConditionByAccount:account password:password email:email];
    if (failureMessage) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_tryRegisterFailureWithMessage:)]) {
            [self.delegate logic_tryRegisterFailureWithMessage:failureMessage];
        }
        
        return;
    }
    
    NSString *loginingText = NSLocalizedString(@"正在注册", nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_startRegisterWithMessage:)]) {
        [self.delegate logic_startRegisterWithMessage:loginingText];
    }
    
    
    
    [[STDemoServiceUserManager sharedInstance] requestRegisterWithAccount:account password:password email:email success:^(id  _Nullable responseObject) {
        NSInteger status = [responseObject[@"status"] integerValue];
        if (status != 0) {
            NSString *loginFailureMessage = NSLocalizedString(@"注册失败", nil);
            if (self.delegate && [self.delegate respondsToSelector:@selector(logic_registerFailureWithMessage:)]) {
                [self.delegate logic_registerFailureWithMessage:loginFailureMessage];
            }
            return;
        }
        
//        //登录成功
//        NSDictionary *result = responseObject[@"result"];
//        STDemoUser *user = [[STDemoUser alloc] initWithUserDictionary:result];
//
//        //登录成功后，要执行的基本操作(服务器基本上回返回用户的一些基本信息)
//        //需要管理监控"服务的用户"的信息变化，所以先通过单例，放在内存中管理，同时支持数据库管理；
//        //其他，如需要管理监控"服务的订单表"的信息变化，也是一样的处理放啊。
//        [STDemoServiceUserManager sharedInstance].serviceUser = [user copy];
//        [[STDemoServiceUserManager sharedInstance] insertAccountInfo:user];
//        [CJAppLastUtil saveAccount:account withPassword:password];
        
        NSString *loginSuccessMessage = NSLocalizedString(@"注册成功", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_registerSuccessWithMessage:)]) {
            [self.delegate logic_registerSuccessWithMessage:loginSuccessMessage];
        }
        
    } failure:^(NSString *errorMessage) {
        NSString *registerFailureMessage = NSLocalizedString(@"注册失败", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_registerFailureWithMessage:)]) {
            [self.delegate logic_registerFailureWithMessage:registerFailureMessage];
        }
    }];
}

- (NSString *)checkRegisterConditionByAccount:(NSString *)account
                                     password:(NSString *)password
                                        email:(NSString *)email
{
    BOOL registerUserNameEnable = account.length >= 4;
    BOOL registerPasswordEnable = password.length >= 4;
    BOOL registerEmailEnable = email.length >= 4;
    
    BOOL registerButtonEnable = registerEmailEnable && registerUserNameEnable && registerPasswordEnable;
    //NSLog(@"%@, %@, %@, %@", registerButtonEnable ? @"YES" : @"NO", self.email, self.userName, self.password);
    if (!registerButtonEnable) {
        return NSLocalizedString(@"请完善注册信息", nil);
    }
    
    return nil;
}



@end
