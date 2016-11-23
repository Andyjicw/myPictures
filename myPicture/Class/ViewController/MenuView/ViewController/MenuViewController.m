//
//  MenuViewController.m
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/5/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "MenuViewController.h"
#import "StatementViewController.h"


@interface MenuViewController ()

- (IBAction)btnClick:(id)sender;

@end

@implementation MenuViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
- (void)setUpUI {
    UIView *viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 64)];
    viewTitle.backgroundColor = MAIN_COLOR;
    [self.view addSubview:viewTitle];
}

- (IBAction)btnClick:(id)sender {
    UIView *tmp = (UIView *)sender;
    switch (tmp.tag) {
        case 10001:
        {
            StatementViewController *vc = [[StatementViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 10002:
        {
            // 清除缓存
        }
            break;
        case 10003:
        {
            NSLog(@"10003");
        }
            break;
            
        default:
            break;
    }
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {}];
}

@end
