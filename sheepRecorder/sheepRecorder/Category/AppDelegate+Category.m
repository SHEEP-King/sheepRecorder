//
//  AppDelegate+Category.m
//  BaseProject
//
//  Created by tarena04 on 15/12/16.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "AppDelegate+Category.h"
//电池跳上网络活动提示(小菊花)
#import <AFNetworkActivityIndicatorManager.h>

@implementation AppDelegate (Category)

- (void)initializeWithApplication:(UIApplication *)application
{
//    //注册DDLog
//    [DDLog addLogger:[DDASLLogger sharedInstance]];
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];
//    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    //当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示 小菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    //能够检测当天网络wifi,蜂窝网络,没有网
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //网络发生变化时,会触发这里的代码
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"当前是wifi环境");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"当前是蜂窝网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"当前网络未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"当前无网络");
                break;
            default:
                break;
        }
    }];
    //开启检测
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    //网络活动发生变化时,会发送下方key的通知,可以在通知中心添加 监测:
    //AFNetworkingReachabilityDidChangeNotification
    /*
    [[NSNotificationCenter defaultCenter] addObserver:nil selector:nil name:AFNetworkingReachabilityDidChangeNotification object:nil];
    */
    
}




- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void)applicationWillResignActive:(UIApplication *)application {
   // [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
   // [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}


@end
