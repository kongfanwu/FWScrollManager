//
//  ZHTool.h
//  FWTest
//
//  Created by 潇潇 on 2018/3/20.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#ifndef ZHTool_h
#define ZHTool_h

// 随机颜色
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define ScreenHeight   [[UIScreen mainScreen]bounds].size.height
#define ScreenWidth    [[UIScreen mainScreen]bounds].size.width
#define SafeAreaTopHeight (ScreenHeight == 812.0 ? 88 : 64)
#define SafeAreaTitleHeight (ScreenHeight == 812.0 ? 44 : 20)
#define SafeAreaTabarHeight (ScreenHeight == 812.0 ? 83 : 49)

#endif /* ZHTool_h */
