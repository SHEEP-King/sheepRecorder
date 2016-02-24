//
//  MRUser.m
//  BaseProject
//
//  Created by tarena04 on 15/12/30.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "MRUser.h"

#define kMRUSERNAME @"userName"
#define kMRUSERPASSWORD @"userPassword"


@implementation MRUser

ZXSingletonM(MRUser)


/* 用户数据的沙盒读写 */
- (void) saveKRUserInfoToSandBox
{
    [[NSUserDefaults standardUserDefaults] setValue:self.userName forKey:kMRUSERNAME];
    [[NSUserDefaults standardUserDefaults] setValue:self.userPassword forKey:kMRUSERPASSWORD];
}


- (void) loadKRUserInfoFromSandBox
{
    self.userName = [[NSUserDefaults standardUserDefaults]objectForKey:kMRUSERNAME];
    self.userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kMRUSERPASSWORD];
}


@end
