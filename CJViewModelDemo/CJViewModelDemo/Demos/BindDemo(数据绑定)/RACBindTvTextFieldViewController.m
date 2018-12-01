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
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"RAC TextField";
    } else if (section == 1) {
        return @"RAC TextField";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 320;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RACTextFieldBindTableViewCell *cell = (RACTextFieldBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RACTextFieldBindTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        
        if (indexPath.row == 0) {
            [self implementFlawExampleInCell:cell];
            
        } else if (indexPath.row == 1) {
            [self implementOKExampleInCell:cell];
        }
        return cell;
        
    } else if (indexPath.section == 1) {
        RACTextFieldBindTableViewCell *cell = (RACTextFieldBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RACTextFieldBindTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        
        if (indexPath.row == 0) {
            self.textField3 = cell.textField;
            
            NSString *codeString = @"\
            RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"会出现通过键盘给文本框赋值(文本框没收回来)时候，model的值没改变";
            cell.codeResultLabelText = codeResultString;
            
            [cell setupChangeTextFieldTextBlock:^{
                self.textField3.text = [NSString stringWithFormat:@"%d", rand()%100];
                
            } changeViewModelTextBlock:^{
                self.viewModel.text3 = [NSString stringWithFormat:@"%d", rand()%100];
                
            } printTextBlock:^{
                NSString *message1 = [NSString stringWithFormat:@"3.viewModel:%@, textField:%@", self.viewModel.text3, self.textField3.text];
                NSString *allMessage = [NSString stringWithFormat:@"\n----------------------------\n%@\n----------------------------", message1];
                NSLog(@"%@", allMessage);
            }];
            
        } else if (indexPath.row == 1) {
            self.textField4 = cell.textField;
            
            NSString *codeString = @"\
            RACChannelTo(self.viewModel, text2) = RACChannelTo(self.textField2, text);\
            \n\
            [self.textField2.rac_textSignal subscribe:RACChannelTo(self.textField2, text)];";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"会出现通过键盘给文本框赋值(文本框没收回来)时候，model的值没改变";
            cell.codeResultLabelText = codeResultString;
            
            [cell setupChangeTextFieldTextBlock:^{
                self.textField4.text = [NSString stringWithFormat:@"%d", rand()%100];
                
            } changeViewModelTextBlock:^{
                self.viewModel.text4 = [NSString stringWithFormat:@"%d", rand()%100];
                
            } printTextBlock:^{
                NSString *message1 = [NSString stringWithFormat:@"4.viewModel:%@, textField:%@", self.viewModel.text4, self.textField4.text];
                NSString *allMessage = [NSString stringWithFormat:@"\n----------------------------\n%@\n----------------------------", message1];
                NSLog(@"%@", allMessage);
            }];
        }
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
