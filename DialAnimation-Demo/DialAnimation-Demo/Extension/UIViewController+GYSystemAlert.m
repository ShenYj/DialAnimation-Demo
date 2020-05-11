//
//  UIViewController+GYSystemAlert.m
//  ShenYj
//
//  Created by Shen on 2019/12/4.
//  Copyright © 2019 ShenYj. All rights reserved.
//

#import "UIViewController+GYSystemAlert.h"

@implementation UIViewController (GYSystemAlert)

- (void)alertWithoutInput:(nullable NSString *)title
                  message:(nullable NSString *)message
           preferredStyle:(UIAlertControllerStyle)preferredStyle
                  actions:(nullable UIAlertAction *)firstAction, ... NS_REQUIRES_NIL_TERMINATION
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:preferredStyle];
    if (firstAction) {
        // VA_LIST 是在C语言中解决变参问题的一组宏
        va_list argList;
        // 添加首个Action
        if ([firstAction isKindOfClass:[UIAlertAction class]]) {
            [alertController addAction:(UIAlertAction *)firstAction];
        }
        // VA_START宏，获取可变参数列表的第一个参数的地址,在这里是获取firstObj的内存地址,这时argList的指针 指向firstObj
        va_start(argList, firstAction);
        // 临时指针变量
        id temp;
        // VA_ARG宏，获取可变参数的当前参数，返回指定类型并将指针指向下一参数
        // 首先 argList的内存地址指向的fristObj将对应储存的值取出,如果不为nil则判断为真,将取出的值房在数组中,
        // 并且将指针指向下一个参数,这样每次循环argList所代表的指针偏移量就不断下移直到取出nil
        while ((temp = va_arg(argList, id))) {
            if (![temp isKindOfClass:[UIAlertAction class]]) {
                NSLog(@"%@ is not kind of UIAlertAction", temp);
                continue;
            }
            [alertController addAction:(UIAlertAction *)temp];
            NSLog(@"%@", ((UIAlertAction *)temp).title);
        }
        // 清空列表
        va_end(argList);
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    [self presentViewController:alertController animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

+ (UIViewController *)currentActivityController
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *currentViewController = window.rootViewController;
    
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else if ([currentViewController isKindOfClass:[UISplitViewController class]]) { // 当需要兼容 Ipad 时
                currentViewController = currentViewController.presentingViewController;
            } else {
                if (currentViewController.presentingViewController) {
                    currentViewController = currentViewController.presentingViewController;
                } else {
                    return currentViewController;
                }
            }
        }
    }
    
    return currentViewController;
}

@end
