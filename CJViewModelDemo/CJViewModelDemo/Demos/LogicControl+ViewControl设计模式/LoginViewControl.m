//
//  LoginViewControl.m
//  RACDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LoginViewControl.h"
#import <CJBaseUIKit/CJToast.h>

@interface LoginViewControl () {
    
}


@end



@implementation LoginViewControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Setter
- (void)setUserNameTextField:(CJTextField *)userNameTextField {
    _userNameTextField = userNameTextField;
    
    _userNameTextField.delegate = self;
}

- (void)setPasswordTextField:(CJTextField *)passwordTextField {
    _passwordTextField = passwordTextField;
    
    _passwordTextField.delegate = self;
}

- (void)setLoginButton:(UIButton *)loginButton {
    _loginButton = loginButton;
    
    _loginButton.enabled = NO;
    [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFindPasswordButton:(UIButton *)findPasswordButton {
    _findPasswordButton = findPasswordButton;
    
    [_findPasswordButton addTarget:self action:@selector(findPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setRegisterButton:(UIButton *)registerButton {
    _registerButton = registerButton;
    
    [_registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - ButtonEvent
- (void)loginButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(view_loginButtonAction)]) {
        [self.delegate view_loginButtonAction];
    }
}

- (void)findPasswordButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(view_findPasswordButtonAction)]) {
        [self.delegate view_findPasswordButtonAction];
    }
}

- (void)registerButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(view_registerButtonAction)]) {
        [self.delegate view_registerButtonAction];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //按Return进行换行功能
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
        
    } else if (textField == self.passwordTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(view_loginButtonAction)]) {
            [self.delegate view_loginButtonAction];
        }
        return YES;
        
    } else {
        [textField resignFirstResponder];
        return YES;
    }
}

//根据用户名查找用户头像
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.userNameTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(view_userNameTextFieldChange:)]) {
            [self.delegate view_userNameTextFieldChange:newText];
        }
    } else if (textField == self.passwordTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(view_passwordTextFieldChange:)]) {
            [self.delegate view_passwordTextFieldChange:newText];
        }
    }
    
    return YES;
}

#pragma mark - UpdateView
///更新文本框的值
- (void)updateUserNameTextField:(NSString *)userName {
    self.userNameTextField.text = userName;
}

///更新文本框的值
- (void)updatePasswordTextField:(NSString *)password {
    self.passwordTextField.text = password;
}

///更新登录按钮的点击状态
- (void)updateLoginButtonEnable:(BOOL)enable {
    self.loginButton.enabled = enable;
}

///开始视图的editing
- (void)startEndEditing {
    [self.userNameTextField becomeFirstResponder];//弹出键盘应该选择在viewDidAppear的时候
}
///结束视图的editing
- (void)stopEndEditing {
    //[self.view endEditing:YES];
}




///"尝试登录失败(未满足条件)时候"，更新视图
- (void)tryLoginFailureWithMessage:(NSString *)message {
    [CJToast shortShowMessage:message];
}

///"开始登录时候"更新视图(如显示提示信息)
- (void)startLoginWithMessage:(NSString *)message {
    if (_loginStateHUD == nil) {
        _loginStateHUD = [CJToast createChrysanthemumHUDWithMessage:message toView:nil];
    } else {
        _loginStateHUD.label.text = message;
    }
}

///“登录成功进入/回到主页时候"更新视图
- (void)loginSuccessWithMessage:(NSString *)message isBack:(BOOL)isBack {
    [self.loginStateHUD hideAnimated:YES afterDelay:0];
    [CJToast shortShowMessage:message];
}

///"登录失败时候"更新视图
- (void)loginFailureWithMessage:(NSString *)message {
    self.loginStateHUD.label.text = message;
    self.loginStateHUD.mode = MBProgressHUDModeText;
    [self.loginStateHUD hideAnimated:YES afterDelay:1];
}

@end
