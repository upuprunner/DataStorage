//
//  Student.m
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithCoder:(NSCoder *)aDecoder{

    self =[super init];
    if (self) {
        
        self.name =[aDecoder decodeObjectForKey:@"name"];
        self.age =[aDecoder decodeObjectForKey:@"age"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.age forKey:@"age"];
}

@end
