//
//  AppDelegate.h
//  myPicture
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@class MMDrawerController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate>
{
@private
    MMDrawerController *drawerController;
}
@property (strong, nonatomic) UIWindow *window;

@end

