//
//  CJDemoLayerFactory.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoLayerFactory.h"

@implementation CJDemoLayerFactory

/**
 *  绘制波浪线layer
 *
 *  @param size             波浪线所在的视图大小
 *  @param waveMaxHeight    波浪线最大高度
 */
+ (CAShapeLayer *)waveLayerInSize:(CGSize)size
                withWaveMaxHeight:(CGFloat)waveMaxHeight
{
    NSAssert(size.width > 8, @"波浪线宽度不能太小");
    NSAssert(size.height > 4, @"波浪线高度不能太小");
    
    waveMaxHeight = MIN(waveMaxHeight, size.height);
    
    CGFloat midY = size.height/2;
    CGFloat width = size.width;
    
    // 贝塞尔曲线的画法是由起点、终点、控制点三个参数来画的,控制点决定了它的曲率
    CGPoint starPoint = CGPointMake(0, midY);
    CGPoint endPoint = CGPointMake(size.width, midY);
    CGPoint controlPoint = CGPointMake(width*2/5, midY - waveMaxHeight/2);
    CGPoint controlPoint2 = CGPointMake(width*3/5, midY + waveMaxHeight/2);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:starPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint controlPoint2:controlPoint2];
    
    CAShapeLayer *waveLayer = [CAShapeLayer layer];
    waveLayer.path = path.CGPath;
    waveLayer.fillColor = [UIColor clearColor].CGColor;
    waveLayer.strokeColor = [UIColor blackColor].CGColor;
    
    return waveLayer;
}

@end
