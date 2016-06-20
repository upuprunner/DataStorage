//
//  SqManager.m
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "SqManager.h"

@implementation SqManager

+ (SqManager *)sharedInstance{

    static SqManager *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        manager =[[SqManager alloc]init];
    });
    
    return manager;
}

#pragma mark-----拼接路径
- (NSString *)stringAppendingPath{

    NSString *document =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath =[document stringByAppendingString:@"/car.sqlite"];
    return filePath;
}

#pragma mark----创建表
- (void)createTable{

    NSString *path =[self stringAppendingPath];
    
    //数据库打开成功
    if (sqlite3_open([path UTF8String], &_db) == SQLITE_OK) {
        
        //sql语句
        NSString *createTableSql =@"CREATE TABLE IF NOT EXISTS CarTable(ID INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,price TEXT)";
        //错误信息
        char *error;
        //创建表
        if (sqlite3_exec(_db, [createTableSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
            
            NSLog(@"创建表成功");
            
        }else{

            NSLog(@"创建表失败");
            NSAssert(NO, @"创建表失败");
        }
        
        //创建成功、关闭数据库
        sqlite3_close(_db);
        
    }else{
    
        NSLog(@"创建表的时候、数据库打开失败");
        NSAssert(NO, @"创建表的时候、数据库打开失败");
    }
    
}

- (void)insertObject:(Car *)object{

    NSString *path =[self stringAppendingPath];
    //打开数据库
    if (sqlite3_open([path UTF8String], &_db) == SQLITE_OK) {
        
        //语句对象
        sqlite3_stmt *stmt;
        //sql语句
        NSString *insertSql =@"INSERT OR REPLACE INTO CarTable(name,price)VALUES(?,?)";
        //预处理函数
        if (sqlite3_prepare_v2(_db, [insertSql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            
            //绑定
            sqlite3_bind_text(stmt, 1, [object.name UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 2, [object.price UTF8String], -1, NULL);
            //执行插入函数
            if (sqlite3_step(stmt) == SQLITE_DONE) {
                
                NSLog(@"插入数据成功");
                
            }else{
            
                NSLog(@"插入数据失败");
                NSAssert(NO, @"插入数据失败");
            }
            
        }else{
        
            NSLog(@"插入语句错误");
            NSAssert(NO, @"插入语句错误");
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(_db);
        
    }else{
    
        NSLog(@"插入数据、打开数据库失败");
        NSAssert(NO, @"插入数据、打开数据库失败");
    }
}

#pragma mark-----取出所有的数据
- (NSMutableArray *)getAllObject{

    NSString *path =[self stringAppendingPath];
    NSMutableArray *mutArray =nil;
    
    //打开数据库
    if (sqlite3_open([path UTF8String], &_db) == SQLITE_OK) {
        
        //创建数组
        mutArray =[[NSMutableArray alloc]init];
        //语句对象
        sqlite3_stmt *stmt;
        //sql语句
        NSString *selectSql =@"SELECT *FROM CarTable";
        //预处理函数
        if (sqlite3_prepare_v2(_db, [selectSql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            
            //循环执行
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                Car *car =[[Car alloc]init];
                
                int Id =sqlite3_column_int(stmt, 0);
                char *name =(char *)sqlite3_column_text(stmt, 1);
                char *price =(char *)sqlite3_column_text(stmt, 2);
                
                car.ID =Id;
                car.name =[NSString stringWithUTF8String:name];
                car.price =[NSString stringWithUTF8String:price];
                
                //添加到数组
                [mutArray addObject:car];
            }
            
        }else{
        
            NSLog(@"取出数据、语句错误");
            NSAssert(NO, @"取出数据、语句错误");
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(_db);
        
    }else{
    
        NSLog(@"取出所有的数据、打开数据库失败");
        NSAssert(NO, @"取出所有的数据、打开数据库失败");
    }
    return mutArray;
}

- (void)updateObject:(Car *)object{

    NSString *path =[self stringAppendingPath];
    //打开数据库
    if (sqlite3_open([path UTF8String], &_db) == SQLITE_OK) {
        
        //语句对象
        sqlite3_stmt *stmt;
        //sql语句
        NSString *updateSql =@"UPDATE CarTable SET name =?,price =? WHERE ID =?";
        //预处理函数
        if (sqlite3_prepare_v2(_db, [updateSql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            
            //绑定
            sqlite3_bind_text(stmt, 1, [object.name UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 2, [object.price UTF8String], -1, NULL);
            sqlite3_bind_int(stmt, 3, object.ID);
            
            //执行函数
            if (sqlite3_step(stmt) == SQLITE_DONE) {
                
                NSLog(@"修改数据成功");
            }else{
            
                NSLog(@"修改数据失败");
                NSAssert(NO, @"修改数据失败");
            }
            
        }else{
        
            NSLog(@"修改语句错误");
            NSAssert(NO, @"修改语句错误");
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(_db);
        
    }else{
    
        NSLog(@"修改数据、打开数据库失败");
        NSAssert(NO, @"修改数据、打开数据库失败");
    }
}

- (void)deleteObject:(Car *)object{

    NSString *path =[self stringAppendingPath];
    //打开数据库
    if (sqlite3_open([path UTF8String], &_db) == SQLITE_OK) {
        
        //语句对象
        sqlite3_stmt *stmt;
        //sql语句
        NSString *deleteSql =@"DELETE FROM CarTable WHERE ID =? AND name =? AND price =?";
        //预处理函数
        if (sqlite3_prepare_v2(_db, [deleteSql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            
            //绑定
            sqlite3_bind_int(stmt, 1, object.ID);
            sqlite3_bind_text(stmt, 2, [object.name UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 3, [object.price UTF8String], -1, NULL);
            //执行函数
            
            if (sqlite3_step(stmt) == SQLITE_DONE) {
                
                NSLog(@"删除数据成功");
                
            }else{
            
                NSLog(@"删除数据失败");
                NSAssert(NO, @"删除数据失败");
            }
            
        }else{
        
            NSLog(@"删除数据语句错误");
            NSAssert(NO, @"删除数据语句错误");
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(_db);
        
    }else{
    
        NSLog(@"删除数据、打开数据库失败");
        NSAssert(NO, @"删除数据、打开数据库失败");
    }
}

@end
