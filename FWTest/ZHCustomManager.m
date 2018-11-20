//
//  ZHCustomManager.m
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "ZHCustomManager.h"
#import "ZHVC1.h"
#import "ZHVC2.h"
#import "ZHVC3.h"

@interface ZHCustomManager ()

@end

@implementation ZHCustomManager

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) _self = self;
    [self setLeftButtonTouchBlock:^(ZHScrollManagerViewController *scrollManagerViewController) {
        __strong typeof(_self) self = _self;
        NSLog(@"setLeftButtonTouchBlock");
    }];
    
    [self setRightButtonTouchBlock:^(ZHScrollManagerViewController *scrollManagerViewController) {
        __strong typeof(_self) self = _self;
        NSLog(@"setRightButtonTouchBlock");
    }];
    
    [self loadViewControllers];
}

- (void)loadViewControllers {
    [self addChildClass:ZHVC1.class title:@"关注"];
    [self addChildClass:ZHVC2.class title:@"医生说"];
    [self addChildClass:ZHVC3.class title:@"达人秀"];
    [self addChildClass:ZHVC3.class title:@"美丽GO"];
}

- (void)addChildClass:(Class)clas title:(NSString *)title {
    id vc = [clas new];
    ((UIViewController *)vc).title = title;
    [self addChildViewController:vc];
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
