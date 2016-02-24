//
//  NSObject+Parse2.m
//  BaseProject
//
//  Created by tarena04 on 15/12/17.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "NSObject+Parse2.h"

@implementation NSObject (Parse2)

//对数组的解析 = 最终还会 转化到字典的解析
+ (id)parseArray:(NSArray *)arr
{
    NSMutableArray *objects = [NSMutableArray array];
    
    for (id obj in arr) {
        [objects addObject:[ self parse:obj ]];
    }
    
    return objects;
}

+ (id)parseDic:(NSDictionary *)dic
{
    id model = [[self alloc] init];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //过滤关键字:
        key = [self replacedKeywordFromProperty:key];
        
        //如果key 是模型类数组? => 循环解析
        if ([obj isKindOfClass:[NSArray class]]) {
            Class class = [self objectClassInArray][key];
            if (class) {
                obj  = [class parse:obj];
            }
        }
        
        [model setValue:obj forKey:key];
        
    }];
    
    return model;
}


+ (id)parse:(id)responseObj
{
    id model = [[self alloc] init];
    //判断:如否是数组转换
    if ([responseObj isKindOfClass:[NSArray class]]) {
        
        return [self parseArray:responseObj];
    }
    //判断:如果是字典转换
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        
        return [self parseDic:responseObj];
    }
    
    return model;
}

+ (NSString *)replacedKeywordFromProperty:(NSString *)key
{
    if ([key isEqualToString:@"id"]) key = @"ID";
    if ([key isEqualToString:@"description"]) key = @"desc";
    
    return key;
}

+ (NSDictionary *)objectClassInArray
{
    return nil;
}

//key 为空 : 为不存在的key赋值会使程序崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

//value为空 : 为属性赋值为 空 可能导致程序崩溃
- (void)setNilValueForKey:(NSString *)key{}







/****************** 模型转字典************************/
/**
 *  在 http 请求时 需要传递一些字典参数
 *  而我们通常会定义 这些参数 为一个  参数模型
 *  获得模型对象值 之后我们需要 将参数模型对象 转化为 一个字典
*/

















@end
