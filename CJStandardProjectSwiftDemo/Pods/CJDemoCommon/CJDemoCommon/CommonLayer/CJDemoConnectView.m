//
//  CJDemoConnectView.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoConnectView.h"
#import "CJDemoLayerFactory.h"

@interface CJDemoConnectView () {
    
}
@property (nonatomic, strong) UIView *connectLine;  /**< 直线 */
@property (nonatomic, strong) CAShapeLayer *waveLayer;  /**< 波浪线 */
@property (nonatomic, assign, readonly) CGFloat waveMaxHeight;    /**< 波浪线的最大高度 */

@end

@implementation CJDemoConnectView

- (instancetype)initWithFrame:(CGRect)frame waveMaxHeight:(CGFloat)waveMaxHeight {
    self = [super initWithFrame:frame];
    if (self) {
        _waveMaxHeight = waveMaxHeight;
        [self.layer addSublayer:self.waveLayer];
        [self addSubview:self.connectLine];
        self.showWave = YES;
    }
    return self;
}

#pragma mark - Setter
- (void)setShowWave:(BOOL)showWave {
    _showWave = showWave;
    if (showWave) {
        self.waveLayer.hidden = NO;
        self.connectLine.hidden = YES;
    } else {
        self.waveLayer.hidden = YES;
        self.connectLine.hidden = NO;
    }
}

#pragma mark - Lazy
- (UIView *)connectLine {
    if (_connectLine == nil) {
        _connectLine = [[UIView alloc] init];
        _connectLine.backgroundColor = [UIColor blackColor];
        [self addSubview:_connectLine];
        
        CGFloat width = CGRectGetWidth(self.frame);
        
        [_connectLine setFrame:CGRectMake(0, 0, width, 1)];
        [_connectLine setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];
    }
    return _connectLine;
}


- (CAShapeLayer *)waveLayer {
    if (_waveLayer == nil) {
        _waveLayer = [CJDemoLayerFactory waveLayerInSize:self.frame.size withWaveMaxHeight:self.waveMaxHeight];
    }
    return _waveLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
