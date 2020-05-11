//
//  UIImageView+GYExtension.m
//  ShenYj
//
//  Created by ShenYj on 2020/3/19.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import "UIImageView+GYExtension.h"

@implementation UIImageView (GYExtension)

- (void)imageNamed:(NSString *)imageName WithRenderColour:(UIColor *)renderColour
{
    self.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = renderColour;
}

@end
