//
//  CJDemoCrypt.h
//  CJDemoCryptDemo
//
//  Created by ciyouzen on 2018/9/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJDemoCrypt : NSObject {
    
}
@property (nonatomic, strong) NSString *secretKey;  /**< 密钥 */


+ (CJDemoCrypt *)sharedInstance;

- (NSMutableDictionary *)encryptRequestParams:(NSDictionary *)params;
- (NSMutableDictionary *)decryptRequestBodyData:(NSData *)bodyData;

- (NSDictionary *)decryptResponseString:(NSString *)encryptResponseString;


@end
