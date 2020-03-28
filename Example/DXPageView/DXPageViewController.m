//
//  DXPageViewController.m
//  DXPageView_Example
//
//  Created by 邓翔 on 2020/3/28.
//  Copyright © 2020年 871077947@qq.com. All rights reserved.
//

#import "DXPageViewController.h"
#import "DXPageView.h"

@interface DXPageViewController ()

@end

@implementation DXPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    DXPageView *pageView = [DXPageView pageView];
    pageView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 200);
    pageView.httpImageNames = @[@"https://pics0.baidu.com/feed/342ac65c10385343dbd986383226dd78ca808854.jpeg?token=c40ea73e1c3757f8765a305706e57387",@"https://pics5.baidu.com/feed/9922720e0cf3d7ca573fdfa826f0d20f6963a91d.jpeg?token=b66fc56ffa80d32e198afd1ce5f31e48"];
    [self.view addSubview:pageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"DXPageViewController touchesBegan");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
