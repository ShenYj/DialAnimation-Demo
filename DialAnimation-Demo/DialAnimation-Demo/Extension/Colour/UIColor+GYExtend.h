//
//  UIColor+GYExtend.h
//  ShenYj
//
//  Created by Shen on 2019/11/22.
//  Copyright © 2019 ShenYj. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GYExtend)

#pragma mark - rgb色
/**
 *  设置RGB颜色
 *
 *  @param red   red: 0 ~ 255
 *  @param green green: 0 ~ 255
 *  @param blue  blue: 0 ~ 255
 *   @param alpha  alpha: 0 ~ 1
 *
 *  @return RGB颜色
 */
+ (UIColor *)rgb:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
/**
 *  设置RGB颜色
 *
 *  @param red   red: 0 ~ 255
 *  @param green green: 0 ~ 255
 *  @param blue  blue: 0 ~ 255
 *
 *  @return RGB颜色
 */
+ (UIColor *)rgb:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

#pragma mark - 灰色
/*!
 *     灰色:
 *
 *  @param number      0~255的数值,设置需要的灰度值
 *  @param alpha         0~1的数值,设置透明度
 *
 *  @discussion        设置指定灰度颜色
 */
+ (UIColor *)grayColor:(CGFloat)number alpha:(CGFloat)alpha;
/*!
 *   无透明的灰色
 *
 *  @param number      0~255的数值,设置需要的灰度值
 *
 *  @discussion        设置指定灰度颜色
 */
+ (UIColor *)grayColor:(CGFloat)number;

#pragma mark - 十六进制颜色

/**
 *  根据无符号的 32 位整数转换成对应的 RGB 颜色
 *
 *  @param hex hex
 *
 *  @return UIColor
 */
+ (instancetype)colorWithHex:(u_int32_t)hex;
+ (instancetype)colorWithHexString:(NSString *)hexString;

#pragma mark - 随机色

+ (UIColor *)randomColor;

#pragma mark - extend

+ (instancetype)rgba:(NSUInteger)rgba;

- (NSUInteger)rgbaValue;

@end

NS_ASSUME_NONNULL_END
