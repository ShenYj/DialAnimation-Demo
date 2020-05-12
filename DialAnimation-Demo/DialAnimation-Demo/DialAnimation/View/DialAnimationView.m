//
//  DialAnimationView.m
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/8.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import "DialAnimationView.h"
#import "UIColor+GYExtend.h"
#import "DialAnimationModel.h"
#import "SectorView.h"
#import "CurvedView.h"


@interface DialAnimationView ()
{
    /// 角度
    CGFloat _angle;
    /// 弧度
    CGFloat _radians;
    
    /// DrawRect
    CGRect _drawRect;
    /// 内环半径
    CGFloat _innerRadius;
    /// 中心点
    CGPoint _centerPoint;
}
/// 穴位 + 时辰
@property (nonatomic, strong) NSArray <DialAnimationModel *> *dataSources;
/// 中间的LOGO图片
@property (nonatomic, strong) UIImageView *centerLogoImageView;
/// 24h
@property (nonatomic, strong) NSArray <NSString *> *twentyFourHour;

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint movingPoint;

@end

@implementation DialAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDialAnimationView];
    }
    return self;
}

- (void)setupDialAnimationView
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds   = YES;
    [self addSubview:self.centerLogoImageView];
    
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(targetForLongPressGesture:)];
    longPressGes.minimumPressDuration          = 0.1f;
    longPressGes.numberOfTouchesRequired       = 1;
    [self addGestureRecognizer:longPressGes];
}

- (void)targetForLongPressGesture:(UISwipeGestureRecognizer *)gesture
{
    NSLog(@"%s", __func__);
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint point = [gesture locationInView:self];
            self.startPoint = point;
            NSLog(@"UIGestureRecognizerStateBegan: %@", NSStringFromCGPoint(point));
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [gesture locationInView:self];
            self.movingPoint = point;
            NSLog(@"UIGestureRecognizerStateChanged: %@", NSStringFromCGPoint(point));
            CGFloat angle = angleBetweenPoints(self.startPoint, self.movingPoint);
            [self animate:angle moving:YES];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            CGPoint point = [gesture locationInView:self];
            NSLog(@"UIGestureRecognizerStateEnded: %@", NSStringFromCGPoint(point));
            CGFloat angle = angleBetweenPoints(self.startPoint, point);
            [self animate:angle moving:NO];
        }
            break;
        default: {
            NSLog(@"Other");
        }
            break;
    }
}

- (void)drawRect:(CGRect)rect
{
    _drawRect           = rect;
    CGFloat radius      = MIN(rect.size.width * 0.5, rect.size.height * 0.5);
    CGPoint centerPoint = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    _centerPoint        = centerPoint;
    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                         radius:radius
                                                     startAngle:0
                                                       endAngle:M_PI * 2
                                                      clockwise:YES];
    [self.backgroundColor setFill];
    [path fill];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = rect;
    shapeLayer.path          = path.CGPath;
    self.layer.mask          = shapeLayer;
    
    [self show];
}

- (void)show
{
    CGFloat viewWidth   = MIN(self.frame.size.width, _drawRect.size.width);
    CGFloat viewHeight  = MIN(self.frame.size.height, _drawRect.size.height);
    
    CGPoint centerPoint = CGPointMake(viewWidth * 0.5, viewHeight * 0.5);
    
    CGFloat diameter    = MIN(viewWidth, viewHeight);
    CGFloat radius      = (diameter * 0.5);
    // 内环半径
    _innerRadius        = radius - 20.f;
    
    // 角度
    CGFloat bigAngle    = M_PI * 2 / self.dataSources.count;
    // 24h 角度
    CGFloat smalAngle   = M_PI * 2 / self.twentyFourHour.count;
    
    // b2 = a2 + c2 - 2ac Cos(B)
    CGFloat bigDiagonal   = sqrt((powf(_innerRadius, 2) + powf(_innerRadius, 2)) - 2*_innerRadius*_innerRadius*cos(bigAngle));
    CGFloat smallDiagonal = sqrt((powf(radius, 2) + powf(radius, 2)) - 2*radius*radius*cos(smalAngle));
    
    for (int i = 0; i < self.twentyFourHour.count; i ++) {
        NSString *hourString         = self.twentyFourHour[i];
        CurvedView *curvedView       = [[CurvedView alloc] init];
        curvedView.frame             = CGRectMake(0, 0, smallDiagonal, viewHeight);
        curvedView.center            = centerPoint;
        curvedView.angle             = smallDiagonal;
        curvedView.backgroundColor   = [UIColor rgb:71 green:77 blue:89 alpha:1.0];
        curvedView.text              = hourString;
        curvedView.transform         = CGAffineTransformMakeRotation(smalAngle * i);
        [self addSubview:curvedView];
    }
    
    for (int i = 0; i < self.dataSources.count; i ++) {
        DialAnimationModel *model          = self.dataSources[i];
        SectorView *rectangleBGView        = [[SectorView alloc] initWithSize:CGSizeMake(bigDiagonal, _innerRadius) angle:bigAngle];
        rectangleBGView.backgroundColor    = (i % 2 == 0) ? [UIColor rgba:4325678964] : [UIColor rgba:4278190335];
        rectangleBGView.center             = centerPoint;
        rectangleBGView.transform          = CGAffineTransformMakeRotation(bigAngle * i);
        rectangleBGView.model              = model;
        [self addSubview:rectangleBGView];
    }

    self.centerLogoImageView.bounds = CGRectMake(0, 0, radius, radius);
    self.centerLogoImageView.center = centerPoint;
    [self bringSubviewToFront:self.centerLogoImageView];
}

- (void)animate:(CGFloat)angle moving:(BOOL)moving
{
    CFTimeInterval duration     = moving ? 0.1f : 3.f;
    CABasicAnimation *rotation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.duration           = duration;
    rotation.fromValue          = @(0);
    rotation.byValue            = @(angle);
    [self.layer addAnimation:rotation forKey:nil];
}


CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};
CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return RADIANS_TO_DEGREES(rads);
    //degs = degrees(atan((top - bottom)/(right - left)))
}
CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    return RADIANS_TO_DEGREES(rads);
}

#pragma mark - lazy

- (UIImageView *)centerLogoImageView {
    if (!_centerLogoImageView) {
        _centerLogoImageView             = [[UIImageView alloc] init];
        _centerLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _centerLogoImageView.image       = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iosbodyoutline.png" ofType:nil]];
    }
    return _centerLogoImageView;
}
- (NSArray <NSString *> *)twentyFourHour {
    if (!_twentyFourHour) {
        _twentyFourHour = @[
            @"18",@"19",@"20",@"21",@"22",@"23",@"24",@"01",@"02",@"03",@"04",@"05",
            @"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",
        ];
    }
    return _twentyFourHour;
}
- (NSArray <DialAnimationModel *> *)dataSources {
    if (!_dataSources) {
        NSArray *sourceFile = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dialAnimationSource.plist" ofType:nil]];
        if (sourceFile) {
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:sourceFile.count];
            [sourceFile enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DialAnimationModel *model = [DialAnimationModel modelWithDict:obj];
                [tempArr addObject:model];
            }];
            _dataSources = tempArr.copy;
        }
        else {
            _dataSources = @[];
        }
    }
    return _dataSources;
}

@end
