//
//  ZHItemListModel.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHItemListModel : NSObject

@property (nonatomic) NSUInteger itemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) BOOL selected;

@end
