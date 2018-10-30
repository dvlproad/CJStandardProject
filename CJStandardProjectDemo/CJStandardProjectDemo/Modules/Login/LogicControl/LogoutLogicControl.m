//
//  LogoutLogicControl.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LogoutLogicControl.h"
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"
#import <CJBaseUtil/CJAppLastUtil.h>

@interface LogoutLogicControl () {
    
}

@end


@implementation LogoutLogicControl

#pragma mark - Get Default


#pragma mark - Update


#pragma mark - Do
///执行退出
- (void)logout
{
    NSString *uid = [STDemoServiceUserManager sharedInstance].serviceUser.uid;
    
    NSString *failureMessage = [self checkLogoutConditionByUid:uid];
    if (failureMessage) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_tryLogoutFailureWithMessage:)]) {
            [self.delegate logic_tryLogoutFailureWithMessage:failureMessage];
        }
        
        return;
    }
    
    NSString *loginingText = NSLocalizedString(@"正在退出", nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_startLogoutWithMessage:)]) {
        [self.delegate logic_startLogoutWithMessage:loginingText];
    }
    
    
    [[STDemoServiceUserManager sharedInstance] requestLogoutWithSuccess:^(CJDemoResponseModel *responseModel) {
        NSInteger status = responseModel.status;
        if (status != 0) {
            NSString *loginFailureMessage = NSLocalizedString(@"退出失败", nil);
            if (self.delegate && [self.delegate respondsToSelector:@selector(logic_logoutFailureWithMessage:)]) {
                [self.delegate logic_logoutFailureWithMessage:loginFailureMessage];
            }
            return;
        }
        
        //退出成功
        //退出成功后，要执行的基本操作(服务器基本上回返回用户的一些基本信息)
        //需要管理监控"服务的用户"的信息变化，所以先通过单例，放在内存中管理，同时支持数据库管理；
        //其他，如需要管理监控"服务的订单表"的信息变化，也是一样的处理放啊。
        [STDemoServiceUserManager sharedInstance].serviceUser = nil;
        [CJAppLastUtil deleteAccountFromKeychain:uid];
        
        NSString *logoutSuccessMessage = NSLocalizedString(@"退出成功", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_logoutSuccessWithMessage:)]) {
            [self.delegate logic_logoutSuccessWithMessage:logoutSuccessMessage];
        }
        
    } failure:^(NSString *errorMessage) {
        NSString *logoutFailureMessage = NSLocalizedString(@"退出失败", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_logoutFailureWithMessage:)]) {
            [self.delegate logic_logoutFailureWithMessage:logoutFailureMessage];
        }
    }];
}

- (NSString *)checkLogoutConditionByUid:(NSString *)uid {
//    BOOL loginUserNameEnable = account.length >= 4;
//    BOOL loginPasswordEnable = password.length >= 4;
//
//    BOOL loginButtonEnable = loginUserNameEnable && loginPasswordEnable;
//    if (!loginButtonEnable) {
//        return NSLocalizedString(@"请完善登录信息", nil);
//    }
    
    return nil;
}



@end
