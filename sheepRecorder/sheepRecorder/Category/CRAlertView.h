//
//  CRAlertView.h
//  albume
//
//  Created by Elon Zhang on 9/17/15.
//  Copyright © 2015 Elon Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRAlertView : UIAlertController

//+ (void)showMessage:(NSString *)title message:(NSString *)message;
+ (void)showMessage:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle message:(NSString *)message;
+ (void)showBox:(NSString *)title otherTitles:(NSArray *)titlesArray actionBlock:(void (^)(NSUInteger buttonIndex))block;
+ (void)showMessage:(NSString *)message title:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)titlesArray actionBlock:(void (^)(NSUInteger buttonIndex))block;
+ (void)showActionSheet:(NSString *)title buttonTitles:(NSArray *)titlesArray actionBlock:(void (^)(NSUInteger buttonIndex))block;
+ (void)showDestructiveActionSheet:(NSString *)title destructiveButtonTitle:(NSString *)destructiveButtonTitle actionBlock:(void (^)(NSUInteger buttonIndex))block;
@end
