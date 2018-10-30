//
//  STDemoButtonFactory.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoButtonFactory.h"
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>
#import <CJBaseUIKit/UIColor+CJHex.h>


@implementation STDemoButtonFactory

///蓝色背景按钮
+ (UIButton *)blueButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    return button;
}

///白色背景按钮
+ (UIButton *)whiteButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6;
    button.layer.borderWidth = 0.6;
    button.layer.borderColor = CJColorFromHexString(@"#d2d2d2").CGColor;
    [button setTitleColor:CJColorFromHexString(@"#666666") forState:UIControlStateNormal];
    button.cjNormalBGColor = CJColorFromHexString(@"#ffffff");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#e5e5e5");
    button.cjDisabledBGColor = CJColorFromHexString(@"#d3d3d5");
    return button;
}

///倒计时按钮
+ (UIButton *)timerButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button setTitleColor:CJColorFromHexString(@"#ffffff") forState:UIControlStateNormal];
    [button setTitleColor:CJColorFromHexString(@"#01adfe") forState:UIControlStateDisabled];
    
    button.cjNormalBGColor = CJColorFromHexString(@"#01adfe");
    button.cjHighlightedBGColor = CJColorFromHexString(@"#1393d7");
    button.cjDisabledBGColor = CJColorFromHexString(@"#ffffff");
    
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

@end
