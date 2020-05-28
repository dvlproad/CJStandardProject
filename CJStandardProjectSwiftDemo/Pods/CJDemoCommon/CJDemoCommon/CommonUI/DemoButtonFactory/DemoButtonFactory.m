//
//  DemoButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoButtonFactory.h"

@implementation DemoButtonFactory

+ (DemoButtonFactory *)sharedInstance {
    static DemoButtonFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - 登录就会用到的几个按钮
/// 蓝色背景按钮(登录)
+ (UIButton *)blueButton {
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [CJColorFromHexString(@"#4499FF") colorWithAlphaComponent:0.5];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 3;
    loginButton.layer.masksToBounds = YES;
    
    loginButton.cjNormalBGColor = CJColorFromHexString(@"#4499FF");
    loginButton.cjDisabledBGColor = [CJColorFromHexString(@"#4499FF") colorWithAlphaComponent:0.5];
    
    return loginButton;
}

/// 倒计时按钮(获取短信验证码时候使用)
+ (UIButton *)timerButton {
    UIButton *timerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timerButton.backgroundColor = CJColorFromHexString(@"#b1b3b6");
    timerButton.layer.masksToBounds = YES;
    timerButton.layer.cornerRadius = 3;
    timerButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [timerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    timerButton.cjNormalBGColor = CJColorFromHexString(@"#4499FF");
    timerButton.cjDisabledBGColor = CJColorFromHexString(@"#b1b3b6");
    
    return timerButton;
}

/// 帮助按钮(短信验证码获取不到时候，语音验证码的获取按钮)
+ (UIButton *)helpButtonWithTitle:(NSString *)title {
    UIButton *voiceAuthCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //voiceAuthCodeButton.backgroundColor = [UIColor cyanColor];
    [voiceAuthCodeButton setTitle:title forState:UIControlStateNormal];
    voiceAuthCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//右对齐
    voiceAuthCodeButton.titleLabel.numberOfLines = 0;
    voiceAuthCodeButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [voiceAuthCodeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [voiceAuthCodeButton setTitleColor:[UIColor cjColorWithHexString:@"#f5a623"] forState:UIControlStateNormal];
    [voiceAuthCodeButton setTitleColor:[UIColor cjColorWithHexString:@"#b1b3b6"] forState:UIControlStateDisabled];
    
    return voiceAuthCodeButton;
}

/// 状态选择按钮(访问协议的是否"同意"按钮)
+ (UIButton *)stateButtonWithTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    UIButton *agreeProtocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    title = [@" " stringByAppendingString:title];
    [agreeProtocolButton setTitle:title forState:UIControlStateNormal];
    [agreeProtocolButton setImage:normalImage forState:UIControlStateNormal];
    [agreeProtocolButton setImage:selectedImage forState:UIControlStateSelected];
    [agreeProtocolButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [agreeProtocolButton setTitleColor:CJColorFromHexString(@"#b1b3b6") forState:UIControlStateNormal];
    [agreeProtocolButton setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 3, 0)];
    agreeProtocolButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return agreeProtocolButton;
}

/// 链接按钮(常用于访问网页协议等)
+ (UIButton *)linkButtonWithTitle:(NSString *)title {
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [linkButton setTitle:title forState:UIControlStateNormal];
    [linkButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [linkButton setTitleColor:CJColorFromHexString(@"#169bdb") forState:UIControlStateNormal];
    //    [lookProtocolButton addTarget:self action:@selector(lookProtocolEvent:) forControlEvents:UIControlEventTouchUpInside];
    return linkButton;
}

/// 第三方平台访问按钮(如微信登录)
+ (UIButton *)platformButtonWithTitle:(NSString *)title image:(UIImage *)image {
    UIButton *wechatLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatLoginButton.backgroundColor = [UIColor clearColor];
    [wechatLoginButton setImage:image forState:UIControlStateNormal];
    [wechatLoginButton setTitle:title forState:UIControlStateNormal];
    [wechatLoginButton setTitleColor:CJColorFromHexString(@"#1a1a1a") forState:UIControlStateNormal];
    [wechatLoginButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [wechatLoginButton cjVerticalImageAndTitle:10]; //写在这边imageView.frame.size为(0,0),所以设置无效
    
    return wechatLoginButton;
}

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
                     clickEditTitleHandle:(void(^)(UIButton *button))clickEditTitleHandle
{
    UIButton *submitButton = [self enableBlueButtonWithTitle:submitTitle];
    submitButton.layer.borderColor = CJColorFromHexString(@"#01ADFE").CGColor;
    
    submitButton.cjSelectedBGColor = CJColorFromHexString(@"#FFFFFF");
    [submitButton setTitle:editTitle forState:UIControlStateSelected];
    [submitButton setTitleColor:CJColorFromHexString(@"#01ADFE") forState:UIControlStateSelected];
    [submitButton setCjTouchUpInsideBlock:^(UIButton *button) {
        if (button.selected) {
            !clickEditTitleHandle ?: clickEditTitleHandle(button);
        } else {
            !clickSubmitTitleHandle ?: clickSubmitTitleHandle(button);
        }
    }];
    
    submitButton.selected = showEditTitle;
    submitButton.layer.borderWidth = showEditTitle ? 1 : 0;
    
    return submitButton;
}

+ (UIButton *)enableBlueButtonWithTitle:(NSString *)title {
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 4;
    
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    submitButton.cjNormalBGColor = CJColorFromHexString(@"#01ADFE");
    submitButton.cjDisabledBGColor = CJColorFromHexStringAndAlpha(@"#01ADFE", 0.3);
    [submitButton setTitle:title forState:UIControlStateNormal];
    [submitButton setTitle:title forState:UIControlStateDisabled];
    [submitButton setTitleColor:CJColorFromHexString(@"#FFFFFF") forState:UIControlStateNormal];
    [submitButton setTitleColor:CJColorFromHexString(@"#FFFFFF") forState:UIControlStateDisabled];
    
    return submitButton;
}

#pragma mark - 其他
/// 白色背景按钮(如自定义alert中的cancelButton)
+ (UIButton *)whiteButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    button.layer.borderWidth = 0.6;
    button.layer.borderColor = CJColorFromHexString(@"#d2d2d2").CGColor;
    [button setTitleColor:CJColorFromHexString(@"#d2d2d2") forState:UIControlStateNormal];
    
    button.cjNormalBGColor = CJColorFromHexString(@"#ffffff");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#e5e5e5");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    
    return button;
}

///含图片与文字的按钮，图片在右
+ (UIButton *)imageButtonWithTitle:(NSString *)title rightImage:(UIImage *)rightImage {
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageButton setFrame:CGRectMake(0, 0, 150, 44)];
    [imageButton setTitle:title forState:UIControlStateNormal];
    [imageButton setImage:rightImage forState:UIControlStateNormal];
    [imageButton setAdjustsImageWhenHighlighted:YES];
    [imageButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    CGFloat buttonImageWidth = imageButton.imageView.image.size.width;
    [imageButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -buttonImageWidth, 0, buttonImageWidth)];
    
    CGFloat buttonTitleWidth = imageButton.titleLabel.bounds.size.width+5;
    [imageButton setImageEdgeInsets:UIEdgeInsetsMake(0, buttonTitleWidth, 0, -buttonTitleWidth)];
    
    return imageButton;
}

#pragma mark - BadgeButton
+ (CJBadgeButton *)defaultBadgeButton {
    CJBadgeButton *badgeButton = [CJBadgeButton buttonWithType:UIButtonTypeCustom];
    badgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    badgeButton.badgeLabel.textColor = [UIColor whiteColor];
    badgeButton.layer.cornerRadius = 10;
    
    return badgeButton;
}

+ (CJBadgeButton *)goDeliverBadgeButton {
    CJBadgeButton *badgeButton = [CJBadgeButton buttonWithType:UIButtonTypeCustom];
    badgeButton.backgroundColor = [UIColor cyanColor];
    badgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    badgeButton.badgeLabel.textColor = [UIColor whiteColor];
    badgeButton.badgeLabel.font = [UIFont boldSystemFontOfSize:17];
    badgeButton.badgeLabel.layer.cornerRadius = 3;
    badgeButton.badgeLabelTop = 5;
    badgeButton.badgeLabelRight = 0;
    badgeButton.badgeLabelWidth = 40;
    badgeButton.badgeLabelHeight = 23;
    [badgeButton setImage:[UIImage imageNamed:@"badgeButton_normal"] forState:UIControlStateNormal];
    [badgeButton setImage:[UIImage imageNamed:@"badgeButton_highlighted"] forState:UIControlStateHighlighted];
    badgeButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [badgeButton setTitleEdgeInsets:UIEdgeInsetsMake(44, -104, 0, 0)];
    
    return badgeButton;
}

@end
