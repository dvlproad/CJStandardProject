//
//  DemoTextFieldFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoTextFieldFactory.h"
#import <CJBaseUIKit/UITextField+CJPadding.h>

@implementation DemoTextFieldFactory

/// 不含左右视图的通用文本框(如"验证码"、"邀请码"等文本框)
+ (CJTextField *)commonTextField {
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = [UIColor whiteColor];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:14];
    textField.layer.borderColor = CJColorFromHexString(@"#dadada").CGColor;
    textField.layer.borderWidth = 0.5;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField cj_addLeftOffset:10];
    
    return textField;
}

///含左侧图片的textField，并支持通过leftButtonSelected属性切换图片变化 (使用场景：登录等)
+ (CJTextField *)textFieldWithNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage
{
    CGSize imageSize = CGSizeMake(14, 15);
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    textField.layer.cornerRadius = 6;
    textField.layer.borderWidth = 0.6;
    textField.layer.borderColor = CJColorFromHexString(@"#d2d2d2").CGColor;
    
    [textField addLeftImageWithNormalImage:normalImage selectedImage:selectedImage imageSize:imageSize];
    textField.leftViewLeftOffset = 15;
    textField.leftViewRightOffset = 15;
    
    return textField;
}

///含 左侧label 的textField(使用场景：忘记密码、修改密码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText {
    CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = CJColorFromHexString(@"#ffffff");
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat lableWidth = screenWidth < 375 ? 90 : 100;
    CGFloat fontSize = screenWidth < 375 ? 15.5 : 17;

    leftLabel.frame = CGRectMake(0, 0, lableWidth, 44);
    //leftLabel.backgroundColor = [UIColor greenColor];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.textColor = CJColorFromHexString(@"#333333");
    leftLabel.font = [UIFont systemFontOfSize:fontSize];
    leftLabel.text = leftLabelText;
    
    textField.leftView = leftLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftViewLeftOffset = 12;
    textField.leftViewRightOffset = 12;
    textField.font = [UIFont systemFontOfSize:fontSize];
    
    [textField addUnderLineWithHeight:0.5 color:CJColorFromHexString(@"#d1d3d4") leftMargin:10 rightMargin:0];
    return textField;
}

///含 左侧label 和 右侧button 的textField(使用场景：获取验证码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText rightButton:(UIButton *)rightButton {
    CJTextField *textField = [self textFieldWithLeftLabelText:leftLabelText];
    rightButton.frame = CGRectMake(0, 0, 90, 35);
    
    textField.rightView = rightButton;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightViewLeftOffset = 12;
    textField.rightViewRightOffset = 12;

    return textField;
}

/// 选择文本框
+ (CJTextField *)chooseTextFieldWithDefaultTitle:(NSString *)defalutTitle defalutValue:(NSString *)defalutValue rightImage:(UIImage *)rightImage {
    CJTextField *regionTextField = [[CJTextField alloc] initWithFrame:CGRectZero];
    regionTextField.font = [UIFont systemFontOfSize:14];
    regionTextField.textColor = CJColorFromHexString(@"#1a1a1a");
    regionTextField.text = defalutValue;
    regionTextField.backgroundColor = [UIColor whiteColor];
    
    //添加左视图
    UILabel *regionLabel = [UILabel new];
    regionLabel.font = [UIFont systemFontOfSize:14];
    regionLabel.textColor = CJColorFromHexString(@"#bcbcbc");
    regionLabel.text = defalutTitle;
    regionLabel.textAlignment = NSTextAlignmentLeft;
    regionLabel.frame = CGRectMake(0, 0, 100, 38);
    regionTextField.leftViewLeftOffset = 10;
    regionTextField.leftView = regionLabel;
    regionTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //添加右视图
    UIImageView *downArrowImageView = [[UIImageView alloc] initWithImage:rightImage];
    downArrowImageView.frame = CGRectMake(0, 0, 9, 5);
    regionTextField.rightViewRightOffset = 17;
    regionTextField.rightView = downArrowImageView;
    regionTextField.rightViewMode = UITextFieldViewModeAlways;
    
    return regionTextField;
}

/// 可右侧操作的文本框(如手机号文本框上的"获取验证码")
+ (CJTextField *)textFieldWithRightView:(UIView *)rightView {
    CJTextField *phoneTextField = [DemoTextFieldFactory commonTextField];
    
    //phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [rightView setFrame:CGRectMake(0, 0, 90, 30)];
    phoneTextField.rightView = rightView;
    phoneTextField.rightViewMode = UITextFieldViewModeAlways;
    phoneTextField.rightViewRightOffset = 10;
    
    return phoneTextField;
}

@end
