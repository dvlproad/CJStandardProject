//
//  FindPasdPopupView.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "FindPasdPopupView.h"

@implementation FindPasdPopupView

- (IBAction)goOK:(id)sender{
    if ([self.delegate respondsToSelector:@selector(goOK_FindPasdPopupView:)]) {
        [self.delegate goOK_FindPasdPopupView:self];
    }
}

- (IBAction)goNo:(id)sender{
    if ([self.delegate respondsToSelector:@selector(goNo_FindPasdPopupView:)]) {
        [self.delegate goNo_FindPasdPopupView:self];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
