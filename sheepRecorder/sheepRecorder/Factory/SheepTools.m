//
//  SheepTools.m
//  sheepRecorder
//
//  Created by Simon on 16/2/24.
//  Copyright © 2016年 sheep. All rights reserved.
//

#import "SheepTools.h"

@implementation SheepTools
ZXSingletonM(SheepTools)

//,00 G
+(float)checkUsedDisk
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    
    return [freeSpace doubleValue] / (1024.0 * 1024.0 *1024.0);
}

+ (float) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize] / (1024.0*1024.0);
    }
    return 0;
}
//获得文件夹（遍历）的大小 M
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}



@end
