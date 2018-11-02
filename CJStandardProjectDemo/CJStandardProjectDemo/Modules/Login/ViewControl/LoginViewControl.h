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

@protocol LoginViewControlDelegate <NSObject>

- (void)view_userNameTextFieldChange:(NSString *)userName;  /**< 用户名文本框内容改变了 */
- (void)view_passwordTextFieldChange:(NSString *)password;  /**< 密码文本框内容改变了 */

- (void)view_loginButtonAction;
- (void)view_registerButtonAction;
- (void)view_findPasswordButtonAction;

@end



@interface LoginViewControl : NSObject <UITextFieldDelegate> {
    
}
@property (nonatomic, weak) id<LoginViewControlDelegate> delegate;

@property (nonatomic, strong) UIView *view;
//@property (nonatomic, strong) UIImageView *portraitImageView;   /**< 头像 */
@property (nonatomic, strong) CJTextField *userNameTextField;   /**< 账号(记得关掉自动纠错) */
@property (nonatomic, strong) CJTextField *passwordTextField;   /**< 密码 */
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

///“登录成功进入/回到主页时候"更新视图
- (void)loginSuccessWithMessage:(NSString *)message isBack:(BOOL)isBack;

///"登录失败时候"更新视图
- (void)loginFailureWithMessage:(NSString *)message;

@end
