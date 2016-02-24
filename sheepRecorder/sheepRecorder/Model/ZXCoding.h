//
//  ZXCoding.h
//  BaseProject
//
//  Created by tarena04 on 15/12/20.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import<objc/runtime.h>
#ifndef ZXCoding_h
#define ZXCoding_h

/**
 *  利用底层知识: runtime 进行归档 和解档的操作
 *  runtime kvc
 *
 */
#define ZXCodingAndDecodingWithRuntime(className) \
\
- (void)encodeWithCoder:(NSCoder *)aCoder\
{\
    unsigned int count = 0;\
    Ivar *ivars = class_copyIvarList([className class], &count);\
 \
    for (int i= 0; i < count ; i ++ ) {\
        Ivar ivar = ivars[i];\
        const char *name = ivar_getName(ivar);\
        \
        NSString *key = [NSString stringWithUTF8String:name];\
        id value = [ self valueForKey:key ];\
        \
        [aCoder encodeObject:value forKey:key];\
    }\
\
    free(ivars);\
}\
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder\
{\
    if (self) {\
        \
        unsigned int count = 0;\
        \
        Ivar *ivars = class_copyIvarList([className class], &count);\
        \
        for (int i = 0; i < count; i++) {\
            const char *name = ivar_getName(ivars[i]);\
            NSString *key = [NSString stringWithUTF8String:name];\
  \
            id value = [aDecoder decodeObjectForKey:key];\
            \
            [self setValue:value forKey:key];\
        }\
        free(ivars);\
    }\
    return self;\
}


#endif /* ZXCoding_h */
