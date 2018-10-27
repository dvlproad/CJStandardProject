//
//  GuideViewController.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuideViewController;
@protocol GuideViewControllerDelegate <NSObject>

@optional
- (void)guideViewControllerReadOver:(GuideViewController *)guideViewController;

@end

@interface GuideViewController : UIViewController

@property (nonatomic, weak) id<GuideViewControllerDelegate> delegate;

@end
