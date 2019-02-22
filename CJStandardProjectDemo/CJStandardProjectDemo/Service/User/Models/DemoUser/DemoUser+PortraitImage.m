//
//  DemoUser+PortraitImage.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2018/4/9.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoUser+PortraitImage.h"
#import <CJFile/CJFileManager+GetCreatePath.h>
#import <CJFile/CJFileManager+SaveFileData.h>

@implementation DemoUser (PortraitImage)

/* 完整的描述请参见文件头部 */
- (void)getPortraitImageWithCompleteBlock:(void(^)(UIImage *portraitImage))completeBlock {
    [self.imagePathFileModel getFileDataWithCompleteBlock:^(NSData *fileData) {
        UIImage *image = [UIImage imageWithData:fileData];
        if (image == nil) {
            image = [UIImage imageNamed:@"cjAvatar.png"];
        }
        if (completeBlock) {
            completeBlock(image);
        }
    }];
}


/* 完整的描述请参见文件头部 */
- (void)updatePortraitImageLocalRelativePathByChooseImage:(UIImage *)choosePortraitImage {
    NSString *relativeDirectory = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative bySubDirectoryPath:@"DemoUserImage" inSearchPathDirectory:NSDocumentDirectory createIfNoExist:YES];
    
    //保存选择的头像到本地
    NSString *imageName = [NSString stringWithFormat:@"avantar_%@.jpg", self.uid];
    NSData *imageData = UIImageJPEGRepresentation(choosePortraitImage, 1.0f);
    [CJFileManager saveFileData:imageData withFileName:imageName toRelativeDirectoryPath:relativeDirectory];
    
    //更新头像的本地相对路径
    NSString *localRelativePath = [relativeDirectory stringByAppendingPathComponent:imageName];
    //self.localRelativePath = localRelativePath;
    [self.imagePathFileModel updateLocalRelativePath:localRelativePath localSourceType:CJFileSourceTypeLocalSandbox];
}

@end
