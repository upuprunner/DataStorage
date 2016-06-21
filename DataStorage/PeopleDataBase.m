//
//  PeopleDataBase.m
//  DataStorage
//
//  Created by jianglei on 16/6/21.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "PeopleDataBase.h"

@implementation PeopleDataBase

+ (FMDatabase *)sharedInstance{

    static FMDatabase *db =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        NSString *document =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path =[document stringByAppendingString:@"/people.sqlite"];
        
        db =[FMDatabase databaseWithPath:path];
        
    });
    
    return db;
}

@end
