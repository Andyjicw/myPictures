//
//  AndyCacheManeger.m
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/5/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "AndyCacheManeger.h"

@implementation AndyCacheManeger

#pragma mark - 获取缓存数据的大小
+ (NSString *)fetchCacheSizeString{
    
    long long sumSize = 0.0;
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/andy.myPictures"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *subFilePaths = [fileManager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
    for (NSString *subPath in subFilePaths) {
        NSString *subFilepath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
        long long subSize = [[fileManager attributesOfItemAtPath:subFilepath error:nil] fileSize];
        sumSize += subSize;
    }
    float size_M = sumSize / (1000.0 * 1000.0);
    return [NSString stringWithFormat:@"%.2fM",size_M];
}

#pragma mark - 清理缓存数据
+ (BOOL) deleteCachesData{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/andy.myPictures"];
    NSError *err = nil;
    if ([fileManager removeItemAtPath:cacheFilePath error:&err]) {
        return true;
    } else {
        NSLog(@"%@", err);
        return false;
    }
}

@end
