//
//  CJDemoButtonFactory.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJDemoButtonFactory : NSObject

///蓝色背景按钮
+ (UIButton *)blueButton;

///白色背景按钮
+ (UIButton *)whiteButton;

///倒计时按钮
+ (UIButton *)timerButton;

///含图片与文字的按钮，图片在右
+ (UIButton *)imageButtonWithTitle:(NSString *)title rightImage:(UIImage *)rightImage;

@end
