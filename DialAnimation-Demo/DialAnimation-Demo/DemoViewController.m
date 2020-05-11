//
//  ViewController.m
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/8.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import "DemoViewController.h"
#import "DialAnimationView.h"

@interface DemoViewController ()

@property (nonatomic, strong) DialAnimationView *dialAnimationView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.dialAnimationView];
    
//    [self.dialAnimationView show];
}


#pragma mark - lazy

- (DialAnimationView *)dialAnimationView {
    if (!_dialAnimationView) {
        CGRect rect = CGRectMake(10, 120, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.width - 20);
        _dialAnimationView = [[DialAnimationView alloc] initWithFrame:rect];
        _dialAnimationView.backgroundColor = [UIColor orangeColor];
    }
    return _dialAnimationView;;
}

@end
