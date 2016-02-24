//
//  NSObject+MJParse.m
//  BaseProject
//
//  Created by tarena04 on 15/12/17.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "NSObject+MJParse.h"
//#import <MJExtension.h>

/**
 *  对 第三方 框架的 封装 - MJExtension
 */

@implementation NSObject (MJParse)

/**
 *  MJExtension 解析 数组和字典 需要使用 不同的方法.
 *  我们在自己的封装中,将两种方法 合并 ;
 */
//+ (instancetype)parse:(id)responseObj
//{
//    if ([responseObj isKindOfClass:[NSArray class]]) {
//        return [self mj_objectArrayWithKeyValuesArray:responseObj];
//    }
//    if ([responseObj isKindOfClass:[NSDictionary class]]) {
//        return [self mj_objectWithKeyValues:responseObj];
//    }
//    return responseObj;
//}



/**
 *  MJExtension 是从属性名 -> key
 *  如果key 就是desc,那么下放代码自动切换成description 则出错
 *
 *  @param propertyName propertyName description
 *
 *  @return return value description
 */

//+(NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
//{
//    if ([propertyName isEqualToString:@"ID"]) {
//        propertyName = @"id";
//    }
//    if ([propertyName isEqualToString:@"desc"]) {
//        propertyName = @"description";
//    }
//    return propertyName;
//}




@end

