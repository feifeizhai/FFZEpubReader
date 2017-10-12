//
//  JingGeBaseModel.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingGeBaseModel : NSObject
@property (strong, nonatomic) NSString *ID;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)insetToDB;
- (void)clearTableData;

@end
