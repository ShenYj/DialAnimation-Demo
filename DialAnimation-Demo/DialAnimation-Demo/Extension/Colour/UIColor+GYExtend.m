//
//  UIColor+GYExtend.m
//  ShenYj
//
//  Created by Shen on 2019/11/22.
//  Copyright © 2019 ShenYj. All rights reserved.
//

#import "UIColor+GYExtend.h"


@implementation UIColor (GYExtend)

#pragma mark - rgb色

+ (UIColor *)rgb:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    if (@available(iOS 10.0, *)) {
        return [UIColor colorWithDisplayP3Red:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
    } else 
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)rgb:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor rgb:red green:green blue:blue alpha:1.0];
}

#pragma mark - 灰色

+ (UIColor *)grayColor:(CGFloat)number alpha:(CGFloat)alpha
{
    return [UIColor rgb:number green:number blue:number alpha:alpha];
}

+ (UIColor *)grayColor:(CGFloat)number
{
    return [self grayColor:number alpha:1.0];
}

#pragma mark - 十六进制颜色

+ (instancetype)colorWithHex:(u_int32_t)hex
{
    int red = (hex & 0xFF0000) >> 16;
    int green = (hex & 0x00FF00) >> 8;
    int blue = hex & 0x0000FF;
    return [UIColor rgb:red green:green blue:blue alpha:1.0];
}

+ (instancetype)colorWithHexString:(NSString *)hexString
{
    if (!hexString)
        return nil;
    
    NSString* hex = [NSString stringWithString:hexString];
    if ([hex hasPrefix:@"#"])
        hex = [hex substringFromIndex:1];
    
    if (hex.length == 6)
        hex = [hex stringByAppendingString:@"FF"];
    else if (hex.length != 8)
        return nil;
    
    uint32_t rgba;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&rgba];
    return [UIColor rgba:rgba];
}

#pragma mark - 随机色

+ (UIColor *)randomColor
{
    CGFloat red = random() % 256;
    CGFloat green = random() % 256;
    CGFloat blue = random() % 256;
    return [UIColor rgb:red green:green blue:blue alpha:1.0];
}

#pragma mark - extend

+ (instancetype)rgba:(NSUInteger)rgba
{
    return [self rgb:(rgba >> 24)&0xFF green:(rgba >> 16)&0xFF blue:(rgba >> 8)&0xFF alpha:rgba&0xFF];
}

- (NSUInteger)rgbaValue
{
    CGFloat colorR, colorG, colorB, colorA;
    if ([self getRed:&colorR green:&colorG blue:&colorB alpha:&colorA]) {
        NSUInteger resultR = (NSUInteger)(colorR * 255 + 0.5);
        NSUInteger resultG = (NSUInteger)(colorG * 255 + 0.5);
        NSUInteger resultB = (NSUInteger)(colorB * 255 + 0.5);
        NSUInteger resultA = (NSUInteger)(colorA * 255 + 0.5);
        return (resultR << 24) | (resultG << 16) | (resultB << 8) | resultA;
    }
    return 0;
}

@end
