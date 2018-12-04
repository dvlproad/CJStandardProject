//
//  ListenSelectedSubjectViewModel.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListenSelectedSubjectViewModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, assign, readonly) BOOL userNameValid;
@property (nonatomic, strong) RACSubject *userNameValidObject;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
