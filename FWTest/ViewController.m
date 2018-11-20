//
//  ViewController.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ViewController.h"
#import "ZHItemListView.h"
#import "ZHItemListModel.h"

@interface ViewController ()

@property (nonatomic, copy) void (^block)(NSString *name);

@property (nonatomic, strong) ZHItemListView *itemListView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        ZHItemListModel *item = [ZHItemListModel new];
        [arr addObject:item];
        item.title = [NSString stringWithFormat:@"title%d", i];
        item.itemId = 100 + i;
        if (i == 0) {
            item.selected = YES;
        }
    }
    
    NSMutableArray *arr2 = [NSMutableArray new];
    NSArray *textArray = @[@"推荐", @"周榜", @"月榜",];
    for (int i = 0; i < textArray.count; i++) {
        ZHItemListModel *item = [ZHItemListModel new];
        item.title = textArray[i];
        item.itemId = 200 + i;
        [arr2 addObject:item];
    }
    
    NSMutableArray *dataArray = [[arr subarrayWithRange:NSMakeRange(0, 4)] mutableCopy];
    
    ZHItemListModel *item = [ZHItemListModel new];
    item.title = @"全部项目";
    item.itemId = 10000;
    [arr insertObject:item atIndex:0];
    NSMutableArray *allDataArray = [@[arr, arr2] mutableCopy];
    
    self.itemListView = [[ZHItemListView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 53)];
    [self.view addSubview:_itemListView];
    _itemListView.dataArray = dataArray;
    _itemListView.allDataArray = allDataArray;

    __weak __typeof__ (self) _self = self;
    [self.itemListView setDidSelectItem:^(ZHItemListView *itemListView, ZHItemListModel *model, NSIndexPath *indexPath) {
        __strong __typeof (_self) self = _self;
    }];
}



@end
