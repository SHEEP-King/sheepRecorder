//
//  NSObject+HUD.h
//  BaseProject
//
//  Created by tarena04 on 15/12/17.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
/**
 *  对MBProgressHUD 的封装
 */
@interface NSObject (HUD)

/**
 *  弹出文字提示
 */
- (void)showAlert:(NSString *)text;

/**
*  显示忙 - 旋转的菊花
*/
- (void)showBusy;
/**
*  隐藏提示
*/
- (void)hideProgress;


@end
