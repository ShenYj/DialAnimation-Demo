//
//  DialAnimationModel.m
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/9.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import "DialAnimationModel.h"

@implementation DialAnimationModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
