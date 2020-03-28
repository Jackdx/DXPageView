//
//  DXViewController.m
//  DXPageView
//
//  Created by 871077947@qq.com on 03/28/2020.
//  Copyright (c) 2020 871077947@qq.com. All rights reserved.
//

#import "DXViewController.h"
#import "DXPageViewController.h"


@interface DXViewController ()

@end

@implementation DXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@" DXViewController touchesBegan");
    DXPageViewController *pageVc = [DXPageViewController new];
    [self presentViewController:pageVc animated:YES completion:nil];
}

@end
