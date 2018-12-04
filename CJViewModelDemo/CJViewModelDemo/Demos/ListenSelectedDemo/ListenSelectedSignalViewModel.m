//
//  ListenSelectedSignalViewModel.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "ListenSelectedSignalViewModel.h"
#import "NSString+STDemoValidate.h"

@implementation ListenSelectedSignalViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _userNameValidSignal = [RACObserve(self, userName) map:^id _Nullable(id  _Nullable value) {
            NSString *userName = (NSString *)value;
            return userName.length > 2 ? @(YES) : @(NO);
        }];
    }
    return self;
}

#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    self.userName = userName;
}

@end
