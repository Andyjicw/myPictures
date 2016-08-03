//
//  POST.m
//  myPicture
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "POST.h"

@implementation POST

+ (void) withUrl:(NSString *)url
            body:(NSMutableDictionary *)body
            head:(NSMutableDictionary *)head
         success:(SuccessBlock)success
         failure:(FailureBlock)failure {
    
    NSURL *updateUrl         = [NSURL URLWithString:url];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:updateUrl];
    req.timeoutInterval      = 60;

    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (head) {
        for (NSString *key in head) {
            [req setValue:head[key] forHTTPHeaderField:key];
        }
    }
    
    NSError *parseError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [req setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    [req setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error);
            }
            return;
        }
        if (success) {
            
            NSString * newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", newStr);
            NSError *jsonError;
            NSData *objectData = [newStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            success(json);
        }
    }];
    
    [task resume];
}

@end
