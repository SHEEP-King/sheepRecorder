//
//  accessTokenResult.m
//  BaseProject
//
//  Created by tarena04 on 15/12/23.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "accessTokenResult.h"
#import<objc/runtime.h>
#define kAccessTokenResultFile @"accessTokenResult.data"

@implementation accessTokenResult

ZXCodingAndDecodingWithRuntime(accessTokenResult)


+ (void)saveLocation:(accessTokenResult *)result
{
    [NSKeyedArchiver archiveRootObject:result toFile:kAccessTokenResultFile];
}

static accessTokenResult *_instance = nil;
+ (instancetype)sharedAccessTokenResult
{
    if (!_instance) {
        _instance  = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccessTokenResultFile];
    }
    return _instance;
}

+ (BOOL)isTimeOutAccessToken
{
    return NO;
}

@end
