//
//  NSObject+Network.m
//  BaseProject
//
//  Created by tarena04 on 15/12/16.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "NSObject+Network.h"

@implementation NSObject (Network)

//线程安全单例
+ (AFHTTPSessionManager *)sharedAFManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer.timeoutInterval = 30;
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/jacascript",@"text/plain",@"text/json",@"application/json", nil];
        
        //http头
        //[manager.requestSerializer setValue:nil forHTTPHeaderField:nil];
    });
    
    return manager;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void(^)(id responseObj , NSError *error))completionHandle
{
    return [[self sharedAFManager]GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil,error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void(^)(id responseObj , NSError *error))completionHandle
{
    return [[self sharedAFManager]POST:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil,error);
    }];
}

//+ (id)POST:(NSString *)url parameters:(id)parameters withFormData:(id<AFMultipartFormData>)data completionHandle:(void(^)(id task,id operation, NSError *error))completHandle
//{
//    return [[self sharedAFManager]POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        formData = data;
//  } progress:^(NSProgress * _Nonnull uploadProgress) {
//      ;
//  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//      
//      completHandle(task,responseObject,nil);
//      
//  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//      
//      completHandle(task,nil,error);
//      
//  }];
//    
//}



@end
