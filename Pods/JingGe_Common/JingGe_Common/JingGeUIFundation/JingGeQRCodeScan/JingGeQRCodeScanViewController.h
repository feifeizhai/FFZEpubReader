//
//  JingGeQRCodeScanViewController.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/26.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeBaseViewController.h"

typedef void(^JingGeQRCodeScanResultBlock)(NSString *result);

@interface JingGeQRCodeScanViewController : JingGeBaseViewController

@property (copy, nonatomic) JingGeQRCodeScanResultBlock scanResult;

- (id) initWithJingGeQRCodeScanResultBlock:(JingGeQRCodeScanResultBlock) scanResult;

- (void)destroy;
- (void)startRun;
@end
