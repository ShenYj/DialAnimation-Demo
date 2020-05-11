//
//  SectorView.m
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/9.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import "SectorView.h"
#import "CurvedView.h"
#import "UIColor+GYExtend.h"
#import "DialAnimationModel.h"



@interface SectorView ()
{
    CGFloat _height;
    CGFloat _width;
    
    CGSize _size;
    /// 角度
    CGFloat _angle;
    /// 弧度
    CGFloat _radians;
}


@property (nonatomic, strong) CurvedView *acupointView;
@property (nonatomic, strong) CurvedView *hourView;

@end

@implementation SectorView

- (instancetype)initWithSize:(CGSize)size angle:(CGFloat)angle
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        _size       = size;
        _angle      = angle;
        [self setupSectorView];
    }
    return self;
}

- (void)setupSectorView
{
    self.layer.anchorPoint  = CGPointMake(0.5, 1);
    self.backgroundColor    = [UIColor clearColor];
    self.clipsToBounds      = YES;
    
    [self addSubview:self.acupointView];
    [self addSubview:self.hourView];
    
}

- (void)drawRect:(CGRect)rect
{
    _width              = MIN(rect.size.width, _size.width);
    _height             = MIN(rect.size.height + rect.origin.y, _size.height);

    CGPoint centerPoint = CGPointMake(_width * 0.5, _height);
    CGFloat radius      = MAX(_width, _height);
    CGFloat startAngle  = M_PI * 3 / 2 - _angle * 0.5;
    CGFloat endAngle    = M_PI * 3 / 2 + _angle * 0.5;

    UIBezierPath *radiansPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                               radius:radius
                                                           startAngle:startAngle
                                                             endAngle:endAngle
                                                            clockwise:YES];
    [radiansPath addLineToPoint:centerPoint];
    [radiansPath closePath];
    [self.backgroundColor setFill];
    [radiansPath fill];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = rect;
    shapeLayer.path          = radiansPath.CGPath;
    self.layer.mask          = shapeLayer;
}

- (void)setModel:(DialAnimationModel *)model
{
    _model = model;
    self.acupointView.text = model.acupoint;
    self.hourView.text     = model.hour;
}

#pragma mark - lazy

- (CurvedView *)acupointView {
    if (!_acupointView) {
        _acupointView                 = [[CurvedView alloc] init];
        _acupointView.frame           = CGRectMake(0, 0, _size.width, _size.height);
        _acupointView.angle           = _angle;
        _acupointView.backgroundColor = [UIColor randomColor];
    }
    return _acupointView;;
}
- (CurvedView *)hourView {
    if (!_hourView) {
        _hourView                 = [[CurvedView alloc] init];
        _hourView.frame           = CGRectMake(0, kItemHeight, _size.width, _size.height - _acupointView.frame.origin.y - kItemHeight);
        _hourView.angle           = _angle;
        _hourView.backgroundColor = [UIColor randomColor];
    }
    return _hourView;;
}

@end
