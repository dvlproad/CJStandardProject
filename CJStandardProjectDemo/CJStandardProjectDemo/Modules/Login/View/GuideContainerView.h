//
//  GuideContainerView.h
//  CJTotalDemo
//
//  Created by ciyouzen on 2017/10/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "GuidePageView.h"

@interface GuideContainerView : UIView {
    
}
@property (nonatomic, copy) void (^skipHandle)(void);

- (void)addGuidePageViews:(NSArray<GuidePageView *> *)guidePageViews;


@end
