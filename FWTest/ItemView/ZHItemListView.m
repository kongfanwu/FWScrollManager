//
//  ZHItemListView.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ZHItemListView.h"
#import <YYKit.h>
#import "ZHItemCollectionViewCell.h"
#import "ZHItemListModel.h"
#import "ZHTool.h"
#import "ZHItemListContentView.h"

NSString *const ZHItemCollectionViewCellIdentifier = @"ZHItemCollectionViewCell";

@interface ZHItemListView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZHItemListContentView *itemListContentView;
@property (nonatomic, strong) NSMutableArray *topDataArray;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation ZHItemListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat leftRightW = ScreenWidth / 7;
        CGFloat collectionVieH = 53;
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, leftRightW, collectionVieH)];
        self.leftLabel = leftLabel;
        leftLabel.text = @"推荐";
        leftLabel.textColor = RGBCOLOR(248, 166, 247);
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:leftLabel];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(leftLabel.right, 0, ScreenWidth - leftRightW * 2, collectionVieH) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        [_collectionView registerClass:[ZHItemCollectionViewCell class] forCellWithReuseIdentifier:ZHItemCollectionViewCellIdentifier];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton = rightButton;
        rightButton.frame = CGRectMake(_collectionView.right, 0, leftRightW, collectionVieH);
        [rightButton setImage:[UIImage imageNamed:@"menuicon"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"menuicon"] forState:UIControlStateHighlighted];
        __weak __typeof__ (self) _self = self;
        [rightButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong __typeof (_self) self = _self;
            if (self.itemListContentView.superview) {
                [self removeItemListContentView];
            } else {
                [self addSubview:self.itemListContentView];
                self.itemListContentView.dataArray = self.allDataArray;
            }
        }];
        [self addSubview:rightButton];
        
    }
    return self;
}

- (void)removeItemListContentView {
    [self.itemListContentView removeFromSuperview];
    self.itemListContentView = nil;
}

- (BOOL)dataArrayExistItemId:(NSUInteger)itemID block:(void (^) (ZHItemListModel *))callback {
    BOOL exist = NO;
    for (ZHItemListModel *itemModel in self.dataArray) {
        if (itemID == itemModel.itemId) {
            exist = YES;
            if (callback) callback(itemModel);
        }
    }
    return exist;
}

- (ZHItemListContentView *)itemListContentView {
    if (!_itemListContentView) {
        // 项目有TabBar的话需要减去TabBar高度
        _itemListContentView = [[ZHItemListContentView alloc] initWithFrame:CGRectMake(0, self.height, self.width, ScreenHeight - self.frame.size.height - SafeAreaTopHeight)];
        __weak __typeof__ (self) _self = self;
        [_itemListContentView setDidSelectBlock:^(ZHItemListContentView *itemListContentView, ZHItemListModel *model) {
            __strong __typeof (_self) self = _self;
            
            if (model) {
                [self.dataArray makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
                
                if (![self dataArrayExistItemId:model.itemId block:^(ZHItemListModel *itemModel) {
                    itemModel.selected = YES;
                }])
                {
                    model.selected = YES;
                    [self.dataArray insertObject:model atIndex:0];
                    [self.dataArray removeLastObject];
                }
                
                [self.collectionView reloadData];
            }
            
            [self removeItemListContentView];
        }];
        
        [_itemListContentView setRemoveFromSuperviewBlick:^(ZHItemListContentView *itemListContentView) {
            __strong __typeof (_self) self = _self;
            [self removeItemListContentView];
        }];
    }
    return _itemListContentView;
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

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftRightW = ScreenWidth / (2 + self.dataArray.count);
    CGFloat collectionVieH = 53;
    self.leftLabel.frame = CGRectMake(0, 0, leftRightW, collectionVieH);
    self.collectionView.frame = CGRectMake(self.leftLabel.right, 0, ScreenWidth - leftRightW * 2, collectionVieH);
    self.rightButton.frame = CGRectMake(_collectionView.right, 0, leftRightW, collectionVieH);
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHItemListModel *model = _dataArray[indexPath.item];
    ZHItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZHItemCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = model.title;
    cell.selected = model.selected;
    return cell;
}

#pragma mark -  UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat leftRightW = ScreenWidth / (2 + self.dataArray.count);
    CGFloat collectionVieH = 53;
    return CGSizeMake(leftRightW, collectionVieH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 重置selected状态
    [_dataArray makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    ZHItemListModel *model = _dataArray[indexPath.item];
    model.selected = !model.selected;
    
    [collectionView reloadData];
    
    if (_itemListContentView) {
        [_itemListContentView removeFromSuperview];
        _itemListContentView = nil;
    }
    
    if (self.didSelectItem) { self.didSelectItem(self, model, indexPath); }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
