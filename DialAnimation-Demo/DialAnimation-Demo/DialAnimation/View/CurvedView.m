//
//  CurvedLabel.m
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/11.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import "CurvedView.h"

CGFloat const kItemHeight = 25.f;  /// 高度

@interface CurvedView ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CurvedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    self.backgroundColor  = [UIColor clearColor];
    [self addSubview:self.contentLabel];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.contentLabel.text = text;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(rect.size.width * 0.5, rect.size.height);
    CGFloat radius      = MAX(rect.size.width, rect.size.height + rect.origin.y);
    CGFloat startAngle  = M_PI * 3 / 2 - _angle * 0.5;
    CGFloat endAngle    = M_PI * 3 / 2 + _angle * 0.5;

    UIBezierPath *radiansPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                               radius:radius
                                                           startAngle:startAngle
                                                             endAngle:endAngle
                                                            clockwise:YES];
    [radiansPath addLineToPoint: CGPointMake(radiansPath.currentPoint.x, radiansPath.currentPoint.y + 25)];
    [radiansPath addArcWithCenter:centerPoint
                           radius:radius - 25
                       startAngle:endAngle
                         endAngle:startAngle
                        clockwise:NO];
    [radiansPath closePath];
    [self.backgroundColor setFill];
    [radiansPath fill];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = rect;
    shapeLayer.path          = radiansPath.CGPath;
    self.layer.mask          = shapeLayer;
    
    self.contentLabel.frame = CGRectMake(0, 0, rect.size.width, 25);
}

#pragma mark - lazy

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel                  = [[UILabel alloc] init];
        _contentLabel.font             = [UIFont systemFontOfSize:12];
        _contentLabel.textColor        = [UIColor whiteColor];
        _contentLabel.backgroundColor  = self.backgroundColor;
        _contentLabel.textAlignment    = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
