//
//  MidRACLoginViewController.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "MidRACLoginViewController.h"
#import "MidRACLoginViewModel.h"
//#import "CTMediator+STDemoLogin.h"

@interface MidRACLoginViewController () {
    
}
@property (nonatomic, strong) MidRACLoginViewModel *viewModel;

@end

@implementation MidRACLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"RAC ViewModel(High)", nil);
}

- (void)bindViewModel {
    NSString *userName = [CJAppLastUtil getLastLoginUser].lastLoginUserName;
    NSString *password = @"";
    MidRACLoginViewModel *viewModel = [[MidRACLoginViewModel alloc] initWithUserName:userName password:password];
//    [viewModel.userNameValidObject subscribeNext:^(id  _Nullable x) {
//        BOOL userNameValid = [x boolValue];
//        self.userNameTextField.leftButtonSelected = userNameValid;
//    }];
//    [viewModel.passwordValidObject subscribeNext:^(id  _Nullable x) {
//        BOOL passwordValid = [x boolValue];
//        self.passwordTextField.leftButtonSelected = passwordValid;
//    }];
//    [viewModel.loginValidObject subscribeNext:^(id  _Nullable x) {
//        BOOL loginVaild = [x boolValue];
//        self.loginButton.enabled = loginVaild;
//    }];
    RAC(self.userNameTextField, leftButtonSelected) = RACObserve(viewModel, userNameValid);
    RAC(self.passwordTextField, leftButtonSelected) = RACObserve(viewModel, passwordValid);
    RAC(self.loginButton, enabled) = RACObserve(viewModel, loginValid);
    /* //或者
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[RACObserve(viewModel, userNameValid), RACObserve(viewModel, passwordValid)] reduce:^id(id nUserNameValid, id nPasswordValid){
        return @([nUserNameValid boolValue] && [nPasswordValid boolValue]);
    }];
    */
    
    [viewModel.tryFailureObject subscribeNext:^(id  _Nullable x) {
        NSString *message = (NSString *)x;
        [CJToast shortShowMessage:message];
    }];
    [viewModel.startObject subscribeNext:^(id  _Nullable x) {
        NSString *message = (NSString *)x;
        [CJToast shortShowMessage:message];
    }];
    [viewModel.successObject subscribeNext:^(id  _Nullable x) {
        NSString *message = (NSString *)x;
        [CJToast shortShowMessage:message];
    }];
    [viewModel.failureObject subscribeNext:^(id  _Nullable x) {
        NSString *message = (NSString *)x;
        [CJToast shortShowMessage:message];
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
