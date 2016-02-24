//
//  NSObject+Parse2.h
//  BaseProject
//
//  Created by tarena04 on 15/12/17.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parse2)

/**      字典 转  模型         */

/**
 *  键responseObj 转化成模型类
 *
 *  @param responseObj 需要转化的对象: 数组(NSAraay) / 字典(NSDictionary)
 *
 *  @return 模型类
 */
+ (id)parse:(id)responseObj;

/**
 *  替换字典/属性中的关键字: 包含常见的关键字,不需要用户自己调用
 *
 *  @return NSString
 */
+ (NSString *)replacedKeywordFromProperty:(NSString *)key;

/**
 *  告诉解析方法我的数组里面 : 是一个模型类的数组: 字典key : [ key class]
 *
 *  需要 用户 / 模型类  自己实现
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)objectClassInArray;



/**         模型  -  字典      */

- (NSDictionary *)dictionory;










@end
