//
//  ListenSelectedSubjectViewModel.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "ListenSelectedSubjectViewModel.h"
#import "NSString+STDemoValidate.h"

@implementation ListenSelectedSubjectViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _userNameValidObject = [RACSubject subject];
    }
    return self;
}

#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    _userNameValid = [self.userName stdemo_checkUserName];
    
    [self.userNameValidObject sendNext:@(self.userNameValid)];
}

@end
