//
//  DialAnimationModel.h
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/9.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DialAnimationModel : NSObject

@property (nonatomic, copy) NSString *acupoint;
@property (nonatomic, copy) NSString *hour;


+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
