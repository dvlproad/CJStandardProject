//
//  NSString+Encoding.m
//  HealthyDiet
//
//  Created by lichq on 15/3/25.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import "NSString+Encoding.h"

@implementation NSString (Encoding)

- (NSString *)Unicode_To_Chinese{
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr =
        /*
        [NSPropertyListSerialization propertyListFromData:tempData
                                         mutabilityOption:NSPropertyListImmutable
                                                   format:NULL
                                         errorDescription:NULL];
        */
        //iOS8.0以后
        [NSPropertyListSerialization propertyListWithData:tempData
                                                  options:NSPropertyListImmutable
                                                   format:NULL
                                                    error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}

@end
