//
//  DemoTextFieldFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "CJTextField.h"
#import "UIColor+CJHex.h"
#else
#import <CJBaseUIKit/CJTextField.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#endif

@interface DemoTextFieldFactory : NSObject

/// 不含左右视图的通用文本框(如"验证码"、"邀请码"等文本框)
+ (CJTextField *)commonTextField;

///含左侧图片的textField，并支持通过leftButtonSelected属性切换图片变化 (使用场景：登录等)
+ (CJTextField *)textFieldWithNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage;

///含 左侧label 的textField(使用场景：忘记密码、修改密码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText;


///含 左侧label 和 右侧button 的textField(使用场景：获取验证码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText rightButton:(UIButton *)rightButton;

/// 选择文本框(如选择手机号的区域)
+ (CJTextField *)chooseTextFieldWithDefaultTitle:(NSString *)defalutTitle defalutValue:(NSString *)defalutValue rightImage:(UIImage *)rightImage;

/// 可右侧操作的文本框(如手机号文本框上的"获取验证码")
+ (CJTextField *)textFieldWithRightView:(UIView *)rightView;

@end
