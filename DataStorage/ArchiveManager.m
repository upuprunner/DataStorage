//
//  ArchiveManager.m
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "ArchiveManager.h"

@implementation ArchiveManager

+ (ArchiveManager *)sharedInstance{

    static ArchiveManager *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        manager =[[ArchiveManager alloc]init];
    });
    
    return manager;
}

#pragma mark---是否已创建路径
- (BOOL)isAlerdayHave{

    NSString *filePath =[self stringAppendingPath];
    NSFileManager *fileManager =[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        
        return YES;
        
    }else{
    
        return NO;
    }
}

#pragma mark----创建文件路径
- (NSString *)crateFilePath{

    NSString *filePath =[self stringAppendingPath];
    NSFileManager *fileManager =[NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
}

#pragma mark----拼接路径
- (NSString *)stringAppendingPath{

    NSString *document =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath =[document stringByAppendingString:@"/student"];
    
    return filePath;
}

#pragma mark----插入、修改、删除数据
- (void)operationDataWithArray:(NSMutableArray *)mutArray{

    //归档
    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:mutArray];
    //文件路径
    NSString *path =[self crateFilePath];
    
    if ([data writeToFile:path atomically:YES]) {
        
        NSLog(@"插入数据成功");
    }else{
    
        NSLog(@"插入数据失败");
        NSAssert(NO, @"插入数据失败");
    }
    
}

@end
