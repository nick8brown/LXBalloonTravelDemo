//
//  LXSignInViewController.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/26.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXSignInViewController.h"
#import "LXUserDB.h"
#import "LXUser.h"

@interface LXSignInViewController () <UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (nonatomic, strong) LXUserDB *userDB;
@property (nonatomic, copy) NSString *verifyNumber;

- (IBAction)verifyBtnClick:(UIButton *)sender;
- (IBAction)signInBtnClick:(UIButton *)sender;
- (IBAction)userClauseBtnClick:(UIButton *)sender;
@end

@implementation LXSignInViewController

- (LXUserDB *)userDB {
    if (_userDB == nil) {
        self.userDB = [LXUserDB shareUserDB];
        // 创建数据库表
        [self.userDB createTable];
    }
    return _userDB;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册携程账户";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.phoneNumberTextField becomeFirstResponder];
}
// 返回
- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据插入
- (void)insertData {
    NSArray *insertArray = [NSArray array];
    NSString *phoneNumber = [NSString stringWithFormat:@"%@", self.phoneNumberTextField.text];
    NSString *password = [NSString stringWithFormat:@"%@", self.passwordTextField.text];
    insertArray = @[phoneNumber, password];
    [self.userDB addUserWithParams:insertArray];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (isPhoneNumberNil || isPasswordNil || isVerifyNumberNil) {
        [self.signInBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.signInBtn.enabled = NO;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!isPhoneNumberNil && !isPasswordNil && !isVerifyNumberNil) {
        [self.signInBtn setTitleColor:mainThemeColor forState:UIControlStateNormal];
        self.signInBtn.enabled = YES;
    }
    return YES;
}

#pragma mark - IBAction
// 发送验证码
- (IBAction)verifyBtnClick:(UIButton *)sender {
    if (self.phoneNumberTextField.text.length == 11) {
        NSString *verifyNumber = [NSString stringWithFormat:@"%d", (arc4random()%899999)+100000];
        self.verifyNumber = verifyNumber;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"【LX科技】" message:[NSString stringWithFormat:@"此验证码只用于登录你的氢气球或更换绑定，验证码提供给他人将导致氢气球被盗。%d（氢气球验证码）。再次提醒，请勿转发", [verifyNumber intValue]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    } else {
        [self alertViewShow:@"请输入11位手机号码!"];
    }
}
// 注册
- (IBAction)signInBtnClick:(UIButton *)sender {
    if (isPhoneNumber) {
        if (!isPasswordNil) {
            if ([self.verifyNumberTextField.text isEqualToString:self.verifyNumber]) {
                // 数据插入
                [self insertData];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alertView.tag = 100;
                alertView.delegate = self;
                [alertView show];
            } else {
                [self alertViewShow:@"验证码不正确"];
            }
        } else {
            [self alertViewShow:@"密码不能为空!"];
        }
    } else {
        [self alertViewShow:@"请输入11位手机号码!"];
    }
}
// 使用条款
- (IBAction)userClauseBtnClick:(UIButton *)sender {
#warning todo 跳转网页查看
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 弹框
- (void)alertViewShow:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
