//
//  DemoButtonFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  想两改变两个子控件的显示位置，可以分别通过setTitleEdgeInsets和setImageEdgeInsets来实现。需要注意的是，对titleLabel和imageView设置偏移，是针对它当前的位置起作用的，并不是针对它距离button边框的距离的

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "UIButton+CJMoreProperty.h"
#import "UIButton+CJUpDownStructure.h"
#import "UIColor+CJHex.h"
#import "CJBadgeButton.h"
#else
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>
#import <CJBaseUIKit/UIButton+CJUpDownStructure.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <CJBaseUIKit/CJBadgeButton.h>
#endif

@interface DemoButtonFactory : NSObject

#pragma mark - 登录就会用到的几个按钮
/// 蓝色背景按钮(登录)
+ (UIButton *)blueButton;

/// 倒计时按钮(获取短信验证码时候使用)
+ (UIButton *)timerButton;

/// 帮助按钮(短信验证码获取不到时候，语音验证码的获取按钮)
+ (UIButton *)helpButtonWithTitle:(NSString *)title;

/// 状态选择按钮(访问协议的是否"同意"按钮)
+ (UIButton *)stateButtonWithTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

/// 链接按钮(常用于访问网页协议等)
+ (UIButton *)linkButtonWithTitle:(NSString *)title;

/// 第三方平台访问按钮(如微信登录)
+ (UIButton *)platformButtonWithTitle:(NSString *)title image:(UIImage *)image;

/**
 *  "提交"/"修改"状态选择按钮(if you want to show editTitle, you should make selected == YES)
 *
 *  @param submitTitle              submitTitle(current selected should be YES)
 *  @param editTitle                editTitle(current selected should be NO)
 *  @param showEditTitle            showEditTitle(if you want to show editTitle, you should make selected == YES)
 *  @param clickSubmitTitleHandle   click submitTitle action
 *  @param clickEditTitleHandle     click editTitle action
 */
+ (UIButton *)submitButtonWithSubmitTitle:(NSString *)submitTitle
                                editTitle:(NSString *)editTitle
                            showEditTitle:(BOOL)showEditTitle
                   clickSubmitTitleHandle:(void(^)(UIButton *button))clickSubmitTitleHandle
                     clickEditTitleHandle:(void(^)(UIButton *button))clickEditTitleHandle;

#pragma mark - 其他
/// 白色背景按钮(如自定义alert中的cancelButton)
+ (UIButton *)whiteButton;

///含图片与文字的按钮，图片在右
+ (UIButton *)imageButtonWithTitle:(NSString *)title rightImage:(UIImage *)rightImage;


#pragma mark - BadgeButton
+ (CJBadgeButton *)defaultBadgeButton;

+ (CJBadgeButton *)goDeliverBadgeButton;

@end
