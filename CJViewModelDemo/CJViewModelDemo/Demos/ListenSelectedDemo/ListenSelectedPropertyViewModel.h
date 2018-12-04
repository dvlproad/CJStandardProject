//
//  ListenSelectedPropertyViewModel.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListenSelectedPropertyViewModel : NSObject {
    
}
@property (nonatomic, copy) NSString *userName;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
