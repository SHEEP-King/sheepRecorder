//
//  MRLeftMenu.m
//  BaseProject
//
//  Created by tarena04 on 15/12/28.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "MRLeftMenu.h"

@implementation MRLeftMenu

ZXSingletonM(MRLeftMenu)

- (NSArray *)menuList
{
    return @[@"我的记录",@"我的消息",@"个人信息",@"今日天气",@"退出登录"];
}

@end
