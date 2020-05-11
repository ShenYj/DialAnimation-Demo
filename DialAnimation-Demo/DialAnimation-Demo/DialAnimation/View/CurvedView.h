//
//  CurvedLabel.h
//  DialAnimation-Demo
//
//  Created by ShenYj on 2020/5/11.
//  Copyright © 2020 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 空间内Label的高度
UIKIT_EXTERN CGFloat const kItemHeight;

@interface CurvedView : UIView

@property (nonatomic, assign) CGFloat  angle;
@property (nonatomic,  copy ) NSString *text;

@end

NS_ASSUME_NONNULL_END
