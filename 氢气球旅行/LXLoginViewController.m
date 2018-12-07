//
//  LXLoginViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/26.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXLoginViewController.h"
#import "LXSignInViewController.h"
#import "LXUserDB.h"
#import "LXLoginStatus.h"
#import "LXUser.h"
#import "MBProgressHUD+MJ.h"

@interface LXLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) LXUserDB *userDB;

- (IBAction)loginBtnClick:(UIButton *)sender;
@end

@implementation LXLoginViewController

- (LXUserDB *)userDB {
    if (_userDB == nil) {
        self.userDB = [LXUserDB shareUserDB];
    }
    return _userDB;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录携程账户";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(signIn:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.phoneNumberTextField becomeFirstResponder];
}
// 取消
- (void)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 注册
- (void)signIn:(UIBarButtonItem *)sender {
    LXSignInViewController *signInCtl = [[LXSignInViewController alloc] initWithNibName:@"LXSignInViewController" bundle:nil];
    [self.navigationController pushViewController:signInCtl animated:YES];
}

#pragma mark - 数据查询
- (NSArray *)findData {
    NSMutableArray *selectArray = [NSMutableArray array];
    [selectArray addObject:self.phoneNumberTextField.text];
    NSArray *modelArray = [self.userDB selectUser:selectArray];
    NSMutableArray *infoArray = [NSMutableArray array];
    for (LXUser *user in modelArray) {
        [infoArray addObject:user.password];
    }
    return infoArray;
    // 查询全部
    //    NSArray *modelArray = [self.userDB selectUser:nil];
    //    for (User *user in modelArray) {
    //        NSLog(@"ID:%@, name:%@, password:%@, age:%@", user.ID, user.name, user.password, user.age);
    //    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (isPhoneNumberNil || isPasswordNil) {
        [self.loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.loginBtn.enabled = NO;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!isPhoneNumberNil && !isPasswordNil) {
        [self.loginBtn setTitleColor:mainThemeColor forState:UIControlStateNormal];
        self.loginBtn.enabled = YES;
    }
    return YES;
}

#pragma mark - IBAction
- (IBAction)loginBtnClick:(UIButton *)sender {
    if (isPhoneNumber) {
        if (!isPasswordNil) {
            if ([[self findData] count]) {
                if ([self.passwordTextField.text isEqualToString:[[self findData] lastObject]]) {
                    [MBProgressHUD showSuccess:@"登录成功"];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    LXLoginStatus *loginStatus = [LXLoginStatus shareLoginStatus];
                    loginStatus.isLogin = YES;
                    [user setBool:loginStatus.isLogin forKey:login_status];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [self alertViewShow:@"密码错误"];
                }
            } else {
                [self alertViewShow:@"账户不存在"];
            }
        } else {
            [self alertViewShow:@"请输入密码"];
        }
    } else {
        [self alertViewShow:@"手机号码格式错误"];
    }
}

#pragma mark - 弹框
- (void)alertViewShow:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
