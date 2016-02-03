//
//  EZJViewController.m
//  ZJTools
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 zhangjing. All rights reserved.
//

#import "EZJViewController.h"
#import "ZJRouter.h"

@interface EZJViewController ()

@end

@implementation EZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(jumpTo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)jumpTo {
    
    [[ZJRouter sharedInstance] jump:@"app://social/hot_post_list?page=1&topicId=123456"];
}

@end
