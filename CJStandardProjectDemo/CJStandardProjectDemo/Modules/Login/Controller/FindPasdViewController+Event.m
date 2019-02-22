//
//  FindPasdViewController+Event.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "FindPasdViewController+Event.h"
#import <CJFoundation/NSString+CJValidate.h>
#import <CJFoundation/NSString+CJAttributedString.h>
#import <CJBaseUIKit/UIView+CJPopupInView.h>

#import "CJDemoServiceUserManager+Login.h"

@implementation FindPasdViewController (Event)

#pragma mark - 返回
- (IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 找回密码
- (IBAction)tryFindPasd:(id)sender{
    [self.tfEmail resignFirstResponder];
    
    if ([self.tfEmail.text cj_validateEmail]) {
        [self doFindPasd];
    }else{
        [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示", nil)
                                   message:NSLocalizedString(@"邮箱输入错误", nil)
                                  delegate:self
                         cancelButtonTitle:NSLocalizedString(@"好的，我知道了", nil)
                         otherButtonTitles:nil] show];
    }
}

- (void)doFindPasd{
    [self.view endEditing:YES];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.delegate = self;
    HUD.label.text = NSLocalizedString(@"正在发送", nil);
    
    NSString *email = self.tfEmail.text;
    
    [[CJDemoServiceUserManager sharedInstance] getNewPasswordWithString:email success:^(id  _Nullable responseObject) {
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = NSLocalizedString(@"邮件发送成功", nil);
        [HUD hideAnimated:YES afterDelay:1];
        
        NSString *string1 = NSLocalizedString(@"我们已将重置密码的邮件发送至您的账户邮箱：\n", nil);
        NSString *string3 = NSLocalizedString(@"\n请访问邮件内的地址进行重置", nil);
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@", string1, self.tfEmail.text, string3];
        NSAttributedString *attributedString = [mesg attributedSubString:self.tfEmail.text font:[UIFont systemFontOfSize:21.0] color:[UIColor blackColor] udline:YES];
        
        
        NSBundle *interfaceBundle = [CJDemoModuleLoginResourceUtil interfaceBundle];
        NSArray *bundle = [interfaceBundle loadNibNamed:@"FindPasdPopupView" owner:self options:nil];
        FindPasdPopupView *customView = [bundle lastObject];
        customView.delegate = self;
        customView.lab.attributedText = attributedString;
        customView.layer.cornerRadius = 30;
        UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        [customView cj_popupInCenterWindow:CJAnimationTypeNormal withSize:customView.frame.size blankBGColor:blankBGColor showComplete:nil tapBlankComplete:nil];
        
        
    } failure:^(NSError * _Nullable error) {
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = NSLocalizedString(@"邮件发送失败", nil);
        [HUD hideAnimated:YES afterDelay:1];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.tfEmail becomeFirstResponder];
}


#pragma mark -
/////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
    
    //按Return进行换行功能
    /*
    [textField resignFirstResponder];
    [self tryFindPasd:NULL];
    return YES;
    */
}


- (void)goOK_FindPasdPopupView:(FindPasdPopupView *)FindPasdPopupView {
    [FindPasdPopupView cj_hidePopupViewWithAnimationType:CJAnimationTypeNone];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
