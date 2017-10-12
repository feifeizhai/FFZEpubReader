//
//  JingGeThirdConfig.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingGeThirdConfig : NSObject

+ (void)UMMobileClickConfigWithAppKey:(NSString *)appkey channelId:(NSString *)channelId;//配置友盟

+ (void)MiPushConfig;//配置小米推送

+ (void)bindDeviceToken:(NSData *)deviceToken;//绑定devicetoken

+ (void)handleReceiveRemoteNotification:(NSDictionary *)userInfo;


@end
