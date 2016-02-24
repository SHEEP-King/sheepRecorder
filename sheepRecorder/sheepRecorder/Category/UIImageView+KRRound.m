//
//  UIImageView+KRRound.m
//  酷跑
//
//  Created by tarena04 on 15/12/8.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "UIImageView+KRRound.h"

@implementation UIImageView (KRRound)

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
