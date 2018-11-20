//
//  ZHTitleCellModel.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/21.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZHTitleCellModel : NSObject

@property (nonatomic) NSUInteger itemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) BOOL selected;

/** <##> */
@property (nonatomic) CGFloat rowWidth;
/** <##> */
@property (nonatomic) CGFloat rowHeight;
@end
