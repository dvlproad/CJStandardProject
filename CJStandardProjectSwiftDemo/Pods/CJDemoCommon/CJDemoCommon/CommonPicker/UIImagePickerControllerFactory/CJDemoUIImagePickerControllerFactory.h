//
//  CJDemoUIImagePickerControllerFactory.h
//  CJDemoModuleLoginDemoCommonDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CJMedia/MySingleImagePickerController.h>

@interface CJDemoUIImagePickerControllerFactory : NSObject

+ (MySingleImagePickerController *)imagePickerControllerWithPickImageFinishBlock:(void(^)(UIImage *image))pickImageFinishBlock;


@end
