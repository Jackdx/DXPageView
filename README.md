# DXPageView

[![CI Status](https://img.shields.io/travis/871077947@qq.com/DXPageView.svg?style=flat)](https://travis-ci.org/871077947@qq.com/DXPageView)
[![Version](https://img.shields.io/cocoapods/v/DXPageView.svg?style=flat)](https://cocoapods.org/pods/DXPageView)
[![License](https://img.shields.io/cocoapods/l/DXPageView.svg?style=flat)](https://cocoapods.org/pods/DXPageView)
[![Platform](https://img.shields.io/cocoapods/p/DXPageView.svg?style=flat)](https://cocoapods.org/pods/DXPageView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DXPageView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DXPageView'
```
### How To Use
网络或本地图片
```
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
```

## Author

871077947@qq.com, 871077947@qq.com

## License

DXPageView is available under the MIT license. See the LICENSE file for more info.
