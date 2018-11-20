//
//  ZHItemListView.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHItemListModel;

@interface ZHItemListView : UIView

/** 数据源。第一次赋值，dataArray.count决定有几个按钮 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 所有数据源 */
@property (nonatomic, strong) NSMutableArray *allDataArray;

/**
 选中item回调
 */
@property (nonatomic, copy) void (^didSelectItem)(ZHItemListView *itemListView, ZHItemListModel *model, NSIndexPath * indexPath);

@end
