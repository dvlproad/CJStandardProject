//
//  CJDemoLoginRequest.h
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2019/2/11.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoBaseRequest.h"

@interface CJDemoLoginRequest : CJDemoBaseRequest

- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)password
                        success:(void (^)(CJResponseModel *responseModel))success
                        failure:(void (^)(BOOL isRequestFailure, NSString *errorMessage))failure;

@end
