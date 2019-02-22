//
//  DemoUser+PortraitImage.h
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2018/4/9.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoUser.h"

@interface DemoUser (PortraitImage)

/**
 *  获取头像
 *
 *  @param completeBlock 获取到头像后，执行的回调
 */
- (void)getPortraitImageWithCompleteBlock:(void(^)(UIImage *portraitImage))completeBlock;

/**
 *  选择完头像后，更新头像的本地相对路径(此操作会对头像进行保存)
 *
 *  @param choosePortraitImage 图片选择器选择的头像
 */
- (void)updatePortraitImageLocalRelativePathByChooseImage:(UIImage *)choosePortraitImage;

@end
