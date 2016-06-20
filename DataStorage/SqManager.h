//
//  SqManager.h
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Car.h"

@interface SqManager : NSObject
{

    sqlite3 *_db;
}
/**
 *单例实例化
 */
+ (SqManager *)sharedInstance;

/**
 *创建表
 */
- (void)createTable;

/**
 *插入数据
 */
- (void)insertObject:(Car *)object;

/**
 *取出所有的数据
 */
- (NSMutableArray *)getAllObject;

/**
 *修改数据
 */
- (void)updateObject:(Car *)object;

/**
 *删除数据
 */
- (void)deleteObject:(Car *)object;

@end
