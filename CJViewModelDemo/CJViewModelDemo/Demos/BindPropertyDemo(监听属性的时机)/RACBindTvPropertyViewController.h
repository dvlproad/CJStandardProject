//
//  RACBindTvPropertyViewController.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//
//  RAC绑定tableView中的textField的例子

#import "CJUIKitBaseViewController.h"
#import "RACPropertyBindViewModel.h"
#import <CJBaseUIKit/CJTextField.h>

@interface RACBindTvPropertyViewController : CJUIKitBaseViewController

@property (nonatomic, strong) CJTextField *inTextField1;  /**< 有键盘修改问题的textField */
@property (nonatomic, strong) CJTextField *inTextField2;  /**< 有代码修改问题的textField */
@property (nonatomic, strong) CJTextField *inTextField3;  /**< 键盘和代码修改都没问题的textField */
@property (nonatomic, strong) CJTextField *inTextField4;  /**< 有键盘修改问题的textField */

@property (nonatomic, strong) CJTextField *outTextField1;  /**< 有键盘修改问题的textField */
@property (nonatomic, strong) CJTextField *outTextField2;  /**< 有代码修改问题的textField */
@property (nonatomic, strong) CJTextField *outTextField3;  /**< 键盘和代码修改都没问题的textField */


@property (nonatomic, strong) RACPropertyBindViewModel *viewModel;

@end
