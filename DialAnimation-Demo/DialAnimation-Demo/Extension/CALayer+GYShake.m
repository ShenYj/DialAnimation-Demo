//
//  CALayer+GYShake.m
//  GyyxApp
//
//  Created by Shen on 2019/12/4.
//  Copyright © 2019 gyyx. All rights reserved.
//

#import "CALayer+GYShake.h"

@implementation CALayer (GYShake)

/**
 *  摇动
 */
- (void)shake
{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat keyFrameValue = 5;
    kfa.values          = @[@(-keyFrameValue),@(0),@(keyFrameValue),@(0),@(-keyFrameValue),@(0),@(keyFrameValue),@(0)];
    kfa.duration        = 0.3f;
    kfa.repeatCount     = 2;
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"shakeAnimation"];
}

/**
 *  缩放
 */
- (void)scale
{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    kfa.values          = @[@(1.0), @(1.1), @(0.9), @(1.0)];
    kfa.duration        = 0.3f;
    kfa.repeatCount     = 1;
    kfa.calculationMode = @"cubicPaced";
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"scaleAnimation"];
}
/**
 *  Y轴方向翻转
 */
- (void)rotation
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotateAnimation.duration = 1.2;
    rotateAnimation.repeatCount = 1;
    rotateAnimation.fromValue = @(0);
    rotateAnimation.toValue = @(M_PI * 2);
    [self addAnimation:rotateAnimation forKey:@"rotateAnimation"];
}

@end
