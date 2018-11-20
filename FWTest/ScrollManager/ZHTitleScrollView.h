//
//  ZHTitleScrollView.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTitleCellModel;

typedef NS_ENUM(NSInteger, ZHTitleScrollViewDirection) {
    ZHTitleScrollViewDirectionHorizontal,
    ZHTitleScrollViewDirectionVertical,
};

@interface ZHTitleScrollView : UIView

/**  */
@property (nonatomic, strong) NSArray <ZHTitleCellModel *> *dataArray;
/** 默认 ZHTitleScrollViewDirectionHorizontal */
@property (nonatomic) ZHTitleScrollViewDirection derection;


/** 点击后切换控制器 */
@property (nonatomic, copy) void (^didSelectItemBlock)(ZHTitleScrollView *titleScrollView, NSUInteger page);
@property (nonatomic, copy) void (^leftButtonTouchBlock)(ZHTitleScrollView *titleScrollView);
@property (nonatomic, copy) void (^rightButtonTouchBlock)(ZHTitleScrollView *titleScrollView);



- (void)colleectionViewDidEndDeceleratingPage:(NSUInteger)page;


@end
