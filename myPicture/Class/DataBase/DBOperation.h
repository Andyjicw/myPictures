//
//  DBOperation.h
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/5/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#ifndef DBOperation_h
#define DBOperation_h

#define CREATE_TABLE_PICTURE @"CREATE TABLE IF NOT EXISTS table_picture( \
id integer primary key autoincrement, \
pic_id TEXT(512), \
set_name TEXT(512), \
class_name TEXT(1024), \
group_name TEXT(1024), \
file_ext TEXT(1024), \
pic_count TEXT(1024))"

#define INSERT_TABLE_PICTURE @"INSERT INTO table_picture(pic_id, set_name, class_name, group_name, file_ext, pic_count) \
VALUES(?,?,?,?,?,?)"

#endif /* DBOperation_h */
