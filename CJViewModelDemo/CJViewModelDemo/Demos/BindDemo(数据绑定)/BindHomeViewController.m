//
//  BindHomeViewController.m
//  CJViewModelDemo
//
//  Created by 李超前 on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "BindHomeViewController.h"
#import "RACTextFieldBindViewController.h"

@interface BindHomeViewController ()

@end

@implementation BindHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Bind(数据绑定)";
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"RACTextFieldBind";
            bindModule.classEntry = [RACTextFieldBindViewController class];
            [sectionDataModel.values addObject:bindModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    self.sectionDataModels = sectionDataModels;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
