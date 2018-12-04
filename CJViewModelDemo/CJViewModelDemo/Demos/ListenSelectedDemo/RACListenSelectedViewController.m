//
//  RACListenSelectedViewController.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACListenSelectedViewController.h"
#import "RACPropertyBindTableViewCell.h"

@interface RACListenSelectedViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;

@end



@implementation RACListenSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"RAC Listen Selected", nil);
    
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
    NSAssert(self.subjectUserNameTextField || self.observeUserNameTextField || self.signalUserNameTextField || self.textUserNameTextField, @"有textField未设置，无法进行下面的绑定，无法测试");
    
    // subjectViewModel
    ListenSelectedSubjectViewModel *subjectViewModel = [[ListenSelectedSubjectViewModel alloc] init];
    self.subjectViewModel = subjectViewModel;
    [subjectViewModel.userNameValidObject subscribeNext:^(id  _Nullable x) {
        BOOL userNameValid = [x boolValue];
        self.subjectUserNameTextField.leftButtonSelected = userNameValid;
    }];
    
    // observeViewModel
    ListenSelectedObserveViewModel *observeViewModel = [[ListenSelectedObserveViewModel alloc] init];
    RAC(self.observeUserNameTextField, leftButtonSelected) = RACObserve(observeViewModel, userNameValid);
    self.observeViewModel = observeViewModel;
    
    // textViewModel
    ListenSelectedPropertyViewModel *textViewModel = [[ListenSelectedPropertyViewModel alloc] init];
    RAC(self.textUserNameTextField, leftButtonSelected) = [RACObserve(textViewModel, userName) map:^id _Nullable(id  _Nullable value) {
        NSString *userName = (NSString *)value;
        return userName.length > 2 ? @(YES) : @(NO);
    }];
    self.textViewModel = textViewModel;
    
    // signalViewModel
    ListenSelectedSignalViewModel *signalViewModel = [[ListenSelectedSignalViewModel alloc] init];
    RAC(self.signalUserNameTextField, leftButtonSelected) = signalViewModel.userNameValidSignal;
    self.signalViewModel = signalViewModel;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"RAC监听selecte属性";
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
            self.subjectUserNameTextField = cell.textField;
            
            NSString *codeString = @"\
            [subjectViewModel.userNameValidObject subscribeNext:^(id  _Nullable x) {\
            BOOL userNameValid = [x boolValue];\
            self.subjectUserNameTextField.leftButtonSelected = userNameValid;\
        }];";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"1.通过RACSubject发射信号";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 1) {
            self.observeUserNameTextField = cell.textField;
            
            NSString *codeString = @"\
            RAC(self.observeUserNameTextField, leftButtonSelected) = RACObserve(observeViewModel, userNameValid);";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"2.通过RACObserve直接监听所要的值";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 2) {
            self.textUserNameTextField = cell.textField;
            
            NSString *codeString = @"\
            RAC(self.signalUserNameTextField, leftButtonSelected) = [RACObserve(signalViewModel, userName) map:^id _Nullable(id  _Nullable value) {\
            NSString *userName = (NSString *)value;\
            return userName.length > 2 ? @(YES) : @(NO);\
            }];";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"3.通过RACObserve监听其他值，map之后返回需要的值";
            cell.codeResultLabelText = codeResultString;
            
        } else if (indexPath.row == 3) {
            self.signalUserNameTextField = cell.textField;
            
            NSString *codeString = @"\
            RAC(self.textUserNameTextField, leftButtonSelected) = signalViewModel.userNameValidSignal;";
            cell.codeLabelText = codeString;
            
            NSString *codeResultString = @"4.将RACObserve监听时候创建的信号转移到viewModel中";
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
    
    if (textField == self.subjectUserNameTextField) {
        [self.subjectViewModel updateUserName:newText];
    } else if (textField == self.observeUserNameTextField) {
        [self.observeViewModel updateUserName:newText];
    } else if (textField == self.signalUserNameTextField) {
        [self.signalViewModel updateUserName:newText];
    } else if (textField == self.textUserNameTextField) {
        [self.textViewModel updateUserName:newText];
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
