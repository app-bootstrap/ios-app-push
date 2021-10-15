//
//  AppDelegate.m
//  ios-app-push
//
//  Created by xdf on 2021/10/14.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <MPPushSDK/MPPushSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

// https://help.aliyun.com/document_detail/69758.html

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSDictionary *userInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 10.0) {
        // iOS 10 以下 Push 冷启动处理
        [self printLog:userInfo];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 绑定设备token
    [[PushService sharedService] setDeviceToken:deviceToken];
    // 绑定用户
    [[PushService sharedService] pushBindWithUserId:@"xdf" completion:^(NSException *error) {
    }];
}

// 基于 iOS 10 及以上的系统版本
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        [self printLog:userInfo];
    } else {
        //应用处于前台时的本地推送接受
        
    }
    completionHandler(UNNotificationPresentationOptionNone);
}

//// 基于 iOS 10 及以上的系统版本
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台或者活冷启动时远程推送接受
        [self printLog:userInfo];
    } else {
        //应用处于前台时的本地推送接受
        
    }
    completionHandler();
    
}

- (void)printLog:(NSDictionary *)userInfo
{
    NSLog(@"%@", userInfo);
}

@end
