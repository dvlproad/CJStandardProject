//
//  RACBindTvTextFieldViewController.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACBindTvTextFieldViewController.h"

@interface RACBindTvTextFieldViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;

@end



@implementation RACBindTvTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"RAC Bind TableView TextField", nil);
    
    [self setupViews];
    //[self bindViewModel]; //textField未获取，无法进行绑定
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self bindViewModel]; //textField未获取，无法进行绑定
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self bindViewModel];   //tableView中的textField绑定的正确时机
}

- (void)setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerClass:[RACTextFieldBindTableViewCell class] forCellReuseIdentifier:@"RACTextFieldBindTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;

    self.tableView.estimatedRowHeight = 44;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"RAC TextField";
    } else if (section == 1) {
        return @"RAC TextField";
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 || indexPath.section == 1) {
//        return 320;
//    }
//    return 44;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RACTextFieldBindTableViewCell *cell = (RACTextFieldBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RACTextFieldBindTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        
        if (indexPath.row == 0) {
            [self implementFlawKeyExampleInCell:cell];
        } else if (indexPath.row == 1) {
            [self implementFlawCodeExampleInCell:cell];
        } else if (indexPath.row == 2) {
            [self implementOKExampleInCell:cell];
        }
        return cell;
        
    } else if (indexPath.section == 1) {
        RACTextFieldBindTableViewCell *cell = (RACTextFieldBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RACTextFieldBindTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
