//
//  CJDemoNetworkClient.h
//  CJDemoNetworkDemo
//
//  Created by ciyouzen on 2017/8/1.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CJNetwork/CJNetworkClient+SuccessFailure.h>
#import <CJNetwork/CJNetworkClient+CJDemoApp.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoNetworkClient : CJNetworkClient {
    
}

+ (CJDemoNetworkClient *)sharedInstance;


- (void)cjdemo_uploadImage:(UIImage *)image
              settingModel:(CJRequestSettingModel *)settingModel
             uploadSuccess:(void (^)(NSString *imageUrl, NSString *thumbnailUrl))uploadSuccess
             uploadFailure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))uploadFailure;

@end

NS_ASSUME_NONNULL_END
