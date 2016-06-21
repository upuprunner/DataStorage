//
//  PeopleDataBase.h
//  DataStorage
//
//  Created by jianglei on 16/6/21.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface PeopleDataBase : NSObject

/**
 *实例化数据库单例
 */
+ (FMDatabase *)sharedInstance;

@end
