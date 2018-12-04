//
//  RACBindTextFieldViewController.h
//  CJViewModelDemo
//
//  Created by 李超前 on 12/1/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"
#import "RACTextFieldBindViewModel.h"
#import "RACTextFieldBindTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACBindTextFieldViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UITextField *textField1;  /**< 有键盘修改问题的textField */
@property (nonatomic, strong) UITextField *textField2;  /**< 有代码修改问题的textField */
@property (nonatomic, strong) UITextField *textField3;  /**< 键盘和代码修改都没问题的textField */

@property (nonatomic, strong) RACTextFieldBindViewModel *viewModel;

- (void)bindViewModel;

/// 键盘修改textField有问题的例子
- (void)implementFlawKeyExampleInCell:(RACTextFieldBindTableViewCell *)cell;
/// 代码修改textField有问题的例子
- (void)implementFlawCodeExampleInCell:(RACTextFieldBindTableViewCell *)cell;
/// 键盘和代码修改textField都没问题的例子
- (void)implementOKExampleInCell:(RACTextFieldBindTableViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
