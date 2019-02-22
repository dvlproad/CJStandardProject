//
//  FindPasdPopupView.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FindPasdPopupView;
@protocol FindPasdPopupViewDelegate <NSObject>
@required
- (void)goOK_FindPasdPopupView:(FindPasdPopupView *)FindPasdPopupView;

@optional
- (void)goNo_FindPasdPopupView:(FindPasdPopupView *)FindPasdPopupView;

@end



@interface FindPasdPopupView : UIView

@property(nonatomic, strong) id<FindPasdPopupViewDelegate> delegate;
@property(nonatomic, strong) IBOutlet UILabel *lab;

@end
