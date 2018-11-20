//
//  ZHItemListContentView.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHItemListModel;

@interface ZHItemListContentView : UIView

/** 列表数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 选中回调 */
@property (nonatomic, copy) void (^didSelectBlock)(ZHItemListContentView *itemListContentView, ZHItemListModel *model);
/** 移除此对象 */
@property (nonatomic, copy) void (^removeFromSuperviewBlick)(ZHItemListContentView *itemListContentView);

@end
