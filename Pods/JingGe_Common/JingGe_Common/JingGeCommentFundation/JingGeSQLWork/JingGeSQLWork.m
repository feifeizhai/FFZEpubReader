//
//  JingGeSQLWork.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/20.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeSQLWork.h"
#import "JingGeMacro.h"
#import "LKDBHelper.h"

@interface JingGeSQLWork ()


@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) LKDBHelper *dbHelper;

@end

static JingGeSQLWork *_jinggeSQL;

@implementation JingGeSQLWork

+ (JingGeSQLWork *)shareJingGeSQL
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _jinggeSQL = [[JingGeSQLWork alloc]init];
    });
    return _jinggeSQL;
}

- (LKDBHelper *)dbHelper
{
    if (!_dbHelper)
    {
        _dbHelper = [LKDBHelper getUsingLKDBHelper];
        
    }
    
    return _dbHelper;
}

- (NSString *)filePath
{
    if (!_filePath)
    {
        // document目录下
        //NSArray *documentArray =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        // NSString *document = [documentArray objectAtIndex:0];
        //_filePath = [document stringByAppendingPathComponent:SQLiteFile];
    }
    return _filePath;
}


- (void)creatTableWithModekClass:(Class)modelClass
{
    
    
}

- (void)insertDBWithModel:(NSObject *)model;
{
    [_jinggeSQL.dbHelper insertWhenNotExists:model callback:^(BOOL result) {
        if (result)
        {
            Log(@"插入成功");
        }
        else
        {
            Log(@"插入失败");
        }
    }];
}

- (void)updateDBWithModel:(NSObject *)model where:(id)where;
{
    [_jinggeSQL.dbHelper updateToDB:model where:where callback:^(BOOL result) {
        if (result)
        {
            Log(@"更新成功");
        }
        else
        {
            Log(@"更新失败");
        }
        
    }];
}

- (id) searchDBWithModelClass:(Class)modelClass where:(id)where orderBy:(NSString*)orderBy offset:(NSInteger)offset count:(NSInteger)count
{
    return [_jinggeSQL.dbHelper search:modelClass where:where orderBy:orderBy offset:offset count:count];
    //[_jinggeSQL.dbHelper searchSingle:modelClass where:nil orderBy:nil];
}


- (void) clearTableData:(Class)modelClass
{
    [LKDBHelper clearTableData:modelClass];
}

- (void)deleteWithClass:(Class)modelClass where:(nullable id)where {
    
    [_jinggeSQL.dbHelper deleteWithClass:modelClass where:where];
}

- (void)dropAllTable
{
    [_jinggeSQL.dbHelper dropAllTable];
}



@end
