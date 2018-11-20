//
//  ZHtitleScrollCollectionViewCell.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTitleCellModel;

@interface ZHtitleScrollCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (void)configureModel:(ZHTitleCellModel *)model;

@end
