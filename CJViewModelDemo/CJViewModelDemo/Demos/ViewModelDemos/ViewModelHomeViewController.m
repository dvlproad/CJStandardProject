//
//  ViewModelHomeViewController.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "ViewModelHomeViewController.h"

#import "NormalBlockLoginViewController.h"
#import "BestBlockLoginViewController.h"

#import "DelegateLoginViewController.h"

#import "KVOLoginViewController.h"

#import "LowRACLoginViewController.h"
#import "MidRACLoginViewController.h"
#import "HighRACLoginViewController.h"

@interface ViewModelHomeViewController ()

@end

@implementation ViewModelHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"ViewModel首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Block ViewModel
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Block ViewModel";
        {
            CJModuleModel *viewModelModule = [[CJModuleModel alloc] init];
            viewModelModule.title = @"Block ViewModel(Normal)";
            viewModelModule.classEntry = [NormalBlockLoginViewController class];
            [sectionDataModel.values addObject:viewModelModule];
        }
        {
            CJModuleModel *viewModelModule = [[CJModuleModel alloc] init];
            viewModelModule.title = @"Block ViewModel(Best)";
            viewModelModule.classEntry = [BestBlockLoginViewController class];
            [sectionDataModel.values addObject:viewModelModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Delegate ViewModel
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Delegate ViewModel";
        {
            CJModuleModel *viewModelModule = [[CJModuleModel alloc] init];
            viewModelModule.title = @"Delegate ViewModel";
            viewModelModule.classEntry = [DelegateLoginViewController class];
            [sectionDataModel.values addObject:viewModelModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //KVO ViewModel
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"KVO ViewModel";
        {
            CJModuleModel *viewModelModule = [[CJModuleModel alloc] init];
            viewModelModule.title = @"KVO ViewModel";
            viewModelModule.classEntry = [KVOLoginViewController class];
            [sectionDataModel.values addObject:viewModelModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //RAC ViewModel
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"RAC ViewModel";
        {
            CJModuleModel *viewModelModule = [[CJModuleModel alloc] init];
            viewModelModule.title = @"RAC ViewModel(Low)";
            viewModelModule.classEntry = [LowRACLoginViewController class];
            [sectionDataModel.values addObject:viewModelModule];
        }
        {
            CJModuleModel *viewModelModule = [[CJModuleModel alloc] init];
            viewModelModule.title = @"RAC ViewModel(Mid)";
            viewModelModule.classEntry = [MidRACLoginViewController class];
            [sectionDataModel.values addObject:viewModelModule];
        }
        {
            CJModuleModel *viewModelModule = [[CJModuleModel alloc] init];
            viewModelModule.title = @"RAC ViewModel(High)";
            viewModelModule.classEntry = [HighRACLoginViewController class];
            [sectionDataModel.values addObject:viewModelModule];
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
