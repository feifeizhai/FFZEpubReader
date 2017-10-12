//
//  JingGeBaseModel.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeBaseModel.h"
#import "JingGeDataManager.h"
#import "JingGeSQLWork.h"
#import "LKDBHelper.h"
#import "JingGeMacro.h"
@implementation JingGeBaseModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if (kIsDictionary(dictionary)) {
            NSMutableDictionary *dic = [dictionary mutableCopy];
            for (NSString *key in dic.allKeys) {
                id value = [dic objectForKey:key];
                
                value = [JingGeDataManager stringWithReplaceStr:value];
                [dic setObject:value forKey:key];
                
            }
            @try {
                [self setValuesForKeysWithDictionary:dic];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            [[JingGeSQLWork shareJingGeSQL] creatTableWithModekClass:[self class]];
        }
        
    }
    return self;
}


- (void)insetToDB
{
    [[JingGeSQLWork shareJingGeSQL] insertDBWithModel:self];
}

- (void)clearTableData
{
    [[JingGeSQLWork shareJingGeSQL] clearTableData:[self class]];
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
