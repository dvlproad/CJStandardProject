//
//  FindPasswordLogicControl.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "FindPasswordLogicControl.h"
#import "CJDemoServiceUserManager+Network.h"
#import "CJDemoServiceUserManager+UserTable.h"
#import <CJFoundation/NSString+CJValidate.h>

@interface FindPasswordLogicControl () {
    
}
@property (nonatomic, copy) NSString *email;

@end


@implementation FindPasswordLogicControl

#pragma mark - Get Default
- (NSString *)getDefaultEmailForUserName:(NSString *)userName {
    NSString *uid = [CJDemoServiceUserManager sharedInstance].serviceUser.uid;
    DemoUser *info = [[CJDemoServiceUserManager sharedInstance] selectAccountInfoWhereUID:uid];
    NSString *email = info.email;
    return email;
}



#pragma mark - Update
- (void)updateEmail:(NSString *)email {
    _email = email;
    [self checkAllowClickFindPasswordButton];
}

///检查是否允许点击找回密码按钮
- (void)checkAllowClickFindPasswordButton {
    BOOL emailValidate = [self.email cj_validateEmail];

    BOOL allowClickFindPasswordButton = emailValidate;
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_findPasswordButtonEnableChange:)]) {
        [self.delegate logic_findPasswordButtonEnableChange:allowClickFindPasswordButton];
    }
}

#pragma mark - Do
///执行找回密码:"忘记密码，请求新密码请求"（string可以为手机号/邮箱/用户名）
- (void)findPassword
{
    NSString *email = self.email;
    
    NSString *failureMessage = [self checkFindPasswordConditionByEmail:email];
    if (failureMessage) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_tryFindPasswordFailureWithMessage:)]) {
            [self.delegate logic_tryFindPasswordFailureWithMessage:failureMessage];
        }
        
        return;
    }
    
    NSString *loginingText = NSLocalizedString(@"正在发送", nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_startFindPasswordWithMessage:)]) {
        [self.delegate logic_startFindPasswordWithMessage:loginingText];
    }
    

    
    [[CJDemoServiceUserManager sharedInstance] requestNewPasswordWithString:email success:^(id responseObject) {
        
        NSInteger status = [responseObject[@"status"] integerValue];
        if (status != 0) {
            NSString *loginFailureMessage = NSLocalizedString(@"邮件发送失败", nil);
            if (self.delegate && [self.delegate respondsToSelector:@selector(logic_findPasswordFailureWithMessage:)]) {
                [self.delegate logic_findPasswordFailureWithMessage:loginFailureMessage];
            }
            return;
        }
        
        //找回密码成功
        //NSDictionary *result = responseObject[@"result"];
        NSString *loginSuccessMessage = NSLocalizedString(@"邮件发送成功", nil);
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_findPasswordSuccessWithMessage:)]) {
            [self.delegate logic_findPasswordSuccessWithMessage:loginSuccessMessage];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSString *loginFailureMessage = NSLocalizedString(@"邮件发送失败", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_findPasswordFailureWithMessage:)]) {
            [self.delegate logic_findPasswordFailureWithMessage:loginFailureMessage];
        }
    }];
}

- (NSString *)checkFindPasswordConditionByEmail:(NSString *)email {
    BOOL emailValidate = [self.email cj_validateEmail];
    
    BOOL findPasswordButtonEnable = emailValidate;
    if (!findPasswordButtonEnable) {
        return NSLocalizedString(@"请完善找回密码所需的信息", nil);
    }
    
    return nil;
}



@end
