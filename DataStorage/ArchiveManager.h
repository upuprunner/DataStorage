//
//  ArchiveManager.h
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Student.h"

@interface ArchiveManager : NSObject

/**
 *实例化单例
 */
+ (ArchiveManager *)sharedInstance;

/**
 *判断文件路径是否存在
 */
- (BOOL)isAlerdayHave;

/**
 *创建文件路径
 */
- (NSString *)crateFilePath;

/**
 *拼接路径
 */
- (NSString *)stringAppendingPath;

/**
 *插入数据、修改数据、删除数据
 */
- (void)operationDataWithArray:(NSMutableArray *)mutArray;

@end
