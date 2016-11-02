//
//  ObjectDao.m
//  LoveStudy
//
//  Created by xpg on 14/10/30.
//  Copyright (c) 2014年 xpg. All rights reserved.
//

#import "ObjectDao.h"

#import <sqlite3.h>


#import "UniteTools.h"

//主要是考虑到所有的sqlite操作都进行一次数据库链接才进行的处理。
static sqlite3* gSqlite = NULL;
static NSLock* gSqliteLock = nil;


@implementation ObjectDao

+ (void)initialize
{
    [ObjectDao openSqlite];
}

+ (void)openSqlite
{
    //创建并建立一个sqlite数据库链接。
    //任务：1.打开数据库句柄。2.检查数据库表是否存在。3.不存在的话创建之。
    NSString* path = getDataRoot_UT();
    NSString *strfile = [path stringByAppendingPathComponent:DB_NAME];

    //create database folder.
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error = nil;
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error != nil) {
            NSLog(@"create path error. %@", error.domain);
        }
    }

    NSLog(@"%@", strfile);
    //open database.
    if (sqlite3_open([strfile UTF8String], &gSqlite) != SQLITE_OK) {
        NSLog(@"open sqlite database error. %s", sqlite3_errmsg(gSqlite));
        sqlite3_close(gSqlite);
        gSqlite = NULL;
    }
    
    gSqliteLock = [[NSLock alloc] init];
    
}



+ (void) closeDB
{
    [gSqliteLock lock];
    if (gSqlite) {
        sqlite3_close(gSqlite);
        gSqlite = NULL;
    }
    [gSqliteLock unlock];
}

+ (BOOL) execSql:(NSString *)sql;
{
    [gSqliteLock lock];
    BOOL tRet = TRUE;
    char *err;
    if (sqlite3_exec(gSqlite, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        NSLog(@"execSql err. %s", err);
        tRet = FALSE;
    }
    [gSqliteLock unlock];
    return tRet;
}


- (sqlite3*) getSqlite
{
    return gSqlite;
}

- (NSLock*) getSqliteLock
{
    return gSqliteLock;
}



@end
