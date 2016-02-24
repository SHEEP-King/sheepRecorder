//
//  UIView+MRRound.m
//  BaseProject
//
//  Created by tarena04 on 15/12/30.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "UIView+MRRound.h"

@implementation UIView (MRRound)

- (void)setRoundLayer
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setRoundLayer:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor redColor].CGColor;
}

@end
