//
//  RegisterLogicControl.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  RegisterLogicControl处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@protocol RegisterLogicControlDelegate <NSObject>

///注册按钮的enable发生变化需要更新按钮显示
- (void)logic_registerButtonEnableChange:(BOOL)enable;

///尝试登录时候，未满足条件时候
- (void)logic_tryRegisterFailureWithMessage:(NSString *)message;

///开始注册时候更新视图显示提示信息
- (void)logic_startRegisterWithMessage:(NSString *)message;

///注册成功回到登录页
- (void)logic_registerSuccessWithMessage:(NSString *)message;

///注册失败更新视图显示提示信息
- (void)logic_registerFailureWithMessage:(NSString *)message;

@end



@interface RegisterLogicControl : NSObject {
    
}
@property (nonatomic, weak) id<RegisterLogicControlDelegate> delegate;

#pragma mark - Get Default


#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;
- (void)updateEmail:(NSString *)email;

#pragma mark - Do
///执行注册
- (void)didRegister;

@end
