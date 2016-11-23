//
//  AndyNavC.m
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/5/12.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "AndyNavC.h"

@implementation AndyNavC

+ (void)initialize {
    
    // appearance方法返回一个导航栏的外观对象,修改了这个外观对象,相当于修改了整个项目中的外观
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:MAIN_COLOR];
    // iOS7的情况下,设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowOffset:CGSizeMake(0.5, 0.5)];
    [shadow setShadowBlurRadius:4.0];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18],
                                            NSShadowAttributeName : shadow}];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}

- (UIBarButtonItem *)creatBackButton {
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
}

-(void)popSelf {
    [self popViewControllerAnimated:YES];
}

@end
