//
//  LXInspirationSectionHeaderView.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/5.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXInspirationSectionHeaderView.h"
#import "LXInspirationActivity.h"

@interface LXInspirationSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

- (IBAction)wishedBtnClick:(UIButton *)sender;
@end

@implementation LXInspirationSectionHeaderView

+ (instancetype)view {
    LXInspirationSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"LXInspirationSectionHeaderView" owner:self options:nil] lastObject];
    return headerView;
}

+ (instancetype)viewWithFrame:(CGRect)frame {
    LXInspirationSectionHeaderView *headerView = [self view];
    headerView.frame = frame;
    return headerView;
}

- (void)setInspiration:(LXInspirationActivity *)inspiration {
    _inspiration = inspiration;
    self.sectionLabel.layer.cornerRadius = self.sectionLabel.frame.size.width*0.5;
    self.sectionLabel.clipsToBounds = YES;
    self.sectionLabel.text = [NSString stringWithFormat:@"%ld", self.section+1];
    self.topicLabel.text = inspiration.topic;
}

#pragma mark - IBAction
- (IBAction)wishedBtnClick:(UIButton *)sender {
#warning todo
}

@end
