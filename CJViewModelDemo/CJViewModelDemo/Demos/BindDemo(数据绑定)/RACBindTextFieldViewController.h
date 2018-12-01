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
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;

@property (nonatomic, strong) UITextField *textField3;
@property (nonatomic, strong) UITextField *textField4;

@property (nonatomic, strong) RACTextFieldBindViewModel *viewModel;

- (void)setupViews;

- (void)implementFlawExampleInCell:(RACTextFieldBindTableViewCell *)cell;
- (void)implementOKExampleInCell:(RACTextFieldBindTableViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
