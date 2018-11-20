//
//  RootViewController.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "RootViewController.h"
#import "ZHScrollManagerViewController.h"
#import "ZHCustomManager.h"
#import "ZHTitleScrollView.h"
#import "ZHTool.h"
#import "ZHTitleCellModel.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZHTitleCellModel *model = [ZHTitleCellModel new];
    model.title = @"查勘";
    
    ZHTitleCellModel *model2 = [ZHTitleCellModel new];
    model2.title = @"定损损";
    model2.selected = YES;
    
    ZHTitleCellModel *model3 = [ZHTitleCellModel new];
    model3.title = @"复勘复勘";
    NSArray *dataArray = @[model, model2];
    
    ZHTitleScrollView *titleScrollView = [[ZHTitleScrollView alloc] initWithFrame:CGRectMake(0, 20, 350, 40)];
    titleScrollView.derection = ZHTitleScrollViewDirectionHorizontal;
    titleScrollView.dataArray = dataArray;
    [self.view addSubview:titleScrollView];
    
    ZHTitleScrollView *titleScrollView2 = [[ZHTitleScrollView alloc] initWithFrame:CGRectMake(0, 100, 150, 350)];
    titleScrollView2.derection = ZHTitleScrollViewDirectionVertical;
    titleScrollView2.dataArray = dataArray;
    [self.view addSubview:titleScrollView2];
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
