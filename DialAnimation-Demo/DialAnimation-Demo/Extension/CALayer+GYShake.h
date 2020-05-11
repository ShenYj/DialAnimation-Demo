//
//  CALayer+GYShake.h
//  GyyxApp
//
//  Created by Shen on 2019/12/4.
//  Copyright © 2019 gyyx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (GYShake)

/**
 *  摇动
 */
- (void)shake;
/**
 *  缩放
 */
- (void)scale;
/**
 *  Y轴方向翻转
 */
- (void)rotation;

@end

NS_ASSUME_NONNULL_END
