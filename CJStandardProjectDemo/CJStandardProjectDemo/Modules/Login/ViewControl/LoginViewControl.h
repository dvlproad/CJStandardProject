//
//  LoginViewControl.h
//  RACDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  LoginViewControl处理界面显示变化、告知外部按钮点击等操作了(通过delegate返回)，处理界面跳转

#import <Foundation/Foundation.h>

#import <CJBaseUIKit/CJTextField.h>

#import "LoginViewController.h"

@protocol LoginViewModelDelegate <NSObject>

- (void)vm_userNameTextFieldChange:(NSString *)userName;  /**< 用户名文本框内容改变了 */
- (void)vm_passwordTextFieldChange:(NSString *)password;  /**< 密码文本框内容改变了 */

- (void)vm_loginButtonAction;
- (void)vm_registerButtonAction;
- (void)vm_findPasswordButtonAction;

@end



@interface LoginViewControl : NSObject <UITextFieldDelegate> {
    
}
@property (nonatomic, weak) id<LoginViewModelDelegate> delegate;

//@property (nonatomic, strong) UIImageView *portraitBackgroundImageView; /**< 头像背景 */
//@property (nonatomic, strong) UIImageView *portraitImageView;   /**< 头像 */
@property (nonatomic, strong) CJTextField *userNameTextField;   /**< 账号(记得关掉自动纠错) */
@property (nonatomic, strong) CJTextField *passwordTextField;   /**< 密码 */
//@property (nonatomic, strong) UIButton *backButton;             /**< 返回按钮 */
@property (nonatomic, strong) UIButton *loginButton;            /**< 登录按钮 */
@property (nonatomic, strong) UIButton *findPasswordButton;     /**< 找回密码按钮 */
@property (nonatomic, strong) UIButton *registerButton;         /**< 注册按钮 */
@property (nonatomic, strong) MBProgressHUD *loginStateHUD;     /**< 进展状态HUD */


#pragma mark - UpdateView
///更新文本框的值
- (void)updateUserNameTextField:(NSString *)userName;
///更新文本框的值
- (void)updatePasswordTextField:(NSString *)password;
///更新登录按钮的点击状态
- (void)updateLoginButtonEnable:(BOOL)enable;
///开始视图的editing
- (void)startEndEditing;
///结束视图的editing
- (void)stopEndEditing;

///"尝试登录失败(未满足条件)时候"，更新视图
- (void)tryLoginFailureWithMessage:(NSString *)message;

///"开始登录时候"更新视图(如显示提示信息)
- (void)startLoginWithMessage:(NSString *)message;

///“登录成功进入主页时候"更新视图
- (void)loginSuccessAndGoMainViewControllerWithMessage:(NSString *)message;

///"登录成功回到主页时候"更新视图
- (void)loginSuccessAndBackMainViewControllerWithMessage:(NSString *)message;

///"登录失败时候"更新视图
- (void)loginFailureWithMessage:(NSString *)message;

#pragma mark - 界面跳转
///进入"忘记密码"界面
- (void)goFindPasswordViewController;

///进入"注册"界面
- (void)goRegisterViewController;
@end
