//
//  ObjectDao.h
//  LoveStudy
//
//  Created by xpg on 14/10/30.
//  Copyright (c) 2014年 xpg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

#define DB_NAME     @"cache.db"

typedef struct sqlite3 sqlite3;

@interface ObjectDao : NSObject

+ (void) closeDB;    //关闭数据库
+ (BOOL) execSql:(NSString *)sql;   //执行没有返回值的数据库指令。

@property (nonatomic, readonly, getter=getSqlite) sqlite3* mSqlite;
@property (nonatomic, readonly, getter=getSqliteLock) NSLock* mLock;

@end
