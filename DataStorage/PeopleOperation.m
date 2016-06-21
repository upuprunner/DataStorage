//
//  PeopleOperation.m
//  DataStorage
//
//  Created by jianglei on 16/6/21.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "PeopleOperation.h"

@implementation PeopleOperation

#pragma mark----创建表
+ (void)createTable{

    FMDatabase *db =[PeopleDataBase sharedInstance];
    //打开数据库
    if ([db open]) {
        
        //判断是否存在表
        if (![db tableExists:@"PeopleTable"]) {
            
            //没有就创建
            [db executeUpdate:@"create table PeopleTable(id integer primary key autoincrement,name text,age text)"];
        }
        
        //关闭数据库
        [db close];
    }
    
}

#pragma mark-----插入数据
+ (void)insertObject:(People *)object{

    FMDatabase *db =[PeopleDataBase sharedInstance];
    if ([db open]) {
        
        //执行插入语句
        [db executeUpdate:@"insert into PeopleTable(name,age)values(?,?)",object.name,object.age];
        //关闭数据库
        [db close];
    }
}

#pragma mark----取出所有的数据
+ (NSMutableArray *)getAllObject{

    NSMutableArray *mutArray =nil;
    FMDatabase *db =[PeopleDataBase sharedInstance];
    //打开数据库
    if ([db open]) {
    
        mutArray =[NSMutableArray array];
        //查询结果
        FMResultSet *set =[db executeQuery:@"select *from PeopleTable"];
        while ([set next]) {
            
            People *people =[[People alloc]init];
            
            people.ID =[set intForColumn:@"id"];
            people.name =[set stringForColumn:@"name"];
            people.age =[set stringForColumn:@"age"];
            
            [mutArray addObject:people];
        }
        //结束循环
        [set close];
        //关闭数据库
        [db close];
    }
    
    return mutArray;
}

#pragma mark---更新数据
+ (void)updateObject:(People *)object withId:(NSInteger)ID{

    FMDatabase *db =[PeopleDataBase sharedInstance];
    if ([db open]) {
        
        [db executeUpdate:@"update PeopleTable set name =?,age =? where id =?",object.name,object.age,[NSNumber numberWithInteger:ID]];
        
        [db close];
    }
}

#pragma mark---删除数据
+ (void)deleteObjectById:(NSInteger)ID{

    FMDatabase *db =[PeopleDataBase sharedInstance];
    if ([db open]) {
        
        [db executeUpdate:@"delete from PeopleTable where id =?",[NSNumber numberWithInteger:ID]];
        
        [db close];
    }
}

@end
