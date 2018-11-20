//
//  ZHScrollManagerViewController.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ZHScrollManagerViewController.h"
#import <YYKit.h>
#import "ZHTitleScrollView.h"
#import "ZHTool.h"
#import "ZHTitleCellModel.h"

@interface ZHScrollManagerViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

/** <##> */
@property (nonatomic, strong) UICollectionView *collectionView;
/** <##> */
@property (nonatomic, strong) ZHTitleScrollView *titleScrollView;
/** <##> */
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ZHScrollManagerViewController

- (instancetype)initWithTopScrollView:(ZHTitleScrollView *)topScrollView
{
    self = [super init];
    if (self) {
        self.titleScrollView = topScrollView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleScrollView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellIdentifier"];
    
    __weak typeof(self) _self = self;
    [self.titleScrollView setDidSelectItemBlock:^(ZHTitleScrollView *titleScrollView, NSUInteger page) {
        __strong typeof(_self) self = _self;
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }];
    
    [self.titleScrollView setLeftButtonTouchBlock:^(ZHTitleScrollView *titleScrollView) {
        __strong typeof(_self) self = _self;
        if (self.leftButtonTouchBlock) self.leftButtonTouchBlock(self);
    }];
    
    [self.titleScrollView setRightButtonTouchBlock:^(ZHTitleScrollView *titleScrollView) {
        __strong typeof(_self) self = _self;
        if (self.rightButtonTouchBlock) self.rightButtonTouchBlock(self);
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _titleScrollView.origin = CGPointMake(0, 0);
    _collectionView.frame = CGRectMake(0, _titleScrollView.bottom, self.view.width, self.view.height - _titleScrollView.height);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.dataArray = self.childViewControllers;
    
    // 组织title array,设置默认选项
    NSMutableArray *titleArray = [NSMutableArray new];
    for (UIViewController *vc in self.dataArray) {
        ZHTitleCellModel *model = [ZHTitleCellModel new];
        model.title = vc.title;
        if (titleArray.count == 0) {
            model.selected = YES;
        }
        [titleArray addObject:model];
    }
    self.titleScrollView.dataArray = titleArray;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellIdentifier" forIndexPath:indexPath];

    UIViewController *vc = _dataArray[indexPath.item];
    vc.view.frame = CGRectMake(0, 0, cell.contentView.width, cell.contentView.height);
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width, collectionView.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.titleScrollView colleectionViewDidEndDeceleratingPage:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
