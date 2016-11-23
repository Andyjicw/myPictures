//
//  AndyCacheManeger.h
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/5/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AndyCacheManeger : NSObject
/**
 * 获取缓存数据的大小
 */
+ (NSString *) fetchCacheSizeString;
/**
 * 清理缓存数据
 */
+ (BOOL) deleteCachesData;
@end
