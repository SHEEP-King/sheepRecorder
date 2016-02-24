//
//  accessTokenResult.h
//  BaseProject
//
//  Created by tarena04 on 15/12/23.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJParse.h"
#import "ZXCoding.h"

@interface accessTokenResult : NSObject<NSCoding>

@property(nonatomic,strong)NSString *access_token;
@property(nonatomic,strong)NSString *expires_in;
@property(nonatomic,strong)NSString *remind_in;
@property(nonatomic,strong)NSString *uid;

+ (void)saveLocation:(accessTokenResult *)result;

+ (instancetype)sharedAccessTokenResult;

+ (BOOL)isTimeOutAccessToken;

@end
