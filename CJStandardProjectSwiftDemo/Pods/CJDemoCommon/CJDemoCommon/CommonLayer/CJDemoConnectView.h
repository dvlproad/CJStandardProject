//
//  CJDemoConnectView.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoConnectView : UIView {
    
}
@property (nonatomic, assign) BOOL showWave;    /**< 显示波浪线，否则显示直线 */

- (instancetype)initWithFrame:(CGRect)frame waveMaxHeight:(CGFloat)waveMaxHeight NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
