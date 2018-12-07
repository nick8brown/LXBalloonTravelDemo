//
//  LXSudokuActivityTableViewCell.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/12.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "LXSudokuActivityTableViewCell.h"
#import "LXSudokuActivityCollectionViewCell.h"

@interface LXSudokuActivityTableViewCell () <UICollectionViewDataSource>
@property (nonatomic, assign) CGFloat itemH;
@end

@implementation LXSudokuActivityTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    LXSudokuActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SudokuActivityTableViewCell_ID];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setActivitys:(NSArray *)activitys {
    _activitys = activitys;
    if (activitys) {
        // 初始化九宫格
        [self setupCollectionView];
    }
}

#pragma mark - 九宫格
- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [self setupFlowLayout];
    NSInteger row = [self numberOfRowsInCollectionViewWithDatasCount:self.activitys.count];
    CGFloat collectionViewH = row*self.itemH+(row-1)*layout.minimumLineSpacing;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screen_WIDTH, collectionViewH) collectionViewLayout:layout];
    collectionView.backgroundColor = bgColor;
    [collectionView registerNib:[UINib nibWithNibName:@"LXSudokuActivityCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:SudokuActivityCollectionViewCell_ID];
    collectionView.scrollEnabled = NO;
    collectionView.dataSource = self;
    [self.contentView addSubview:collectionView];
}
// 计算collectionView的行数
- (NSInteger)numberOfRowsInCollectionViewWithDatasCount:(NSInteger)count {
    if (iPhone5s) {
        if (count%numberOfItemsInRow_iPhone5s) {
            return count/numberOfItemsInRow_iPhone5s+1;
        } else {
            return count/numberOfItemsInRow_iPhone5s;
        }
    } else {
        if (count%numberOfItemsInRow_iPhone6s) {
            return count/numberOfItemsInRow_iPhone6s+1;
        } else {
            return count/numberOfItemsInRow_iPhone6s;
        }
    }
}
// 设置流水布局
- (UICollectionViewFlowLayout *)setupFlowLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = 0;
    if (iPhone5s) {
        layout.minimumInteritemSpacing = minimumInteritemSpacing_iPhone5s;
        itemW = (screen_WIDTH-(numberOfItemsInRow_iPhone5s-1)*layout.minimumInteritemSpacing)/numberOfItemsInRow_iPhone5s;
    } else if (iPhone6s) {
        layout.minimumInteritemSpacing = minimumInteritemSpacing_iPhone6s;
        itemW = (screen_WIDTH-(numberOfItemsInRow_iPhone6s-1)*layout.minimumInteritemSpacing)/numberOfItemsInRow_iPhone6s;
    } else if (iPhone6sPlus) {
        layout.minimumInteritemSpacing = minimumInteritemSpacing_iPhone6sPlus;
        itemW = (screen_WIDTH-(numberOfItemsInRow_iPhone6sPlus-1)*layout.minimumInteritemSpacing)/numberOfItemsInRow_iPhone6sPlus;
    }
    layout.minimumLineSpacing = layout.minimumInteritemSpacing;
    CGFloat itemH = itemW;
    self.itemH = itemH;
    layout.itemSize = CGSizeMake(itemW, itemH);
    return layout;
}

#pragma mark - UICollectionViewDataSource
// 项数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.activitys.count;
}
// cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXSudokuActivityCollectionViewCell *cell = [LXSudokuActivityCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.activity = self.activitys[indexPath.item];
    return cell;
}

@end
