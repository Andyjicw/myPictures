//
//  DBManager.m
//  myPicture
//
//  Created by andy on 16/5/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

//获取db的路径
- (NSString *)dbPath {
    NSArray *ary          = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDic = [ary objectAtIndex:0];
    NSString *dbPath      = [documentDic stringByAppendingString:@"/DataBase.db"];
    return dbPath;
}

+ (DBManager *)shareInstance {
    static DBManager *DBmanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBmanager = [[DBManager alloc] initWithDB];
    });
    return DBmanager;
}

- (id)initWithDB {
    
    if (self = [super init]) {
        _db = [FMDatabase databaseWithPath:[self dbPath]];
        if ([_db open]) {
            
            if ([_db executeUpdate:CREATE_TABLE_PICTURE]) {
                
            } else {
                NSLog(@"db create table picture faild");
            }
            
        } else {
            NSLog(@"db open faild");
        }
    }
    return self;
}

@end
