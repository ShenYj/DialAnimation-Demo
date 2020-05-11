//
//  UIImageView+GYExtension.h
//  ShenYj
//
//  Created by ShenYj on 2020/3/19.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GYExtension)

/**
 *  设置图片并指定渲染颜色.
 *
 * @param  imageName    图片URL地址
 * @param  renderColour 占位图名
 *
 * @discussion 如果icon的颜色不匹配, 可通过此方式指定颜色进行渲染
 */
- (void)imageNamed:(NSString *)imageName WithRenderColour:(UIColor *)renderColour;


@end

NS_ASSUME_NONNULL_END
