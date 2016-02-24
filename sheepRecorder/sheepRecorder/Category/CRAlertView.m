//
//  CRAlertView.m
//  albume
//
//  Created by Elon Zhang on 9/17/15.
//  Copyright © 2015 Elon Zhang. All rights reserved.
//

#import "CRAlertView.h"
#import "UIAlertController+Block.h"
#define LocalizedString(string) NSLocalizedString(string, nil)

@interface CRAlertView ()

@end

@implementation CRAlertView

+ (void)showMessage:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle message:(NSString *)message
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }
    
    if (title == nil) {
        title = @"";
    }
    [UIAlertController showAlertInViewController:presentingViewController
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:cancelTitle
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex)
     {
         
     }];
}

+ (void)showMessage:(NSString *)title message:(NSString *)message
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }

    [UIAlertController showAlertInViewController:presentingViewController
                                       withTitle:title message:message
                               cancelButtonTitle:LocalizedString(@"Cancel")
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex)
    {
        
    }];
}

+ (void)showBox:(NSString *)title otherTitles:(NSArray *)titlesArray actionBlock:(void (^)(NSUInteger buttonIndex))block
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }

    [UIAlertController showAlertInViewController:presentingViewController
                                       withTitle:title
                                         message:nil
                               cancelButtonTitle:LocalizedString(@"Cancel")
                          destructiveButtonTitle:nil
                               otherButtonTitles:@[LocalizedString(@"Add new Box"), LocalizedString(@"Add anther Box")]
                                        tapBlock:^(UIAlertController * controller, UIAlertAction * action, NSInteger buttonIndex)
    {
        block(buttonIndex);
    }];
}

+ (void)showMessage:(NSString *)message title:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)titlesArray actionBlock:(void (^)(NSUInteger buttonIndex))block
{
    if (title == nil) {
        title = @"";
    }
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }

    [UIAlertController showAlertInViewController:presentingViewController
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:cancelTitle
                          destructiveButtonTitle:nil
                               otherButtonTitles:titlesArray
                                        tapBlock:^(UIAlertController * controller, UIAlertAction * action, NSInteger buttonIndex)
     {
         block(buttonIndex);
     }];
}

+ (void)showActionSheet:(NSString *)title buttonTitles:(NSArray *)titlesArray actionBlock:(void (^)(NSUInteger buttonIndex))block
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }

    [UIAlertController showActionSheetInViewController:presentingViewController
                                             withTitle:title
                                               message:nil
                                     cancelButtonTitle:LocalizedString(@"Cancel")
                                destructiveButtonTitle:nil
                                     otherButtonTitles:titlesArray
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex)
    {
        block(buttonIndex);
    }];
}

+ (void)showDestructiveActionSheet:(NSString *)title destructiveButtonTitle:(NSString *)destructiveButtonTitle actionBlock:(void (^)(NSUInteger buttonIndex))block
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }
    
    [UIAlertController showActionSheetInViewController:presentingViewController
                                             withTitle:title
                                               message:nil
                                     cancelButtonTitle:LocalizedString(@"Cancel")
                                destructiveButtonTitle:destructiveButtonTitle
                                     otherButtonTitles:nil
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex)
     {
         block(buttonIndex);
     }];
}

@end
