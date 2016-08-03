//
//  AndyNavC.m
//  myPicture
//
//  Created by andy on 16/5/12.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "AndyNavC.h"

@implementation AndyNavC

+ (void)initialize {
    
    //appearance方法返回一个导航栏的外观对象,修改了这个外观对象,相当于修改了整个项目中的外观
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setBarTintColor:MAIN_COLOR];
    [navigationBar setTintColor:[UIColor whiteColor]];// iOS7的情况下,设置NavigationBarItem文字的颜色
    // 3.设置导航栏文字的主题
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowOffset:CGSizeMake(0.5, 0.5)];
    [shadow setShadowBlurRadius:4.0];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18],
                                            NSShadowAttributeName : shadow}];
    
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_cell_bg_selected"] forBarMetrics:UIBarMetricsDefault];
    // 4.修改所有UIBarButtonItem的外观
//    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
//    if (IS_IOS7) {
//        [barButtonItem setTintColor:[UIColor whiteColor]];
//        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    } else {
//        // 修改item的背景图片
//        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        // 修改item上面的文字样式
//        NSDictionary *dict =@{NSForegroundColorAttributeName : [UIColor whiteColor],
//                              NSShadowAttributeName : shadow};
//        [barButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//        [barButtonItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
//    }
    //修改返回按钮样式
    //    [barButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    // 5.设置状态栏样式
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
//如果想要统一定制返回按钮样式的话，可以重写如下方法
//重写返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}

- (UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    //或[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
}
-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}
@end
