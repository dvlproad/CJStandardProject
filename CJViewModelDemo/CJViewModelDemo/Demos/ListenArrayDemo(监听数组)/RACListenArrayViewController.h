//
//  RACListenArrayViewController.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//
//  RAC绑定tableView中的textField的例子

#import "CJUIKitBaseHomeViewController.h"
#import <CJBaseUIKit/CJTextField.h>
#import "ListenArrayViewModel.h"

@interface RACListenArrayViewController : CJUIKitBaseHomeViewController {
    
}
@property (nonatomic, strong) ListenArrayViewModel *viewModel;

@end
