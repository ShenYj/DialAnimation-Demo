//
//  UIViewController+GYSystemAlert.h
//  ShenYj
//
//  Created by Shen on 2019/12/4.
//  Copyright © 2019 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GYSystemAlert)

/**
 *    无回调无TextInput样式的 UIAlertController
 *
 * @param  title                               标题.
 * @param  message                           内容.
 * @param  preferredStyle            系统样式.
 * @param  firstAction    Action. 如果一个Action都没有, name弹层3s展示后自动Dismiss
 *
 * @exception UIAlertController只允许添加一个UIAlertActionStyleCancel样式的Action, 添加多个会Crash, 需注意. 另最后需要传入nil结尾
 */
- (void)alertWithoutInput:(nullable NSString *)title
                  message:(nullable NSString *)message
           preferredStyle:(UIAlertControllerStyle)preferredStyle
                  actions:(nullable UIAlertAction *)firstAction, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *
 *    查找当前活动控制器
 *
 */
+ (UIViewController *)currentActivityController;

@end

NS_ASSUME_NONNULL_END
