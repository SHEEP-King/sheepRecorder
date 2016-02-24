//
//  UIView+MRRound.h
//  BaseProject
//
//  Created by tarena04 on 15/12/30.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EZ)

- (void)setRoundLayer;
- (void)setRoundLayer:(CGFloat)radius;

- (CAEmitterLayer *)fireWorkLayer;
- (CAEmitterLayer *)snowLayer;

- (void)startBackgroundAnimation : (CALayer *)layer;
- (void)stopBackgroundAnimation : (CALayer *)layer;

@end
