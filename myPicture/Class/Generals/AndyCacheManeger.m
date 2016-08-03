//
//  AndyCacheManeger.m
//  myPicture
//
//  Created by andy on 16/5/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "AndyCacheManeger.h"

@implementation AndyCacheManeger

/*获取缓存数据的大小*/
+ (NSString *) fetchCacheSizeString{
    //设置一个变量来存放最终大小的总和
    long long sumSize = 0.0;
    // 1.获取缓存路径
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/andy.myPictures"];
    // 2.创建文件管理对象，计算文件大小
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 3.让这个文件管理对象通过缓存路径获取该路径下的所有子路径(数组)
    NSArray *subFilePaths = [fileManager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
    // 4.遍历子路径拼接
    for (NSString *subPath in subFilePaths) {
        // 01.拼接成完整路径
        NSString *subFilepath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];//这是文件路径，所以要拼接上“／”
        // 02.文件管理对象通过这个完整路径去找到缓存，再计算大小
        long long subSize = [[fileManager attributesOfItemAtPath:subFilepath error:nil] fileSize];//前面的方法返回值类型为字典，再直接转换成大小
        // 03.总和
        sumSize += subSize;
    }
    // 5.将字节单位转换成兆(ios中1000字节为一兆)
    float size_M = sumSize / (1000.0 * 1000.0);
    
    return [NSString stringWithFormat:@"%.2fM",size_M];
}

/*清理缓存数据*/
+ (BOOL) deleteCachesData{
    // 01.创建文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 02.获取缓存路径
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/andy.myPictures"];
    // 03.让这个文件管理对象通过这个路径去删除缓存
    NSError *err = nil;
    if ([fileManager removeItemAtPath:cacheFilePath error:&err]) {
        return true;
    } else {
        NSLog(@"%@", err);
        return false;
    }
}
@end
