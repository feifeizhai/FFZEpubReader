//
//  JingGeSQLWork.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/20.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingGeSQLWork : NSObject
+ (JingGeSQLWork *_Nullable)shareJingGeSQL;

/**
 创建表
 @param modelClass modelClass
 */
- (void)creatTableWithModekClass:(Class _Nullable )modelClass;

/**
 插入数据
 @param model 数据模型
 */
- (void)insertDBWithModel:(NSObject *_Nullable)model;

/**
 更新数据
 @param model 数据模型
 @param where @{@"ID",@123}
 */
- (void)updateDBWithModel:(NSObject *_Nullable)model where:(id _Nullable )where;
- (id _Nullable ) searchDBWithModelClass:(Class _Nullable )modelClass where:(id _Nullable )where orderBy:(NSString*_Nullable)orderBy offset:(NSInteger)offset count:(NSInteger)count;
- (void)clearTableData:(Class _Nullable )modelClass;
- (void)deleteWithClass:(Class _Nullable )modelClass where:(nullable id)where;
- (void)dropAllTable;
@end
