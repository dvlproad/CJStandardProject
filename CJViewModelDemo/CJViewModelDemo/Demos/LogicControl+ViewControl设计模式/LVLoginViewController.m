//
//  LVLoginViewController.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "LVLoginViewController.h"
#import <CJBaseUtil/CJAppLastUtil.h>

#import <CJBaseUIKit/UINavigationBar+CJChangeBG.h>
#import "LoginViewControl.h"
#import "DelegateLoginViewModel.h"

//#import <CJDemoModuleMain/CTMediator+CJDemoModuleMain.h> //需要依赖Main
#ifdef CJTestJustLogin
#import "RegisterViewController.h"
#import "FindPasdViewController.h"
#endif

//#import "CJDemoModuleLoginResourceUtil.h"


@interface LVLoginViewController () <UITextFieldDelegate, LoginViewControlDelegate, DelegateLoginViewModelDelegate> {
    
}
@property (nonatomic, strong) LoginViewControl *viewControl;
@property (nonatomic, strong) DelegateLoginViewModel *logicControl;

@end

@implementation LVLoginViewController

#pragma mark - LifeCycle
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar cj_resetBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar cj_hideUnderline:YES];
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.title = @"";
    
    //显示上次登录的账号
    [self.viewControl updateUserNameTextField:self.logicControl.userName];
    [self.viewControl updatePasswordTextField:self.logicControl.password];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.viewControl startEndEditing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"登录", nil);
    
    [self setupViews];
    
    //viewControl
    LoginViewControl *viewControl = [[LoginViewControl alloc] init];
    viewControl.userNameTextField = self.userNameTextField;
    viewControl.passwordTextField = self.passwordTextField;
    viewControl.loginButton = self.loginButton;
    viewControl.findPasswordButton = self.findPasswordButton;
    viewControl.registerButton = self.registerButton;
    viewControl.delegate = self;
    self.viewControl = viewControl;
    
    //logicControl
    NSString *userName = [CJAppLastUtil getLastLoginUser].lastLoginUserName;
    NSString *password = @"";
    DelegateLoginViewModel *logicControl = [[DelegateLoginViewModel alloc] initWithUserName:userName password:password];
    logicControl.delegate = self;
    self.logicControl = logicControl;
}

#pragma mark - LoginViewControlDelegate
- (void)view_userNameTextFieldChange:(NSString *)userName {
    [self.logicControl updateUserName:userName];
}

- (void)view_passwordTextFieldChange:(NSString *)password {
    [self.logicControl updatePassword:password];
}

- (void)view_loginButtonAction {
    [self.viewControl stopEndEditing];
    [self.logicControl login];
}

- (void)view_findPasswordButtonAction {
    [self goFindPasswordViewController];
}

- (void)view_registerButtonAction {
    [self goRegisterViewController];
}


#pragma mark - LoginLogicControlDelegate
///登录按钮的enable发生变化需要更新按钮显示
- (void)vm_checkLoginWithValid:(BOOL)enable {
    [self.viewControl updateLoginButtonEnable:enable];
}

///尝试登录时候，未满足条件时候
- (void)vm_tryLoginFailureWithMessage:(NSString *)message {
    [self.viewControl tryLoginFailureWithMessage:message];
}

///开始登录时候更新视图显示提示信息
- (void)vm_startLoginWithMessage:(NSString *)message {
    [self.viewControl startLoginWithMessage:message];
}

///登录成功需要进入/回到主页
- (void)vm_loginSuccessWithMessage:(NSString *)message {
    [self.viewControl loginSuccessWithMessage:message isBack:NO];
}

///登录失败更新视图显示提示信息
- (void)vm_loginFailureWithMessage:(NSString *)message {
    [self.viewControl loginFailureWithMessage:message];
}

#pragma mark - 界面跳转
///进入主页(非游客模式，或游客模式下用户未使用游客分身进入主页)
- (void)goMainViewController {
//    NSDictionary *params = nil;
//    UIViewController *mainViewControllerWithParams = [[CTMediator sharedInstance] cjDemo_mainViewControllerWithParams:params];
//    [UIApplication sharedApplication].delegate.window.rootViewController = mainViewControllerWithParams;
}

///回到主页(游客模式下，用户已使用游客分身进入主页，则当其在点击需要登录的功能后，会进入登录，并在登录成功后回到首页)
- (void)backMainViewController {
    //[self.belongViewController.navigationController popViewControllerAnimated:YES];
}

///进入"忘记密码"界面
- (void)goFindPasswordViewController {
#ifdef CJTestJustLogin
    FindPasdViewController *viewController = [[FindPasdViewController alloc] initWithNibName:@"FindPasdViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
#else
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedString(@"忘记密码", nil);
    viewController.view.backgroundColor = [UIColor whiteColor];
    //[self.belongViewController.navigationController pushViewController:viewController animated:YES];
#endif
}

///进入"注册"界面
- (void)goRegisterViewController {
#ifdef CJTestJustLogin
    RegisterViewController *viewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
#else
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedString(@"注册", nil);
    viewController.view.backgroundColor = [UIColor whiteColor];
    //[self.belongViewController.navigationController pushViewController:viewController animated:YES];
#endif
}


#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.viewControl stopEndEditing];
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.portraitBackgroundImageView];
    [self.portraitBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(124);
        make.height.mas_equalTo(80);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.portraitImageView];
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(124);
        make.height.mas_equalTo(80);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.portraitImageView.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(270);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTextField.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(270);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).mas_offset(6);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(270);
    }];
    
    [self.view addSubview:self.findPasswordButton];
    [self.findPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.view).mas_offset(-25);
        make.width.mas_equalTo(105);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.findPasswordButton.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.view).mas_offset(-25);
        make.width.mas_equalTo(105);
    }];
}

- (UIImageView *)portraitBackgroundImageView {
    if (_portraitBackgroundImageView == nil) {
        _portraitBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _portraitBackgroundImageView.image = [UIImage imageNamed:@"people_Mask.png"];
    }
    return _portraitImageView;
}

- (UIImageView *)portraitImageView {
    if (_portraitImageView == nil) {
        UIImageView *portraitImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        portraitImageView.image = [UIImage imageNamed:@"people_logout.png"];
        
        _portraitImageView = portraitImageView;
    }
    return _portraitImageView;
}

- (CJTextField *)userNameTextField {
    if (_userNameTextField == nil) {
        _userNameTextField = [[CJTextField alloc] initWithFrame:CGRectZero];
        _userNameTextField.backgroundColor = CJColorFromHexString(@"#cccccc");
        _userNameTextField.placeholder = NSLocalizedString(@"用户名", nil);
        _userNameTextField.layer.cornerRadius = 20;
        _userNameTextField.returnKeyType = UIReturnKeyNext;
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        leftView.image = [UIImage imageNamed:@"ico_user_white.png"];
        _userNameTextField.leftView = leftView;
        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
        _userNameTextField.leftViewLeftOffset = 8;
        _userNameTextField.leftViewRightOffset = 8;
    }
    return _userNameTextField;
}

- (CJTextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[CJTextField alloc] initWithFrame:CGRectZero];
        _passwordTextField.backgroundColor = CJColorFromHexString(@"#cccccc");
        _passwordTextField.placeholder = NSLocalizedString(@"用户名", nil);
        _passwordTextField.layer.cornerRadius = 20;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        
        //UIImage *nameTextFieldLeftImage = [STDemoModuleLoginResourceUtil bundleImageNamed:@"ico_user_white" ofType:@"png"];
        //UIImageView *leftView = = [[UIImageView alloc]initWithImage:nameTextFieldLeftImage];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        leftView.image = [UIImage imageNamed:@"ico_lock_white.png"];
        _passwordTextField.leftView = leftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.leftViewLeftOffset = 8;
        _passwordTextField.leftViewRightOffset = 8;
    }
    return _passwordTextField;
}


- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:CJColorFromHexString(@"#66cc00")];
        [_loginButton setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 20;
        _loginButton.enabled = NO;
    }
    return _loginButton;
}

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"arrow_back_red.png"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)findPasswordButton {
    if (_findPasswordButton == nil) {
        _findPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_findPasswordButton setTitle:NSLocalizedString(@"忘记密码？", nil) forState:UIControlStateNormal];
        [_findPasswordButton setTitleColor:CJColorFromHexString(@"#66cc00") forState:UIControlStateNormal];
    }
    return _findPasswordButton;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:NSLocalizedString(@"新用户 >>", nil) forState:UIControlStateNormal];
        [_registerButton setTitleColor:CJColorFromHexString(@"#66cc00") forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
