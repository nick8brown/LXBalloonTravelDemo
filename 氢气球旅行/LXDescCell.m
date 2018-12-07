//
//  LXDescCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 15/12/24.
//  Copyright © 2015年 曾令轩. All rights reserved.
//

#import "LXDescCell.h"
#import "LXSearchViewController.h"
#import "LXMarkViewController.h"

@interface LXDescCell ()
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (nonatomic, weak) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation LXDescCell

- (NSDateFormatter *)formatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyy-MM-dd";
    }
    return _formatter;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = [tableView dequeueReusableCellWithIdentifier:DescCell_ID];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 点击手势
        [[self.contentView viewWithTag:Date_TAG] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateOnTap:)]];
        [[self.contentView viewWithTag:Place_TAG] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(placeOnTap:)]];
        [[self.contentView viewWithTag:Mark_TAG] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(markOnTap:)]];
        // 自定义键盘
        [self setupKeyboardForDateLabel];
    }
    return self;
}

#pragma mark - 点击手势
// 旅行日期
- (void)dateOnTap:(UITapGestureRecognizer *)recognizer {
    [self.dateTextField becomeFirstResponder];
}
// 目的地
- (void)placeOnTap:(UITapGestureRecognizer *)recognizer {
    LXSearchViewController *searchCtl = [[LXSearchViewController alloc] initWithNibName:@"LXSearchViewController" bundle:nil];
    [self.preCtl presentViewController:searchCtl animated:YES completion:nil];
}
// 标签
- (void)markOnTap:(UITapGestureRecognizer *)recognizer {
    LXMarkViewController *markCtl = [[LXMarkViewController alloc] initWithNibName:@"LXMarkViewController" bundle:nil];
    [self.preCtl.navigationController pushViewController:markCtl animated:YES];
}

#pragma mark - 自定义键盘
- (void)setupKeyboardForDateLabel {
    // 1.inputAccessoryView
        // 取消
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:mainThemeColor} forState:UIControlStateNormal];
        // 旅行日期
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithTitle:@"旅行日期" style:UIBarButtonItemStylePlain target:nil action:nil];
    [titleItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    titleItem.enabled = NO;
        // 完成
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(accomplish:)];
    [rightItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:mainThemeColor} forState:UIControlStateNormal];
        // 弹簧
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        // toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, toolbarH)];
    toolbar.barTintColor = [UIColor whiteColor];
    toolbar.items = @[leftItem, spaceItem, titleItem, spaceItem, rightItem];
    self.dateTextField.inputAccessoryView = toolbar;
    // 2.inputView
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.dateTextField.inputView = datePicker;
    self.datePicker = datePicker;
    // 3.监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDate:) name:UIKeyboardWillShowNotification object:nil];
}
// 取消
- (void)cancel:(UIBarButtonItem *)sender {
    [self.dateTextField resignFirstResponder];
}
// 完成
- (void)accomplish:(UIBarButtonItem *)sender {
    self.dateTextField.text = [self.formatter stringFromDate:self.datePicker.date];
    self.dateTextField.textColor = [UIColor darkGrayColor];
    [self cancel:sender];
}
// 设置datePicker默认显示时间
- (void)setDate:(NSNotification *)notification {
    NSDate *date = nil;
    if (![self.dateTextField.text isEqualToString:@"旅行日期"]) {
        date = [self.formatter dateFromString:self.dateTextField.text];
    } else {
        date = [self.formatter dateFromString:[self.formatter stringFromDate:[NSDate date]]];
    }
    [self.datePicker setDate:date animated:NO];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
