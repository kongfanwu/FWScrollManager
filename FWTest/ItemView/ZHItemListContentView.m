//
//  ZHItemListContentView.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ZHItemListContentView.h"
#import "ZHTool.h"
#import <YYKit.h>
#import "ZHItemCollectionViewCell.h"
#import "ZHItemListModel.h"

NSString *const ZHItemCollectionViewCellIdentifier2 = @"ZHItemCollectionViewCell2";
NSString *const ZHUICollectionReusableViewIdentifier = @"UICollectionReusableViewSection1";
NSString *const ZHUICollectionReusableViewIdentifier2 = @"UICollectionReusableViewSection2";

@interface ZHItemListContentView()<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZHItemListContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak __typeof__ (self) _self = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            __strong __typeof (_self) self = _self;
            if (self.removeFromSuperviewBlick) { self.removeFromSuperviewBlick(self); }
        }];
        tap.cancelsTouchesInView = NO;
        tap.delegate = self;
        [self addGestureRecognizer:tap];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake((ScreenWidth - 30 - (5 * 5)) / 5, 40);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        [_collectionView registerClass:[ZHItemCollectionViewCell class] forCellWithReuseIdentifier:ZHItemCollectionViewCellIdentifier2];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZHUICollectionReusableViewIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZHUICollectionReusableViewIdentifier2];
    }
    return self;
}

#pragma mark - 重写方法

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *v in self.subviews) {
        if (!v.hidden && CGRectContainsPoint(v.frame, point)) {
            return YES;
        }
    }
    return [super pointInside:point withEvent:event];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [_collectionView reloadData];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view.superview isKindOfClass:[ZHItemCollectionViewCell class]]) {
        return NO;
    }
    return YES;
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHItemListModel *model = _dataArray[indexPath.section][indexPath.item];
    ZHItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZHItemCollectionViewCellIdentifier2 forIndexPath:indexPath];
    cell.layer.cornerRadius = 7;
    cell.layer.masksToBounds = YES;
    cell.titleLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
    cell.titleLabel.text = model.title;
    cell.selected = model.selected;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ZHUICollectionReusableViewIdentifier forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = @"全部项目";
        titleLable.font = [UIFont systemFontOfSize:16];
        [titleLable sizeToFit];
        titleLable.textColor = RGBCOLOR(248, 166, 247);
        [reusableView addSubview:titleLable];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        [reusableView addSubview:imageView];
        
        titleLable.center = CGPointMake(reusableView.centerX - (imageView.width / 2), reusableView.centerY);
        imageView.frame = CGRectMake(titleLable.right, 0, 20, 20);
        imageView.centerY = reusableView.centerY;
        
        return reusableView;
    } else if (indexPath.section == 1) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ZHUICollectionReusableViewIdentifier2 forIndexPath:indexPath];
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = @"榜单";
        titleLable.font = [UIFont systemFontOfSize:16];
        [titleLable sizeToFit];
        [reusableView addSubview:titleLable];
        [titleLable sizeToFit];
        titleLable.left = 15;
        titleLable.centerY = 50 / 2;
        return reusableView;
    }
    return nil;
}

#pragma mark -  UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(collectionView.width, 50);
    } else if (section == 1) {
        return CGSizeMake(collectionView.width, 50);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHItemListModel *model = _dataArray[indexPath.section][indexPath.item];
    if (indexPath.section == 0 && indexPath.item == 0) {
        if (self.didSelectBlock) { self.didSelectBlock(self, nil); }
    } else {
        if (self.didSelectBlock) { self.didSelectBlock(self, model); }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
