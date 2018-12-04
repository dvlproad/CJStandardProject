//
//  RACListenSelectedViewController.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//
//  RAC绑定tableView中的textField的例子

#import "CJUIKitBaseViewController.h"
#import <CJBaseUIKit/CJTextField.h>
#import "ListenSelectedSubjectViewModel.h"
#import "ListenSelectedObserveViewModel.h"
#import "ListenSelectedSignalViewModel.h"
#import "ListenSelectedPropertyViewModel.h"

@interface RACListenSelectedViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) CJTextField *subjectUserNameTextField;
@property (nonatomic, strong) CJTextField *observeUserNameTextField;
@property (nonatomic, strong) CJTextField *signalUserNameTextField;
@property (nonatomic, strong) CJTextField *textUserNameTextField;

@property (nonatomic, strong) ListenSelectedSubjectViewModel *subjectViewModel;
@property (nonatomic, strong) ListenSelectedObserveViewModel *observeViewModel;
@property (nonatomic, strong) ListenSelectedSignalViewModel *signalViewModel;
@property (nonatomic, strong) ListenSelectedPropertyViewModel *textViewModel;

@end
