//
//  FindPasdViewController+Event.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "FindPasdViewController.h"
//#import <CJDemoDatabase/CJDemoDatabase.h>
//#import <CJDemoService/DemoUserFMDBFileManager.h>
#import "CJDemoServiceUserManager.h"

#import <CJBaseUIKit/UIView+CJPopupInView.h>
#import "FindPasdPopupView.h"

@interface FindPasdViewController (Event)<UITextFieldDelegate, MBProgressHUDDelegate, FindPasdPopupViewDelegate>

@end
