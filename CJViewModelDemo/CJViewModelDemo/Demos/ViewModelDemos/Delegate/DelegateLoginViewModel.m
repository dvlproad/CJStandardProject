//
//  DelegateLoginViewModel.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DelegateLoginViewModel.h"
#import "NSString+STDemoValidate.h"
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"

@interface DelegateLoginViewModel () {
    
}
@property (nonatomic, assign, readonly) BOOL userNameValid;
@property (nonatomic, assign, readonly) BOOL passwordValid;
@property (nonatomic, assign, readonly) BOOL loginValid;

@end


@implementation DelegateLoginViewModel

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
    }
    return self;
}

//- (void)setDelegate:(id<DelegateLoginViewModelDelegate>)delegate {
//    _delegate = delegate;
//    
//    [self checkUserNameValid];
//    [self checkPasswordValid];
//}


#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    _userNameValid = [self.userName stdemo_checkUserName];
    _loginValid = self.userNameValid && self.passwordValid;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_checkUserNameWithValid:)]) {
        [self.delegate vm_checkUserNameWithValid:self.userNameValid];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_checkLoginWithValid:)]) {
        [self.delegate vm_checkLoginWithValid:self.loginValid];
    }
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    _passwordValid = [self.password stdemo_checkPassword];
    _loginValid = self.userNameValid && self.passwordValid;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_checkPasswordWithValid:)]) {
        [self.delegate vm_checkPasswordWithValid:self.passwordValid];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_checkLoginWithValid:)]) {
        [self.delegate vm_checkLoginWithValid:self.loginValid];
    }
}

#pragma mark - Do
///执行登录
- (void)login
{
    if (!self.loginValid) {
        NSString *tryFailureMessage = NSLocalizedString(@"请完善登录信息", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(vm_tryLoginFailureWithMessage:)]) {
            [self.delegate vm_tryLoginFailureWithMessage:tryFailureMessage];
        }
        
        return;
    }
    
    NSString *startMessage = NSLocalizedString(@"正在登录", nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_startLoginWithMessage:)]) {
        [self.delegate vm_startLoginWithMessage:startMessage];
    }
    
    NSString *account = self.userName;
    NSString *password = self.password;
    [[STDemoServiceUserManager sharedInstance] requestLoginWithAccount:account password:password success:^(STDemoUser *user) {
        NSString *loginSuccessMessage = NSLocalizedString(@"登录成功", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(vm_loginSuccessWithMessage:)]) {
            [self.delegate vm_loginSuccessWithMessage:loginSuccessMessage];
        }
        
    } failure:^(NSString *errorMessage) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(vm_loginFailureWithMessage:)]) {
            [self.delegate vm_loginFailureWithMessage:errorMessage];
        }
    }];
}


@end
