//
//  DBManager.h
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/5/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "DBOperation.h"

@interface DBManager : NSObject

@property (nonatomic, readwrite) FMDatabase *db;

+ (DBManager *)shareInstance;

@end
