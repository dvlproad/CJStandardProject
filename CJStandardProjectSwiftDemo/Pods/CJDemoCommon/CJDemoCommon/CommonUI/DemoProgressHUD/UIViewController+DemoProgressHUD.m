//
//  UIViewController+DemoProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIViewController+DemoProgressHUD.h"
#import <objc/runtime.h>
#import "DemoProgressHUD.h"
#import <CJBaseUIKit/UIViewController+CJToast.h>

@interface UIViewController () {
    
}
@property (nonatomic, strong) DemoProgressHUD *DemoProgressHUD;


@end

@implementation UIViewController (DemoProgressHUD)

//DemoProgressHUD
- (DemoProgressHUD *)DemoProgressHUD {
    return objc_getAssociatedObject(self, @selector(DemoProgressHUD));
}

- (void)setDemoProgressHUD:(DemoProgressHUD *)DemoProgressHUD {
    objc_setAssociatedObject(self, @selector(DemoProgressHUD), DemoProgressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 显示HUD
- (void)showDemoProgressHUD {
    if (!self.DemoProgressHUD) {
        self.DemoProgressHUD = [[DemoProgressHUD alloc] init];
    }
    
    [self.DemoProgressHUD showInView:self.view withShowBackground:NO];
}

/// 隐藏HUD
- (void)dismissDemoProgressHUD {
    BOOL dismissSuccess = [self.DemoProgressHUD dismissWithForce:NO];
    if (dismissSuccess) {
        self.DemoProgressHUD = nil;
    }
}

/// 上传过程中显示开始上传的进度提示
- (void)cjdemo_showStartProgressMessage:(NSString * _Nullable)startProgressMessage {
    [self cj_showChrysanthemumHUDWithMessage:startProgressMessage animated:YES];
}

/// 上传过程中显示正在上传的进度提示
- (void)cjdemo_showProgressingMessage:(NSString *)progressingMessage {
    [self cj_updateChrysanthemumHUDWithMessage:progressingMessage];
}

/// 上传过程中显示结束上传的进度提示
- (void)cjdemo_showEndProgressMessage:(NSString *)endProgressMessage isSuccess:(BOOL)isSuccess {
    if (isSuccess) {
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:0];
        
    } else {
        [self cj_updateChrysanthemumHUDWithMessage:endProgressMessage];
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:1];
    }
}

@end
