//
//  CJDemoLayerFactory.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoLayerFactory : NSObject

/**
 *  绘制波浪线layer
 *
 *  @param size             波浪线所在的视图大小
 *  @param waveMaxHeight    波浪线最大高度
 */
+ (CAShapeLayer *)waveLayerInSize:(CGSize)size
                withWaveMaxHeight:(CGFloat)waveMaxHeight;

@end

NS_ASSUME_NONNULL_END
