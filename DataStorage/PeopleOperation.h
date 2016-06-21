//
//  PeopleOperation.h
//  DataStorage
//
//  Created by jianglei on 16/6/21.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeopleDataBase.h"
#import "People.h"

@interface PeopleOperation : NSObject

/**
 *创建表
 */
+ (void)createTable;

/**
 *插入数据
 */
+ (void)insertObject:(People *)object;

/**
 *取出所有的数据
 */
+ (NSMutableArray *)getAllObject;

/**
 *修改数据
 */
+ (void)updateObject:(People *)object withId:(NSInteger)ID;

/**
 *删除数据
 */
+ (void)deleteObjectById:(NSInteger)ID;

@end
