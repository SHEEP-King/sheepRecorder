//
//  NSObject+Parse.m
//  BaseProject
//
//  Created by tarena04 on 15/12/17.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)

+ (id)parseArray:(NSArray *)arr
{
    NSMutableArray *array = [NSMutableArray array];
    for (id obj in arr) {
        [array addObject:[self parse:obj]];
    }
    return [array copy];
}

+ (id)parseDic:(NSDictionary *)dic
{
    id model = [[self alloc]init];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        /** 考虑key的问题 --  过滤key (关键词)*/
        key = [self replacePropertyForKey:key];
        /** 考虑数组的问题 */
        if ([obj isKindOfClass:[NSArray class]]) {
            //由子类重写的方法中获取array的key 所对应的解析类
            Class class = [self objectClassInArray][key];
            if (class) {
                obj = [class parse:obj];
            }
        }
        Class class = [self objectClassInObject][key];
        //字典中还有类
        if (class) {
            obj = [class parse:obj];
        }
        
        [model setValue:obj forKey:key];
    }];
    return model;
}


+ (id)parse:(id)responseObj
{
    if ([responseObj isKindOfClass:[NSArray class]]) {
        return [self parseArray:responseObj];
    }
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self parseDic:responseObj];
    }
    
    return responseObj;
}

//key 不存在
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
//value不存在
- (void)setNilValueForKey:(NSString *)key{}

/** 子类重写 方法 返回某个key 所对应的 property */
// key: description property:desc
/** 过滤key值方法:关键词 */
+ (NSString *)replacePropertyForKey:(NSString *)key
{
    //特殊情况处理
    if ([key isEqualToString:@"id"]) return @"ID";
    if ([key isEqualToString:@"description"]) return @"desc";
    
    return key;
}

/** 数组类型的解析:
 *  数组类型的key:应该由规定类 来解析
 *  比如:key:videoSidList , value:[Videosidlist class]
 */
/** 不实现 报错;此类只由子类重写 才有效 */
+ (NSDictionary *)objectClassInArray
{
    return nil;
}

+ (NSDictionary *)objectClassInObject
{
    return nil;
}

@end
