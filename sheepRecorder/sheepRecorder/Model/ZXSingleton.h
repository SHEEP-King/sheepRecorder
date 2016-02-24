//
//  ZXSingleton.h
//  BaseProject
//
//  Created by tarena04 on 15/12/20.
//  Copyright © 2015年 sheep. All rights reserved.
//

//单例模式: 线程安全的单例模式
//重写 allocWithZone方法:可以截取所有的 alloc方法
//ARC

//.h文件内
#define ZXSingletonH(className) + (instancetype)shared##className;

//.m文件内
#if __has_feature(objc_arc) //若果是ARC模式下/不用处理release等方法

#define ZXSingletonM(className) \
static id instance = nil;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    if (instance == nil) {\
        static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
            instance = [super allocWithZone:zone];\
        });\
    }\
    return  instance;\
}\
\
- (instancetype)init\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        instance = [super init];\
    });\
    return instance;\
}\
\
+ (instancetype)shared##className\
{\
    return [[self alloc]init];\
}

#else //MRC模式下需单例需要处理 release等方法

#define ZXSingletonM(className) \
static id instance = nil;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
if (instance == nil) {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [super allocWithZone:zone];\
});\
}\
return  instance;\
}\
\
- (instancetype)init\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [super init];\
});\
return instance;\
}\
\
+ (instancetype)shared##className\
{\
return [[self alloc]init];\
}\
\
- (void)release{}\
- (id)retain\
{\
    return self;\
}\
- (NSUInteger)retainCount\
{\
    return 1;\
}

#endif /* ZXSingleton_h */
