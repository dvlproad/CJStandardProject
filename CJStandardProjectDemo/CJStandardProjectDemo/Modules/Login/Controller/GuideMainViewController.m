//
//  GuideMainViewController.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 7/3/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "GuideMainViewController.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginRouter.h"

@interface GuideMainViewController ()

@end

@implementation GuideMainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSBundle *interfaceBundle = [CJDemoModuleLoginResourceUtil interfaceBundle];
    self = [super initWithNibName:nibNameOrNil bundle:interfaceBundle];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedStringFromTable(@"引导登录或注册", @"CJDemoModuleLogin", nil);
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Event
- (IBAction)goLogin:(id)sender {
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(goBack)];
    UINavigationController *navVC =[[UINavigationController alloc]initWithRootViewController:vc];
    navVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (IBAction)goRegister:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(goBack)];
    UINavigationController *navVC =[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goMain:(id)sender {
    [CJAppLastUtil readOverGuide];
    
    [LoginRouter goMainViewController];
    
    //UIAlertView提示进入成功，并自动消失
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"欢迎", nil) message:NSLocalizedString(@"欢迎使用本应用", nil) delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(disMissAlertAuto:) userInfo:alert repeats:NO];
}


- (void)disMissAlertAuto:(NSTimer *)timer{
    UIAlertView *alert = timer.userInfo;
    [alert dismissWithClickedButtonIndex:0 animated:YES];
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
