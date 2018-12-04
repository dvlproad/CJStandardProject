//
//  ListenSelectedObserveViewModel.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "ListenSelectedObserveViewModel.h"
#import "NSString+STDemoValidate.h"

@implementation ListenSelectedObserveViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    self.userNameValid = [self.userName stdemo_checkUserName];
}

@end
