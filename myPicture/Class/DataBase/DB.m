//
//  DB.m
//  myPicture
//
//  Created by andy on 16/5/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "DB.h"

@implementation DB


-(NSMutableArray *) DBGetTablePicture {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    DBManager *manager         = [DBManager shareInstance];
    NSString *sql              = @"SELECT * FROM table_picture";
    FMResultSet *result        = [manager.db executeQuery:sql];
    while ([result next])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[result stringForColumn:@"pic_id"] forKey:@"pic_id"];
        [dic setObject:[result stringForColumn:@"set_name"] forKey:@"set_name"];
        [dic setObject:[result stringForColumn:@"class_name"] forKey:@"class"];
        [dic setObject:[result stringForColumn:@"group_name"] forKey:@"group"];
        [dic setObject:[result stringForColumn:@"file_ext"] forKey:@"file_ext"];
        [dic setObject:[result stringForColumn:@"pic_count"] forKey:@"pic_count"];
        [arr addObject:dic];
    }
    return arr;
}

-(BOOL) DBSetTablePicture:(NSArray *)arr isDel:(BOOL)isDel {
    
    DBManager *manager = [DBManager shareInstance];
    if (isDel) {
        NSString *del = @"DELETE FROM table_picture;";
        if (![manager.db executeUpdate:del]) {
            NSLog(@"删除失败");
        }
    }
    
    for (NSMutableDictionary *tmp in arr) {
        
        NSString *sql = INSERT_TABLE_PICTURE;
        
        if ([manager.db executeUpdate:sql,
             [tmp objectForKey:@"pic_id"],
             [tmp objectForKey:@"set_name"],
             [tmp objectForKey:@"class"],
             [tmp objectForKey:@"group"],
             [tmp objectForKey:@"file_ext"],
             [tmp objectForKey:@"pic_count"]]) {
            
        } else {
            NSLog(@"save table_picture faild");
            return false;
        }
    }
    return true;
}

@end
