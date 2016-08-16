//
//  ViewController.m
//  DQBDelayRespondDemo
//
//  Created by DQB on 8/16/16.
//  Copyright © 2016 DQB. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+DQBExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Click me quilkly" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 160, 44);
    button.backgroundColor = [UIColor redColor];
    // 点击相隔时间小于1秒的不响应，可自定义
    button.dqb_acceptEventInterval = 1;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked
{
    NSLog(@"buttonClicked");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
