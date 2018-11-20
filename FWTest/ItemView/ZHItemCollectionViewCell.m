//
//  ZHItemCollectionViewCell.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ZHItemCollectionViewCell.h"

@interface ZHItemCollectionViewCell()

@end

@implementation ZHItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:self];
    _titleLabel.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
}

@end
