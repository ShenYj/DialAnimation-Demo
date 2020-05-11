//
//  SectorView.h
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/9.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
/// 角度转弧度 (把角度转换成PI的方式)
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@class DialAnimationModel;
@interface SectorView : UIView

- (instancetype)initWithSize:(CGSize)size angle:(CGFloat)angle;

@property (nonatomic, strong) DialAnimationModel *model;

@end

NS_ASSUME_NONNULL_END
