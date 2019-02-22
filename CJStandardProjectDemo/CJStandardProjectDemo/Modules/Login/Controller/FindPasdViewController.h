//
//  FindPasdViewController.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "CJDemoModuleLoginResourceUtil.h"

@interface FindPasdViewController : UIViewController{
    MBProgressHUD *HUD;
}
@property(nonatomic, weak) IBOutlet UITextField *tfEmail;

@end
