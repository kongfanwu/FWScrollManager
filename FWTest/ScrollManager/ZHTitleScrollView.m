//
//  ZHTitleScrollView.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ZHTitleScrollView.h"
#import "ZHtitleScrollCollectionViewCell.h"
#import <YYKit.h>
#import "ZHTool.h"
#import "ZHTitleCellModel.h"

NSString *const ZHtitleScrollCollectionViewCellIdentifier = @"ZHtitleScrollCollectionViewCell";

@interface ZHTitleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

/** <##> */
@property (nonatomic, strong) UICollectionView *collectionView;
/** <##> */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZHTitleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(247, 150, 212);
        self.derection = ZHTitleScrollViewDirectionHorizontal;
        
        CGFloat leftRightW = 0;
        CGFloat buttonH = self.height;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = _derection == ZHTitleScrollViewDirectionHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(leftRightW, 0, self.width - leftRightW * 2, buttonH) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGBCOLOR(247, 150, 212);
        [self addSubview:_collectionView];
        [_collectionView registerClass:[ZHtitleScrollCollectionViewCell class] forCellWithReuseIdentifier:ZHtitleScrollCollectionViewCellIdentifier];
    }
    return self;
}

- (void)setDerection:(ZHTitleScrollViewDirection)derection {
    _derection = derection;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) _collectionView.collectionViewLayout;
    layout.scrollDirection = _derection == ZHTitleScrollViewDirectionHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
}

- (void)setDataArray:(NSArray <ZHTitleCellModel *> *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)animationLineViewnextModel:(ZHTitleCellModel *)model indexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = (UICollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //cell在当前collection的位置
    CGRect cellRect = [_collectionView convertRect:cell.frame toView:_collectionView];
    [UIView animateWithDuration:0.5 animations:^{
        _lineView.left = cellRect.origin.x;
        _lineView.width = model.rowWidth;
    }];
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHtitleScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZHtitleScrollCollectionViewCellIdentifier forIndexPath:indexPath];
    ZHTitleCellModel *model = _dataArray[indexPath.item];
    [cell configureModel:model];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    return cell;
}

#pragma mark -  UICollectionViewDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) collectionViewLayout;
    if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        CGFloat allRowWidth = 0;
        for (ZHTitleCellModel *model in _dataArray) {
            allRowWidth += model.rowWidth;
        }
        CGFloat interitemSpacing = (collectionView.width - allRowWidth) / (_dataArray.count - 1);
        return interitemSpacing;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHTitleCellModel *model = _dataArray[indexPath.item];
    
    CGSize size = [model.title sizeForFont:[UIFont systemFontOfSize:16]
                                      size:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                      mode:NSLineBreakByTruncatingTail];
    if (_derection == ZHTitleScrollViewDirectionHorizontal) {
        model.rowWidth = size.width + 10;
        model.rowHeight = collectionView.height;
    } else {
        model.rowWidth = collectionView.width;
        model.rowHeight = size.height + 10;
    }
    return CGSizeMake(model.rowWidth, model.rowHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_dataArray makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    ZHTitleCellModel *model = _dataArray[indexPath.item];
    model.selected = YES;
    
    [self animationLineViewnextModel:model indexPath:indexPath];
    
    if(self.didSelectItemBlock) self.didSelectItemBlock(self, indexPath.item);
    
    [collectionView reloadData];
}

#pragma mark - ZHScrollManagerViewControllerDelegate

- (void)colleectionViewDidEndDeceleratingPage:(NSUInteger)page {
    ZHTitleCellModel *model = _dataArray[page];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:page inSection:0];
    [self animationLineViewnextModel:model indexPath:indexPath];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
