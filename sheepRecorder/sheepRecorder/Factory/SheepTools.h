//
//  SheepTools.h
//  sheepRecorder
//
//  Created by Simon on 16/2/24.
//  Copyright © 2016年 sheep. All rights reserved.
//

#import "Factory.h"
#import "ZXSingleton.h"


@interface SheepTools : Factory
ZXSingletonH(SheepTools)

//获取剩余空间： G
+(float)checkUsedDisk;

//获得单个文件的大小 :M
+ (float) fileSizeAtPath:(NSString*) filePath;
//获得文件夹（遍历）的大小 M
+ (float ) folderSizeAtPath:(NSString*) folderPath;


@end
