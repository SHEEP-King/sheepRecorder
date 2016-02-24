//
//  UILabel+CZImage.h
//  SHEEPWeibo
//
//  Created by sheep on 15/11/21.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import <UIKit/UIKit.h>
//为不渲染的图片添加一个分类--分类方法
@interface UIImage (EZImage)

/** 图片不渲染 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
/** 图片九切片拉伸 */
+ (instancetype)imagewithStretchNamed:(NSString *)imageName;

/** 将图片按size尺寸压缩 */
/** data数据压缩图片   NSData *data = UIImageJPEGRepresentation(newImage, 0.05); */
+ (instancetype)thumbnaiWithImage:(UIImage *)image size:(CGSize)size;



/**
 *  类方法: 二维码图片生成方法
 *
 *  @param codeStr     二维码内容 字符串
 *  @param centerImage 二维码图像中间的图片(headerImage)
 *  @param size        获得的二维码图片的大小
 *
 *  @return UIImage
 */
+ (UIImage *)QRCodeWithString:(NSString *)codeStr centerImage:(UIImage *)centerImage codeImageSize:(CGSize)size;


//if lots of rounder - (offscreen rendering)
//instead of layer.cornerRadius
- (UIImage *)imageWithRoundCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius;




@end
