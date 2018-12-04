//
//  RACBindTvPropertyViewController.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACBindTvPropertyViewController.h"
#import "RACPropertyBindTableViewCell.h"

@interface RACBindTvPropertyViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;

@end



@implementation RACBindTvPropertyViewController

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

- (void)bindViewModel {
    RACPropertyBindViewModel *viewModel = [[RACPropertyBindViewModel alloc] init];
    self.viewModel = viewModel;
    
    // 内部修改属性
    NSAssert(self.inTextField1 || self.inTextField2 || self.inTextField3 || self.inTextField4, @"有textField未设置，无法进行下面的绑定，无法测试");
    RAC(self.inTextField1, leftButtonSelected) = RACObserve(viewModel, inTextFieldValid1);
    RAC(self.inTextField2, leftButtonSelected) = RACObserve(viewModel, inTextFieldValid2);
    RAC(self.inTextField3, leftButtonSelected) = RACObserve(viewModel, inTextFieldValid3);
    RAC(self.inTextField4, leftButtonSelected) = RACObserve(viewModel, inTextFieldValid4);
    
    // 外部修改属性
    NSAssert(self.outTextField1 || self.outTextField2 || self.outTextField3 , @"有textField未设置，无法进行下面的绑定，无法测试");
    RAC(self.outTextField1, leftButtonSelected) = RACObserve(viewModel, outTextFieldValid1);
    RAC(self.outTextField2, leftButtonSelected) = RACObserve(viewModel, outTextFieldValid2);
    RAC(self.outTextField3, leftButtonSelected) = RACObserve(viewModel, outTextFieldValid3);
}

- (void)setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerClass:[RACPropertyBindTableViewCell class] forCellReuseIdentifier:@"RACPropertyBindTableViewCell"];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 3;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"内部修改属性";
    } else if (section == 1) {
        return @"外部修改属性";
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
        RACPropertyBindTableViewCell *cell = (RACPropertyBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RACPropertyBindTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        cell.textField.delegate = self;
        
        if (indexPath.row == 0) {
            self.inTextField1 = cell.textField;
            
            NSString *codeString = @"\
            self.inTextFieldValid1 = inTextFieldValid1;";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"Success";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 1) {
            self.inTextField2 = cell.textField;
            
            NSString *codeString = @"\
            _inTextFieldValid2 = inTextFieldValid2;";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"Failure";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 2) {
            self.inTextField3 = cell.textField;
            
            NSString *codeString = @"\
            [self setValue:@(inTextFieldValid3) forKey:@\"inTextFieldValid3\"];";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"Success";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 3) {
            self.inTextField4 = cell.textField;
            
            NSString *codeString = @"\
            [self setValue:@(inTextFieldValid4) forKey:@\"_inTextFieldValid4\"];;";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"Failure";
            cell.codeResultLabelText = codeResultString;
        }
        
        return cell;
        
    } else if (indexPath.section == 1) {
        RACPropertyBindTableViewCell *cell = (RACPropertyBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RACPropertyBindTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        cell.textField.delegate = self;
        
        if (indexPath.row == 0) {
            self.outTextField1 = cell.textField;
            
            NSString *codeString = @"\
            self.viewModel.outTextFieldValid1 = outTextFieldValid1;";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"Success";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 1) {
            self.outTextField2 = cell.textField;
            
            NSString *codeString = @"\
            [self.viewModel setValue:@(outTextFieldValid2) forKey:@\"outTextFieldValid2\"];";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"Success";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 2) {
            self.outTextField3 = cell.textField;
            
            NSString *codeString = @"\
            [self.viewModel setValue:@(outTextFieldValid3) forKey:@\"_outTextFieldValid3\"];";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"Failure";
            cell.codeResultLabelText = codeResultString;
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


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//根据用户名查找用户头像
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.inTextField1) {
        [self.viewModel updateVaildForInTextField1WithText:newText];
    } else if (textField == self.inTextField2) {
        [self.viewModel updateVaildForInTextField2WithText:newText];
    } else if (textField == self.inTextField3) {
        [self.viewModel updateVaildForInTextField3WithText:newText];
    } else if (textField == self.inTextField4) {
        [self.viewModel updateVaildForInTextField4WithText:newText];
    }
    
    if (textField == self.outTextField1) {
        BOOL outTextFieldValid1 = newText.length > 2 ? YES : NO;
        self.viewModel.outTextFieldValid1 = outTextFieldValid1;
    } else if (textField == self.outTextField2) {
        ///FIXME:为什么改变outTextFieldValid2的值会改变到outTextField3的显示
        BOOL outTextFieldValid2 = newText.length > 2 ? YES : NO;;
        [self.viewModel setValue:@(outTextFieldValid2) forKey:@"outTextFieldValid2"];
    } else if (textField == self.outTextField3) {
        BOOL outTextFieldValid3 = newText.length > 2 ? YES : NO;;
        [self.viewModel setValue:@(outTextFieldValid3) forKey:@"_outTextFieldValid3"];
    }
    
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
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
