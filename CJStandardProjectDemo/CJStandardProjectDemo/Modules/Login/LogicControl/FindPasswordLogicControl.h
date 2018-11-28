//
//  FindPasswordLogicControl.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  FindPasswordLogicControl处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@protocol FindPasswordLogicControlDelegate <NSObject>

///找回密码按钮的enable发生变化需要更新按钮显示
- (void)vm_findPasswordButtonEnableChange:(BOOL)enable;

///尝试请求找回密码时候，未满足条件时候
- (void)vm_tryFindPasswordFailureWithMessage:(NSString *)message;

///开始请求找回密码时候更新视图显示提示信息
- (void)vm_startFindPasswordWithMessage:(NSString *)message;

///请求找回密码成功
- (void)vm_findPasswordSuccessWithMessage:(NSString *)message;


///请求找回密码失败更新视图显示提示信息
- (void)vm_findPasswordFailureWithMessage:(NSString *)message;

@end



@interface FindPasswordLogicControl : NSObject {
    
}
@property (nonatomic, weak) id<FindPasswordLogicControlDelegate> delegate;

#pragma mark - Get Default
- (NSString *)getDefaultEmailForUserName:(NSString *)userName;

#pragma mark - Update
- (void)updateEmail:(NSString *)email;

#pragma mark - Do
///执行找回密码:"忘记密码，请求新密码请求"（string可以为手机号/邮箱/用户名）
- (void)findPassword;

@end
