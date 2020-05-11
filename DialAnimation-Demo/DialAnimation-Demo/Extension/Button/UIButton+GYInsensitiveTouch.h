//
//  UIButton+GYInsensitiveTouch.h
//  ShenYj
//
//  Created by Shen on 2020/1/6.
//  Copyright © 2020 ShenYj. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (GYInsensitiveTouch)

// 开启UIButton防连点模式
+ (void)enableInsensitiveTouch;
// 关闭UIButton防连点模式
+ (void)disableInsensitiveTouch;
// 设置防连续点击最小时间差(s),不设置则默认值是0.5s
+ (void)setInsensitiveMinTimeInterval:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
