//
//  ListenSelectedPropertyViewModel.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "ListenSelectedPropertyViewModel.h"
#import "NSString+STDemoValidate.h"

@implementation ListenSelectedPropertyViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    self.userName = userName;
}

@end
