//
//  FindPasdViewController.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "FindPasdViewController.h"
#import "DemoSession.h"
#import "CJDemoDatabase+User.h"
#import "CJDemoServiceUserManager+Login.h"

@interface FindPasdViewController ()

@end

@implementation FindPasdViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSBundle *interfaceBundle = [CJDemoModuleLoginResourceUtil interfaceBundle];
    self = [super initWithNibName:nibNameOrNil bundle:interfaceBundle];
    if (self) {
        
    }
    return self;
}

/*
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.tfEmail becomeFirstResponder];
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"找回密码", nil);
    
    /*
    UIImage *emailTextFieldLeftImage = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"ico_mail_white" ofType:@"png"];
    self.tfEmail.leftView = [[UIImageView alloc]initWithImage:emailTextFieldLeftImage];
    self.tfEmail.leftViewMode = UITextFieldViewModeAlways;
    */
    
    NSString *uid = [DemoSession currentUser].uid;
    DemoUser *info = [[CJDemoDatabase sharedInstance] selectAccountInfoWhereUID:uid];
    self.tfEmail.text = info.email;
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
