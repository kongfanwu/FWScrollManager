//
//  ZHScrollManagerViewController.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTitleScrollView;

@interface ZHScrollManagerViewController : UIViewController

@property (nonatomic, copy) void (^leftButtonTouchBlock)(ZHScrollManagerViewController *scrollManagerViewController);
@property (nonatomic, copy) void (^rightButtonTouchBlock)(ZHScrollManagerViewController *scrollManagerViewController);

- (instancetype)initWithTopScrollView:(ZHTitleScrollView *)topScrollView;

@end
