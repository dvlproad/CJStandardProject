//
//  RACPropertyBindViewModel.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACPropertyBindViewModel : NSObject

@property (nonatomic, assign) BOOL inTextFieldValid1;
@property (nonatomic, assign) BOOL inTextFieldValid2;
@property (nonatomic, assign) BOOL inTextFieldValid3;
@property (nonatomic, assign) BOOL inTextFieldValid4;

@property (nonatomic, assign) BOOL outTextFieldValid1;
@property (nonatomic, assign) BOOL outTextFieldValid2;
@property (nonatomic, assign) BOOL outTextFieldValid3;

/// 通过文本框的值更新 inTextFieldValid1
- (void)updateVaildForInTextField1WithText:(NSString *)text;

/// 通过文本框的值更新 inTextFieldValid2
- (void)updateVaildForInTextField2WithText:(NSString *)text;

/// 通过文本框的值更新 inTextFieldValid3
- (void)updateVaildForInTextField3WithText:(NSString *)text;

/// 通过文本框的值更新 inTextFieldValid4
- (void)updateVaildForInTextField4WithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
