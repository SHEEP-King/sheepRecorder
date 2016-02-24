//
//  NSObject+Parse.h
//  BaseProject
//
//  Created by tarena04 on 15/12/17.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  1.解析类,解析的对象就两种:NSDictionary,NSArray
 *  2.每个解析类 都会有一个parse方法,传入字典/数组,返回当前对象
 *  3.解决 key不存在,value不存在而崩溃的问题(防御性编程)
 *  4.考虑 key和系统关键词冲突的问题
 *  5.考虑 解析类中存在数组的问题
 */

@interface NSObject (Parse)

//解析
+ (id)parse:(id)responseObj;

/** 子类重写 方法 返回某个key 所对应的 property */
// key: description property:desc
+ (NSString *)replacePropertyForKey:(NSString *)key;

/** 数组类型的解析:
 *  数组类型的key:应该由规定类 来解析
 *  比如:key:videoSidList , value:[Videosidlist class]
 */
+ (NSDictionary *)objectClassInArray;

+ (NSDictionary *)objectClassInObject;

@end
