//
//  CJDemoUIImagePickerControllerFactory.m
//  CJDemoModuleLoginDemoCommonDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoUIImagePickerControllerFactory.h"

@implementation CJDemoUIImagePickerControllerFactory

+ (MySingleImagePickerController *)imagePickerControllerWithPickImageFinishBlock:(void(^)(UIImage *image))pickImageFinishBlock {
    MySingleImagePickerController *singleImagePickerController = [[MySingleImagePickerController alloc] init];
    singleImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    singleImagePickerController.allowsEditing = YES;
    [singleImagePickerController setSingleMediaTypeForVideo:NO];
    singleImagePickerController.saveLocation = CJSaveLocationNone;
    [singleImagePickerController pickImageFinishBlock:pickImageFinishBlock pickVideoFinishBlock:nil pickCancelBlock:nil];
    
    return singleImagePickerController;
}

@end
