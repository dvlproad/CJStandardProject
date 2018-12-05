//
//  ListenArrayHomeViewController.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "ListenArrayHomeViewController.h"

#import "RACListenArrayViewController.h"

@interface ListenArrayHomeViewController ()

@end

@implementation ListenArrayHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"Listen Array(监听数组)", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Listen Array(监听数组)";
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"RAC Listen Array";
            bindModule.classEntry = [RACListenArrayViewController class];
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
