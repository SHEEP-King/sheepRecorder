//
//  UILabel+CZImage.m
//  SHEEPWeibo
//
//  Created by sheep on 15/11/21.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "UIImage+EZImage.h"

@implementation UIImage (EZImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image =[UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imagewithStretchNamed:(NSString *)imageName
{
    UIImage *Image=[UIImage imageNamed:imageName];
    return [Image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
}

/** 将图片按size尺寸压缩 */
+ (instancetype)thumbnaiWithImage:(UIImage *)image size:(CGSize)size
{
    UIImage *newImage = nil;
    if (nil == image) {
        newImage = nil;
    }else{
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    return newImage;
}

//二维码图片
+ (UIImage *)QRCodeWithString:(NSString *)codeStr centerImage:(UIImage *)centerImage codeImageSize:(CGSize)size
{
    //二维码: 实质上就是字符串->通过一定的规则 ->转换成为图片
    /**
     1.准备一个字符串
     
     */
    //2.把字符串转化为 NSData类型数据
    NSData *data = [codeStr dataUsingEncoding:NSUTF8StringEncoding];
    //3.创建一个二维码 滤镜 - 二维码过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //4.data数据放入到过滤器当中
    [filter setValue:data forKey:@"inputMessage"];
    //5.启动过滤器 输出 二维码图片
    CIImage *ciImage = filter.outputImage;
    //CIImage -> UIImage
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    CGRect rect = CGRectMake(size.width*0.34, size.height*0.34, size.width*0.3, size.height*0.3);
    CGRect rect2 = CGRectMake(size.width*0.34-2, size.height*0.34-2, size.width*0.3+4, size.height*0.3+4);
    [centerImage drawInRect:rect];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect2 cornerRadius:size.width*0.2*0.2];
    [[UIColor whiteColor] setStroke];
    bezierPath.lineWidth = 5;
    [bezierPath addClip ];
    [bezierPath stroke];
    
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return codeImage;
}


//if lots of rounder - (offscreen rendering)
//instead of layer.cornerRadius
- (UIImage *)imageWithRoundCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f,0.f,sizeToFit};
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *output =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
    
}















@end
