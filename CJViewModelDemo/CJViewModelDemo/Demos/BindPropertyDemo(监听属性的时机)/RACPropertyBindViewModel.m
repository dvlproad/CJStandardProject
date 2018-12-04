//
//  RACPropertyBindViewModel.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACPropertyBindViewModel.h"

@implementation RACPropertyBindViewModel

/// 通过文本框的值更新 inTextFieldValid1
- (void)updateVaildForInTextField1WithText:(NSString *)text {
    BOOL inTextFieldValid1 = text.length > 2 ? YES : NO;
    self.inTextFieldValid1 = inTextFieldValid1;
}

/// 通过文本框的值更新 inTextFieldValid2
- (void)updateVaildForInTextField2WithText:(NSString *)text {
    BOOL inTextFieldValid2 = text.length > 2 ? YES : NO;
    _inTextFieldValid2 = inTextFieldValid2;
}

/// 通过文本框的值更新 inTextFieldValid3
- (void)updateVaildForInTextField3WithText:(NSString *)text {
    BOOL inTextFieldValid3 = text.length > 2 ? YES : NO;
    [self setValue:@(inTextFieldValid3) forKey:@"inTextFieldValid3"];
}

/// 通过文本框的值更新 inTextFieldValid4
- (void)updateVaildForInTextField4WithText:(NSString *)text {
    BOOL inTextFieldValid4 = text.length > 2 ? YES : NO;
    [self setValue:@(inTextFieldValid4) forKey:@"_inTextFieldValid4"];
}


@end
