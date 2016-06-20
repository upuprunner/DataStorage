//
//  Student.h
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCoding>

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *age;

@end
