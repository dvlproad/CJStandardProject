//
//  ListenSelectedSignalViewModel.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListenSelectedSignalViewModel : NSObject {
    
}
@property (nonatomic, copy) NSString *userName;
// 属性要用来监听的话，要确保其setter会被调用
@property (nonatomic, strong) RACSignal *userNameValidSignal;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
