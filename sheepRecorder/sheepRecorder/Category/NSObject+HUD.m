//
//  NSObject+HUD.m
//  BaseProject
//
//  Created by tarena04 on 15/12/17.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "NSObject+HUD.h"
#import <UIKit/UIKit.h>
#import <RESideMenu.h>

@implementation NSObject (HUD)

//获取当前视图上的View
- (UIView *)currentView:(id)controller
{
    UIViewController *vc = nil;
    if (controller == nil) {
        vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    }else
    {
        vc = controller;
    }
    //vc: 导航控制器,标签控制器,普通控制器
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController*)vc visibleViewController];
    }
    if ([vc isKindOfClass:[RESideMenu class]]) {
        
        vc = ((RESideMenu *)vc).presentedViewController;
        
        [self currentView:vc];
    }
    return vc.view;
}

/**
 *  弹出文字提示
 */
- (void)showAlert:(NSString *)text
{
    //防止在 非主线程中调用此方法,会报错
    dispatch_async(dispatch_get_main_queue(), ^{
        //弹出新的提示之前,要先把旧的隐藏掉
        [MBProgressHUD hideAllHUDsForView:[self currentView:nil] animated:YES];
        
        MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:[self currentView:nil] animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = text;
        [hud hide:YES afterDelay:1.5];
    });
}

/**
 *  显示忙 - 旋转的菊花
 */
- (void)showBusy
{
    //防止在 非主线程中调用此方法,会报错
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        //弹出新的提示之前,要先把旧的隐藏掉
        [MBProgressHUD hideAllHUDsForView:[self currentView:nil] animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self currentView:nil] animated:YES];
        //最长显示 30 秒
        [hud hide:YES afterDelay:30];
    }];
    
}

/**
 *  隐藏提示
 */
- (void)hideProgress
{
    //防止在 非主线程中调用此方法,会报错
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        [MBProgressHUD hideAllHUDsForView:[self currentView:nil] animated:YES];
    }];
}

@end
