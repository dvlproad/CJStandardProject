//
//  CJDemoSheetFactory.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JGActionSheet/JGActionSheet.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoSheetFactory : NSObject {
    
}
+ (JGActionSheet *)pickImageSheetWithTakePhotoHandle:(void(^)(void))takePhotoHandle pickImageHandle:(void(^)(void))pickImageHandle;

@end

NS_ASSUME_NONNULL_END
