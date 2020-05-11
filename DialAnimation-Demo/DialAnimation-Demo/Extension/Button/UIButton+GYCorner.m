//
//  UIButton+GYCorner.m
//  ShenYj
//
//  Created by Shen on 2019/11/25.
//  Copyright © 2019 ShenYj. All rights reserved.
//

#import "UIButton+GYCorner.h"

@implementation UIButton (GYCorner)

- (instancetype)initWithCorner:(CGFloat)cornerRadius
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 4;
        if (@available(iOS 11.0, *)) {
            self.layer.maskedCorners = kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMinXMinYCorner;
        } else {
            // Fallback on earlier versions
            self.layer.masksToBounds = YES;
        }
    }
    return self;
}

@end
