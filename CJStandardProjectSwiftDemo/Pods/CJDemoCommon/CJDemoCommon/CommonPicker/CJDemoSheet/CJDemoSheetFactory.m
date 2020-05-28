//
//  CJDemoSheetFactory.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDemoSheetFactory.h"

@implementation CJDemoSheetFactory

+ (JGActionSheet *)pickImageSheetWithTakePhotoHandle:(void(^)(void))takePhotoHandle pickImageHandle:(void(^)(void))pickImageHandle {
    NSArray *sheetButtonTitles = @[NSLocalizedString(@"拍摄", nil),
                                   NSLocalizedString(@"从手机相册选择", nil),];
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:sheetButtonTitles buttonStyle:JGActionSheetButtonStyleDefault];
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[NSLocalizedString(@"取消", nil)] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section1, cancelSection];
    
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                !takePhotoHandle ?: takePhotoHandle();
            } else {
                !pickImageHandle ?: pickImageHandle();
            }
        }
        [sheet dismissAnimated:YES];
    }];
    [sheet setOutsidePressBlock:^(JGActionSheet *sheet){
        [sheet dismissAnimated:YES];
    }];
    
    return sheet;
}

@end
