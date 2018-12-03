//
//  BestBlockLoginViewController.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "BestBlockLoginViewController.h"
#import "BestBlockLoginViewModel.h"
//#import "CTMediator+STDemoLogin.h"

@interface BestBlockLoginViewController ()  {
    
}
@property (nonatomic, strong) BestBlockLoginViewModel *viewModel;

@end

@implementation BestBlockLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Block ViewModel(Best)", nil);
}

- (void)bindViewModel {
    NSString *userName = [CJAppLastUtil getLastLoginUser].lastLoginUserName;
    NSString *password = @"";
    BestBlockLoginViewModel *viewModel = [[BestBlockLoginViewModel alloc] initWithUserName:userName password:password];
    [viewModel setupUpdateUserNameCompleteBlock:^(BOOL userNameValid, BOOL loginValid) {
        NSLog(@"userNameValid = %@, loginValid = %@", userNameValid?@"YES":@"NO", loginValid?@"YES":@"NO");
        self.userNameTextField.leftButtonSelected = userNameValid;
        self.loginButton.enabled = loginValid;
    } updatePasswordCompleteBlock:^(BOOL passwordValid, BOOL loginValid) {
        self.passwordTextField.leftButtonSelected = passwordValid;
        self.loginButton.enabled = loginValid;
    }];
    [viewModel setupTryFailure:^(NSString *tryFailureMessage) {
        //"尝试登录失败(未满足条件)时候"，更新视图
        [CJToast shortShowMessage:tryFailureMessage];
        
    } loginStart:^(NSString *startMessage) {
        //开始登录时候更新视图显示提示信息
        if (self.loginStateHUD == nil) {
            self.loginStateHUD = [CJToast createChrysanthemumHUDWithMessage:startMessage toView:nil];
        } else {
            self.loginStateHUD.label.text = startMessage;
        }
        
    } loginSuccess:^(NSString *successMessage) {
        //登录成功需要进入/回到主页
        [self.loginStateHUD hideAnimated:YES afterDelay:0];
        [CJToast shortShowMessage:successMessage];
        
    } loginFailure:^(NSString *errorMessage) {
        //登录失败更新视图显示提示信息
        self.loginStateHUD.label.text = errorMessage;
        self.loginStateHUD.mode = MBProgressHUDModeText;
        [self.loginStateHUD hideAnimated:YES afterDelay:1];
    }];
    self.viewModel = viewModel;
}

- (void)showDefaultData {
    //显示上次登录的账号
    self.userNameTextField.text = self.viewModel.userName;
    self.passwordTextField.text = self.viewModel.password;
}

- (void)userNameTextFieldUpdateToText:(NSString *)userName {
    [self.viewModel updateUserName:userName];
}

- (void)passwordTextFieldUpdateToText:(NSString *)password {
    [self.viewModel updatePassword:password];
}

#pragma mark - ButtonEvent
- (void)findPasswordButtonAction {
//    [self.viewControl goFindPasswordViewController];
//    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_STDemo_forgetPasswordViewController];
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)registerButtonAction {
//    [self.viewControl goRegisterViewController];
//    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_STDemo_registerViewController];
//    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)loginButtonAction {
    //结束视图的editing
    [self.view endEditing:YES];
    
    [self.viewModel login];
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
