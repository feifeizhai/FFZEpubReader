//
//  JingGeNetWork.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeNetWork.h"
#import "JingGeMacro.h"
#import "JingGeDataManager.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import "MiPushSDK.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "JingGeNetRequest.h"
NSString * const net_key_success = @"success";
NSString * const net_key_error = @"error";
NSString * const net_key_result = @"result";
NSString * const net_key_message = @"message";

NSString * const net_status_unknown = @"net_status_unknown";
NSString * const net_status_not_reachable = @"net_status_not_reachable";
NSString * const net_status_reachable_viaWWAN = @"net_status_reachable_viaWWAN";
NSString * const net_status_reachable_viaWiFi = @"net_status_reachable_viaWiFi";

//#define NETERROR @"与服务器连接失败"
NSString * JingGeNetStatue;
@implementation JingGeNetWork

+ (void)baseURL:(NSString *)baseURL{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [JingGeNetRequest updateBaseUrl:baseURL];
    });
}

+ (void)updateBaseURL:(NSString *)baseURL{
    [JingGeNetRequest updateBaseUrl:baseURL];
}


+ (void)publicHttpType:(DATADEMAND_TYPE)dataDemandType  APIName:(NSString *)apiName AndIsShowHudDialog:(BOOL)isShow AndIsEncoded:(BOOL)isEncoded RequestParams:(id)paramsDic success:(void (^)(id responseObject))success failure:(void (^)(id errorObject))failure

{
    if (dataDemandType == DATADEMAND_TYPE_GET) {
        [JingGeNetWork GETHttpAPIName:apiName AndIsShowHudDialog:isShow IsEncoded:(BOOL)isEncoded RequestParams:(id)paramsDic success:^(id responseObject) {
            success(responseObject);
        } failure:^(id errorObject) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.textColor = [UIColor whiteColor];
            hud.bezelView.backgroundColor = [UIColor blackColor];
            hud.label.text = NETERROR;
            [hud showAnimated:YES];
            [hud hideAnimated:YES afterDelay:2];
            
            
            //[[JingGeHUD sharedProgressHUD] hudWasHidden];
            
            //[[JingGeHUD sharedProgressHUD] showHudDialog:NETERROR AndSleepTime:0];
            
            
            failure(errorObject);
        }];
    }else if (dataDemandType == DATADEMAND_TYPE_POST){
        [JingGeNetWork POSTHttpAPIName:apiName AndIsShowHudDialog:isShow RequestParams:paramsDic IsEncoded:(BOOL)isEncoded success:^(id responseObject) {
            success(responseObject);
        } failure:^(id errorObject) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.textColor = [UIColor whiteColor];
            hud.bezelView.backgroundColor = [UIColor blackColor];
            hud.label.text = NETERROR;
            [hud showAnimated:YES];
            [hud hideAnimated:YES afterDelay:2];
            
            
            //[[JingGeHUD sharedProgressHUD] hudWasHidden];
            
            //[[JingGeHUD sharedProgressHUD] showHudDialog:NETERROR AndSleepTime:0];
            
            
            failure(errorObject);
        }];
    }
    
}
//GET请求
+ (void)GETHttpAPIName:(NSString *)apiName AndIsShowHudDialog:(BOOL)isShow IsEncoded:(BOOL)isEncoded RequestParams:(id)paramsDic success:(void (^)(id responseObject))success failure:(void (^)(id errorObject))failure

{
    if (isShow) {
        //[[JingGeHUD sharedProgressHUD] progressHUDAddWindow];
    }
    
    
    [JingGeNetRequest getWithUrl:apiName refreshCache:YES params:paramsDic success:^(id response) {
        // [[JingGeHUD sharedProgressHUD] hudWasHidden];
        if (kIsDictionary(response)) {
            NSInteger successType = [[response objectForKey:net_key_success] integerValue];
            if (successType == DATARETURN_TYPE_SUCCESS) {
                success(response);
            }else if (successType == DATARETURN_TYPE_FAILE){
                //[[JingGeHUD sharedProgressHUD]showHudDialog:[[response objectForKey:net_key_error] objectForKey:net_key_message] AndSleepTime:0];
            }
        }else {
            failure(nil);
        }
        
        
    } fail:^(NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.textColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.label.text = NETERROR;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:2];
        failure(error);
    }];
}
//POST请求
+ (void)POSTHttpAPIName:(NSString *)apiName AndIsShowHudDialog:(BOOL)isShow RequestParams:(id)paramsDic IsEncoded:(BOOL)isEncoded success:(void (^)(id responseObject))success failure:(void (^)(id errorObject))failure

{
    if (isShow) {
        //[[JingGeHUD sharedProgressHUD] progressHUDAddWindow];
    }
    
    [JingGeNetRequest postWithUrl:apiName refreshCache:YES params:paramsDic success:^(id response) {
        // Log(@"%@", response);
        //[[JingGeHUD sharedProgressHUD] hudWasHidden];
        NSInteger successType = [[response objectForKey:net_key_success] integerValue];
        if (successType == DATARETURN_TYPE_SUCCESS) {
            success([response objectForKey:net_key_result]);
        }else if (successType == DATARETURN_TYPE_FAILE){
            // [[JingGeHUD sharedProgressHUD]showHudDialog:[[response objectForKey:net_key_error] objectForKey:net_key_message] AndSleepTime:0];
        }
        
        
    } fail:^(NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.textColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.label.text = NETERROR;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:2];
        
        // [[JingGeHUD sharedProgressHUD] hudWasHidden];
        // [[JingGeHUD sharedProgressHUD] showHudDialog:NETERROR AndSleepTime:0];
        failure(error);
        
    }];
    
}

+ (void)downloadWithURL:(NSString *)URL{
    
    [JingGeNetRequest downloadWithUrl:URL saveToPath:kPathCache progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
    } success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
    
}


+ (void)cancleWithURL:(NSString *)URL{
    [JingGeNetRequest cancelRequestWithURL:URL];
}



//配置数据请求
+ (void)configNetWorkStatusBaseURL:(NSString *)baseURL ChangeBlock:(void (^)(JingGeReachabilityStatus status))block {
    [JingGeNetWork baseURL:baseURL];
    [JingGeNetRequest enableInterfaceDebug:YES];
    // 配置请求和响应类型
    [JingGeNetRequest configRequestType:kJingGeRequestTypePlainText
                           responseType:kJingGeResponseTypeJSON
                    shouldAutoEncodeUrl:YES
                callbackOnCancelRequest:NO];
    [JingGeNetRequest obtainDataFromLocalWhenNetworkUnconnected:NO];
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                block(JingGeReachabilityStatusUnknown);
                JingGeNetStatue = [net_status_unknown copy];
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                block(JingGeReachabilityStatusNotReachable);
                JingGeNetStatue = [net_status_not_reachable copy];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                JingGeNetStatue = [net_status_reachable_viaWWAN copy];
                block(JingGeReachabilityStatusReachableViaWWAN);
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                block(JingGeReachabilityStatusReachableViaWiFi);
                JingGeNetStatue = [net_status_reachable_viaWiFi copy];
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
    
}

#pragma mark 网络检查
+ (BOOL) currentNetworkStatus
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    BOOL connected;
    const char *host = "www.baidu.com";
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    connected = SCNetworkReachabilityGetFlags(reachability, &flags);
    BOOL isConnected = YES;
    isConnected = connected && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if(!isConnected) {
        
        // sleep(1);
        return NO;
        //[self check];
    }else
        return isConnected;
    //[self sendRequest];
    return isConnected;
}



@end
