//
//  POST.h
//  myPicture
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POST : NSObject

typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(NSError *error);
/**
 *  @author andy, 16-04-12 16:04:09
 *
 *  @brief POST请求
 *
 *  @param withUrl 请求地址
 *  @param body    请求体
 *  @param head    请求头
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void) withUrl:(NSString *)url
            body:(NSMutableDictionary *)body
            head:(NSMutableDictionary *)head
         success:(SuccessBlock)success
         failure:(FailureBlock)failure;

@end
