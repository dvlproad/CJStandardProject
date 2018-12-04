//
//  ListenSelectedObserveViewModel.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListenSelectedObserveViewModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, assign) BOOL userNameValid;   //必须可以调用setter,且里面必须调用self.xxx = xxx;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
