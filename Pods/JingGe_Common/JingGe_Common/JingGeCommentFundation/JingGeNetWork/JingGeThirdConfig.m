//
//  JingGeThirdConfig.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeThirdConfig.h"
#import "UMMobClick/MobClick.h"
#import <MiPushSDK.h>
#import "JingGeDataManager.h"
#import "JingGeMacro.h"

static JingGeThirdConfig *thirdConfig;

@interface JingGeThirdConfig () <MiPushSDKDelegate,UNUserNotificationCenterDelegate>
{
    BOOL isPushStr;//yes后台进入    其他则为非后台进入
}
@end

@implementation JingGeThirdConfig

+ (JingGeThirdConfig *)shareThirdConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thirdConfig = [[JingGeThirdConfig alloc] init];
    });
    return thirdConfig;
}

+ (void)UMMobileClickConfigWithAppKey:(NSString *)appkey channelId:(NSString *)channelId
{
    UMConfigInstance.appKey = appkey;
    UMConfigInstance.channelId = channelId;
    UMConfigInstance.ePolicy = BATCH;
    [MobClick startWithConfigure:UMConfigInstance];
}

+ (void)MiPushConfig{
    
    //isPushStr = [[NSString alloc] init];
    [MiPushSDK registerMiPush:[JingGeThirdConfig shareThirdConfig] type:0 connect:YES];
    [[JingGeThirdConfig shareThirdConfig] delayInSecondsPush];
}

-(void)delayInSecondsPush
{
    isPushStr = YES;
    //设置时间为2
    double delayInSeconds = 2.0;
    //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //推迟两纳秒执行
    dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        isPushStr = NO;
    });
    
}

#pragma MiDelegate

- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data
{
    NSLog(@"command succ(%@): %@", [self getOperateType:selector], data);
    if ([selector isEqualToString:@"unsetAlias:"]) {
        SET_USERDEFAULT_BOOL(YES, kIsUnsetAlias);
        //[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kIsUnsetAlias];
    }
    else if ([selector isEqualToString:@"bindDeviceToken:"]&&[JingGeDataManager isBlankString:GET_USERDEFAULT_VALUE(kUserId)]) {
        [MiPushSDK setAlias:GET_USERDEFAULT_VALUE(kUserId)];
    }
}
- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    NSLog(@"command error(%d|%@): %@", error, [self getOperateType:selector], data);
    if ([selector isEqualToString:@"unsetAlias:"]) {
        //[[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:kIsUnsetAlias];
        SET_USERDEFAULT_BOOL(NO, kIsUnsetAlias);
        if (GET_USERDEFAULT_BOOL(kIsLogin)&&[JingGeDataManager isBlankString:GET_USERDEFAULT_VALUE(kUserId)]) {
            [MiPushSDK setAlias:GET_USERDEFAULT_VALUE(kUserId)];
        }
    }
}

- (void)miPushReceiveNotification:(NSDictionary*)data{
    NSLog(@"XMPP notify: %@", data);
    if (isPushStr) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"JpushHomeNotification" object:data userInfo:data];
        POST_NOTIFY(@"JpushHomeNotification", data, data);
        Log(@"jpush=====");
    }
}

+ (void)bindDeviceToken:(NSData *)deviceToken
{
    [MiPushSDK bindDeviceToken:deviceToken];
}

+ (void)handleReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [MiPushSDK handleReceiveRemoteNotification:userInfo];
}

// iOS10新加入的回调方法
// 应用在前台收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"应用在前台收到通知");
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //        [vMain printLog:[NSString stringWithFormat:@"APNS notify: %@", userInfo]];
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
    //    completionHandler(UNNotificationPresentationOptionAlert);
}

// 点击通知进入应用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"点击通知进入应用");
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //        [vMain printLog:[NSString stringWithFormat:@"APNS notify: %@", userInfo]];
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
    completionHandler();
}


- (NSString*)getOperateType:(NSString*)selector
{
    NSString *ret = nil;
    if ([selector hasPrefix:@"registerMiPush:"] ) {
        ret = @"客户端注册设备";
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        ret = @"客户端设备注销";
    }else if ([selector isEqualToString:@"registerApp"]) {
        ret = @"注册App";
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        ret = @"绑定 PushDeviceToken";
    }else if ([selector isEqualToString:@"setAlias:"]) {
        ret = @"客户端设置别名";
    }else if ([selector isEqualToString:@"unsetAlias:"]) {
        ret = @"客户端取消别名";
    }else if ([selector isEqualToString:@"subscribe:"]) {
        ret = @"客户端设置主题";
    }else if ([selector isEqualToString:@"unsubscribe:"]) {
        ret = @"客户端取消主题";
    }else if ([selector isEqualToString:@"setAccount:"]) {
        ret = @"客户端设置账号";
    }else if ([selector isEqualToString:@"unsetAccount:"]) {
        ret = @"客户端取消账号";
    }else if ([selector isEqualToString:@"openAppNotify:"]) {
        ret = @"统计客户端";
    }else if ([selector isEqualToString:@"getAllAliasAsync"]) {
        ret = @"获取Alias设置信息";
    }else if ([selector isEqualToString:@"getAllTopicAsync"]) {
        ret = @"获取Topic设置信息";
    }
    
    return ret;
}

@end
