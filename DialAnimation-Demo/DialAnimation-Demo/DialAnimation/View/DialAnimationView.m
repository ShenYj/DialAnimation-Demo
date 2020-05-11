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
}

@property (nonatomic, strong) NSArray <DialAnimationModel *> *dataSources;

@property (nonatomic, strong) UIImageView *centerLogoImageView;


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
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(targetForSwipeGesture:)];
    swipeGesture.direction                 = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeGesture];
}

//    NSArray *titleWArr1 = @[@"17", @"18", @"19", @"20", @"21", @"22", @"23",@"24", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16"];

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
}
- (void)targetForSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    NSLog(@"%s", __func__);
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"UIGestureRecognizerStateBegan");
            CGPoint point = [gesture locationInView:self];
           
        }
            break;
        case UIGestureRecognizerStateChanged: {
            NSLog(@"UIGestureRecognizerStateChanged");
            CGPoint point = [gesture locationInView:self];
            
        }
            break;
        case UIGestureRecognizerStateEnded: {
            NSLog(@"UIGestureRecognizerStateEnded");
            
        }
            break;
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect
{
    _drawRect           = rect;
    CGFloat radius      = MIN(rect.size.width * 0.5, rect.size.height * 0.5);
    CGPoint centerPoint = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
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
    CGFloat angle       = M_PI * 2 / self.dataSources.count;

    // b2 = a2 + c2 - 2ac Cos(B)
    CGFloat diagonal = sqrt((powf(_innerRadius, 2) + powf(_innerRadius, 2)) - 2*_innerRadius*_innerRadius*cos(angle));
    
    for (int i = 0; i < self.dataSources.count; i ++) {
        DialAnimationModel *model          = self.dataSources[i];
        SectorView *rectangleBGView        = [[SectorView alloc] initWithSize:CGSizeMake(diagonal, _innerRadius) angle:angle];
        rectangleBGView.backgroundColor    = (i % 2 == 0) ? [UIColor rgba:4325678964] : [UIColor rgba:4278190335];
        rectangleBGView.center             = centerPoint;
        rectangleBGView.transform          = CGAffineTransformMakeRotation(angle * i);
        rectangleBGView.model              = model;
        [self addSubview:rectangleBGView];
    }
    
    self.centerLogoImageView.bounds = CGRectMake(0, 0, 120, 120);
    self.centerLogoImageView.center = centerPoint;
    [self bringSubviewToFront:self.centerLogoImageView];
}


#pragma mark - lazy

- (UIImageView *)centerLogoImageView {
    if (!_centerLogoImageView) {
        _centerLogoImageView             = [[UIImageView alloc] init];
        _centerLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _centerLogoImageView.image       = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"developer.png" ofType:nil]];
    }
    return _centerLogoImageView;
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
