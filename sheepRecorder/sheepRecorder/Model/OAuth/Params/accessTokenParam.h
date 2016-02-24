//
//  accessTokenParam.h
//  BaseProject
//
//  Created by tarena04 on 15/12/23.
//  Copyright © 2015年 sheep. All rights reserved.
//
/**
 
 HTTP请求方式
 POST
 请求参数
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。

 
 */

#import <Foundation/Foundation.h>
#import "ZXSingleton.h"

@interface accessTokenParam : NSObject
ZXSingletonH(accessTokenParam)

@property(nonatomic,strong)NSString *client_id;
@property(nonatomic,strong)NSString *client_secret;
@property(nonatomic,strong)NSString *grant_type;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *redirect_uri;

@end
