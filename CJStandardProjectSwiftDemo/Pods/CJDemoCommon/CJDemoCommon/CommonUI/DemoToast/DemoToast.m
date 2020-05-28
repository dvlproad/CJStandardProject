//
//  DemoToast.m
//  CJDemoModuleLoginDemoCommonDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoToast.h"
#import <CJBaseUIKit/CJToast.h>
#import "DemoAlert.h"

@implementation DemoToast

///显示只有文字的提示
+ (void)showMessage:(NSString *)message {
    [CJToast shortShowMessage:message];
}

+ (void)showMessage:(NSString *)message inView:(UIView *)view {
    [CJToast shortShowMessage:message inView:view];
}

///显示含图片和文字的错误提示
+ (void)showErrorMessage:(NSString *)errorMessage {
//    UIImage *errorImage = [UIImage imageNamed:@"demo_toast_error"];
//    UIView *view = [[UIApplication sharedApplication].delegate window];
//    [CJToast shortShowMessage:errorMessage image:errorImage toView:view];
    [DemoAlert showErrorToastAlertViewTitle:errorMessage];
    
}


@end
