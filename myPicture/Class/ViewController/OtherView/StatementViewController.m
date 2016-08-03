//
//  StatementViewController.m
//  myPicture
//
//  Created by andy on 16/5/12.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "StatementViewController.h"

@interface StatementViewController ()

- (IBAction)closeClick:(id)sender;

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
