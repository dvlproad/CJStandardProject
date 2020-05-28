//
//  CJDemoImageChooseView2.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/2.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  没有"重新选择"的图片选择视图(重新选择，需要先删掉再添加)

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import "RecognizeResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoImageChooseView2 : UIView {
    
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL allowPickImage;  /**< 是否允许选择图片(修改状态下才能允许选择) */
@property (nullable, nonatomic, strong) UIImage *image; /**< 当前视图上选择的图片 */

- (instancetype)initWithDefaultPhotoImage:(UIImage *)defaultPhotoImage
                             containTitle:(BOOL)containTitle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/// 设置图片选择和图片删除的点击处理事件
- (void)setupImageChooseHandle:(void(^)(void))imageChooseHandle
             imageDeleteHandle:(void(^)(CJDemoImageChooseView2 *imageChooseView))imageDeleteHandle;


/// 使用本地照片更新并显示识别结果
- (void)updatePhotoWithLocalImage:(UIImage *)photoImage
             recognizeResultModel:(nullable RecognizeResultModel *)recognizeResultModel;

/// 使用网络照片更新并显示识别结果
- (void)updatePhotoWithNetworkImageUrl:(NSString *)photoImageUrl
                  recognizeResultModel:(nullable RecognizeResultModel *)recognizeResultModel
                             completed:(void(^ _Nullable)(UIImage *image))completedBlock;

/// 删除图片
- (void)deleteImage;

#pragma mark - Class Method
+ (CGFloat)cellHeightWithContainTitle:(BOOL)containTitle;

@end

NS_ASSUME_NONNULL_END
