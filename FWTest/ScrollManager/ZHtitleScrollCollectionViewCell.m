//
//  ZHtitleScrollCollectionViewCell.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ZHtitleScrollCollectionViewCell.h"
#import "ZHTool.h"
#import "ZHTitleCellModel.h"

@implementation ZHtitleScrollCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.contentView.bounds;
}

- (void)configureModel:(ZHTitleCellModel *)model {
    self.titleLabel.text = model.title;
    _titleLabel.textColor = model.selected ? UIColor.redColor : UIColor.whiteColor;
}

@end
