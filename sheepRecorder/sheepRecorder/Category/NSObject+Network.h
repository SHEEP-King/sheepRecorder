//
//  NSObject+Network.h
//  BaseProject
//
//  Created by tarena04 on 15/12/16.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

//定义 宏 - 省略代码:NewsNetManager.h
#define kCompletionHandle completionHandle:(void(^)(id model ,NSError *error))completionHandle

/**
 *  请求类型:Get Post
 *  Get:    传递小型数据   /    --明文传递
 *  Post:   传递大型数据,zip/图片/音乐...  /  --简单加密
 *  具体使用哪个请求:由服务器人员决定
 */

@interface NSObject (Network)

+ (AFHTTPSessionManager *)sharedAFManager;

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void(^)(id responseObj , NSError *error))completionHandle;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void(^)(id responseObj , NSError *error))completionHandle;

//+ (id)POST:(NSString *)url parameters:(id)parameters withFormData:(id<AFMultipartFormData>)data completionHandle:(void(^)(id task,id operation, NSError *error))completHandle;

@end
