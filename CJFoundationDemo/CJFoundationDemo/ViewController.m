//
//  ViewController.m
//  CJFoundationDemo
//
//  Created by dvlproad on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ViewController.h"
#import "StringViewController.h"
#import "DateViewController.h"

typedef NS_ENUM(NSUInteger, TabelIndexType) {
    TabelIndexTypeNSString,
    TabelIndexTypeNSDate,
};


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"Home首页", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    switch (indexPath.row) {
        case TabelIndexTypeNSString:
        {
            cell.textLabel.text = @"NSString";
            break;
        }
        case TabelIndexTypeNSDate:
        {
            cell.textLabel.text = @"NSDate";
            break;
        }
        default:
        {
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    
    switch (indexPath.row) {
        case TabelIndexTypeNSString:
        {
            StringViewController *viewController = [[StringViewController alloc] initWithNibName:@"StringViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"NSString", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case TabelIndexTypeNSDate:
        {
            DateViewController *viewController = [[DateViewController alloc] initWithNibName:@"DateViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"NSDate", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        default:
        {
            break;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
