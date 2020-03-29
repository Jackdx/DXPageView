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
  
#if 1
    // 加载网络图片
    pageView.imageNamesArray = @[@"https://pics0.baidu.com/feed/342ac65c10385343dbd986383226dd78ca808854.jpeg?token=c40ea73e1c3757f8765a305706e57387",
                                @"https://pics5.baidu.com/feed/9922720e0cf3d7ca573fdfa826f0d20f6963a91d.jpeg?token=b66fc56ffa80d32e198afd1ce5f31e48",
                                @"https://pics6.baidu.com/feed/d833c895d143ad4bc0211e0a80ed36a9a60f06e5.jpeg?token=49010ae2feeeed0a40fd51f40274234e"];
    
#else
    // 加载本地
    pageView.imageNamesArray = @[@"img_car_2",@"img_car_3",@"img_car_4"];
#endif
    [self.view addSubview:pageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"DXPageViewController touchesBegan");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
