//
//  LoginLogicControl.m
//  CJDemoModuleLoginDemo
//
//  Created by 李超前 on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LoginLogicControl.h"
#import "CJDemoServiceUserManager+Network.h"
#import "CJDemoServiceUserManager+UserTable.h"
#import <CJBaseUtil/CJAppLastUtil.h>

@interface LoginLogicControl () {
    
}

@property (nonatomic, copy) UIViewController *vc;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@end


@implementation LoginLogicControl

#pragma mark - Get Default
- (NSString *)getDefaultLoginAccount {
    NSString *account = [CJAppLastUtil getLastLoginAccount];
    return account;
}

- (NSString *)getDefaultPasswordForUserName:(NSString *)userName {
    NSString *password = [CJAppLastUtil getKeychainPasswordForAccount:userName];
    return password;
}




#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    [self checkAllowClickLoginButton];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    [self checkAllowClickLoginButton];
}

///检查是否允许点击登录按钮
- (void)checkAllowClickLoginButton {
    BOOL loginUserNameEnable = self.userName.length >= 4;
    BOOL loginPasswordEnable = self.password.length >= 4;

    BOOL allowClickLoginButton = loginUserNameEnable && loginPasswordEnable;
    //NSLog(@"allowClickLoginButton = %@, %@, %@", allowClickLoginButton ? @"YES" : @"NO", self.userName, self.password);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_LoginButtonEnableChange:)]) {
        [self.delegate logic_LoginButtonEnableChange:allowClickLoginButton];
    }
}

#pragma mark - Do
///**
// *  登录并进入首页(有主页登录、个人中心登录等,包含是否允许进行登录，登陆成功后进入什么页面等逻辑处理)
// *
// *  @param account                          用户信息--用户名
// *  @param password                         用户信息--用户密码
// *  @param goMainViewController             进入主页
// *  @param backMainViewController           回到主页(游客模式下会有该功能)
// */
//- (void)loginWithAccount:(NSString *)account
//                password:(NSString *)password
//    goMainViewController:(void (^)(void))goMainViewController
//  backMainViewController:(void (^)(void))backMainViewController
///执行登录
- (void)login
{
    NSString *account = self.userName;
    NSString *password = self.password;
    
    NSString *failureMessage = [self checkLoginConditionByAccount:account password:password];
    if (failureMessage) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_tryLoginFailureWithMessage:)]) {
            [self.delegate logic_tryLoginFailureWithMessage:failureMessage];
        }
        
        return;
    }
    
    NSString *loginingText = NSLocalizedString(@"正在登录", nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_startLoginWithMessage:)]) {
        [self.delegate logic_startLoginWithMessage:loginingText];
    }
    
    
    
    
    
    
    
    [[CJDemoServiceUserManager sharedInstance] requestLoginWithAccount:account password:password success:^(id responseObject) {
        
        NSInteger status = [responseObject[@"status"] integerValue];
        if (status != 0) {
            NSString *loginFailureMessage = NSLocalizedString(@"登录失败", nil);
            if (self.delegate && [self.delegate respondsToSelector:@selector(logic_loginFailureWithMessage:)]) {
                [self.delegate logic_loginFailureWithMessage:loginFailureMessage];
            }
            return;
        }
        
        //登录成功
        NSDictionary *result = responseObject[@"result"];
        DemoUser *user = [[DemoUser alloc] initWithUserDictionary:result];
        
        //登录成功后，要执行的基本操作(服务器基本上回返回用户的一些基本信息)
        //需要管理监控"服务的用户"的信息变化，所以先通过单例，放在内存中管理，同时支持数据库管理；
        //其他，如需要管理监控"服务的订单表"的信息变化，也是一样的处理放啊。
        [CJDemoServiceUserManager sharedInstance].serviceUser = [user copy];
        [[CJDemoServiceUserManager sharedInstance] insertAccountInfo:user];
        [CJAppLastUtil saveAccount:account withPassword:password];
        
        
        NSString *loginSuccessMessage = NSLocalizedString(@"登录成功", nil);
    
        CJRootViewControllerType rootViewControllerType = [CJAppLastUtil getLastRootViewControllerTypeWithDistinctAppVersion:YES];
        if (rootViewControllerType == CJRootViewControllerTypeMain) {
            //[self.navigationController popViewControllerAnimated:YES];
            if (self.delegate && [self.delegate respondsToSelector:@selector(logic_loginSuccessAndBackMainViewControllerWithMessage:)]) {
                [self.delegate logic_loginSuccessAndBackMainViewControllerWithMessage:loginSuccessMessage];
            }
            
        } else {
            [CJAppLastUtil saveLastAppInfoWithRootViewControllerType:CJRootViewControllerTypeMain otherParams:nil]; //此时进入了Main
            
            //NSDictionary *params = nil;
            //UIViewController *mainViewControllerWithParams = [[CTMediator sharedInstance] cjDemo_mainViewControllerWithParams:params];
            //[UIApplication sharedApplication].delegate.window.rootViewController = mainViewControllerWithParams;
            if (self.delegate && [self.delegate respondsToSelector:@selector(logic_loginSuccessAndGoMainViewControllerWithMessage:)]) {
                [self.delegate logic_loginSuccessAndGoMainViewControllerWithMessage:loginSuccessMessage];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        //NSString *loginFailureMessage = NSLocalizedString(@"登录失败", nil);
        NSString *loginFailureMessage = [NSString stringWithFormat:@"密码错误:试下通用密码%@", DemoGeneralPassword];
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_loginFailureWithMessage:)]) {
            [self.delegate logic_loginFailureWithMessage:loginFailureMessage];
        }
    }];
}

- (NSString *)checkLoginConditionByAccount:(NSString *)account
                                  password:(NSString *)password {
    BOOL loginUserNameEnable = account.length >= 4;
    BOOL loginPasswordEnable = password.length >= 4;
    
    BOOL loginButtonEnable = loginUserNameEnable && loginPasswordEnable;
    if (!loginButtonEnable) {
        return NSLocalizedString(@"请完善登录信息", nil);
    }
    
    return nil;
}



@end
