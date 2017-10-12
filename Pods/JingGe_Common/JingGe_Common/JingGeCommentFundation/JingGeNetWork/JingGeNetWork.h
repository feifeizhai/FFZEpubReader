//
//  JingGeNetWork.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const net_key_success;
extern NSString * const net_key_error;
extern NSString * const net_key_result;
extern NSString * const net_key_message;

extern NSString * const net_status_unknown;
extern NSString * const net_status_not_reachable;
extern NSString * const net_status_reachable_viaWWAN;
extern NSString * const net_status_reachable_viaWiFi;


typedef NS_ENUM(NSInteger, JingGeReachabilityStatus) {
    JingGeReachabilityStatusUnknown          = -1,
    JingGeReachabilityStatusNotReachable     = 0,
    JingGeReachabilityStatusReachableViaWWAN = 1,
    JingGeReachabilityStatusReachableViaWiFi = 2,
    JingGeReachabilityStatusNetError = (JingGeReachabilityStatusUnknown | JingGeReachabilityStatusNotReachable)
};

extern NSString * JingGeNetStatue;

typedef NS_ENUM(NSInteger, DATADEMAND_TYPE){
    
    DATADEMAND_TYPE_GET = 0,
    
    DATADEMAND_TYPE_POST,
    
};

typedef NS_ENUM(NSInteger, DATARETURN_TYPE){
    
    
    DATARETURN_TYPE_FAILE = 0,
    
    DATARETURN_TYPE_SUCCESS,
    
    DATARETURN_TYPE_BLANK
    
};

typedef NS_ENUM(NSInteger, RELOAD_TYPE){
    
    RELOAD_TYPE_RELOAD = 0,//刷新
    
    RELOAD_TYPE_UPDATE//加载更多
    
};

@interface JingGeNetWork : NSObject

//数据请求
+ (void)publicHttpType:(DATADEMAND_TYPE)dataDemandType  APIName:(NSString *)apiName AndIsShowHudDialog:(BOOL)isShow AndIsEncoded:(BOOL)isEncoded RequestParams:(id)paramsDic success:(void (^)(id responseObject))success failure:(void (^)(id errorObject))failure;

+ (BOOL)currentNetworkStatus;//检查网络状况

+ (void)updateBaseURL:(NSString *)baseURL;

+ (void)configNetWorkStatusBaseURL:(NSString *)baseURL ChangeBlock:(void (^)(JingGeReachabilityStatus status))block;

@end
