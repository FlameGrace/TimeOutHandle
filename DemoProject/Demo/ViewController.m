//
//  ViewController.m
//  Demo
//
//  Created by Flame Grace on 2017/11/8.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "ViewController.h"
#import "TimeOutHandleCenter.h"

#define Duration (5)

@interface ViewController ()

@end

@implementation ViewController

static NSString *timeOutTest1 = @"timeOutTest1";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *click = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 44)];
    click.backgroundColor = [UIColor lightGrayColor];
    [click setTitle:@"点击button" forState:UIControlStateNormal];
    [click setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [click addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:click];
    
    [[TimeOutHandleCenter defaultCenter]registerHandleWithIdentifier:timeOutTest1 timeOut:5 timeOutCallback:^(TimeoutHandle *handle) {
        NSLog(@"超时5秒未点击button");
    } handlePeriod:1 handleTimeBlock:^(TimeoutHandle *handle, NSTimeInterval handleTime) {
        NSLog(@"已经等待了%.0f",handleTime);
    }];
}

- (void)click:(id)sender
{
    [[TimeOutHandleCenter defaultCenter]removeHandleByIdentifier:timeOutTest1];
}


@end
