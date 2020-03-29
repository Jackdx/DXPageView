//
//  DXPageView.h
//  分页
//
//  Created by dengxiang on 15/6/06.
//  Copyright (c) 2015年 dx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXPageView;

@protocol DXPageViewDelegate <NSObject>

- (void)pageView:(DXPageView *)pageView didSelectPageAtIndex:(NSInteger)index;

@end

@interface DXPageView : UIView
+ (instancetype)pageView;

@property (nonatomic, weak)  id <DXPageViewDelegate> delegate;
/** 图片名字 格式为字符串，网络图片为url，本地图片为图片名称*/
@property (nonatomic, strong) NSArray *imageNamesArray;

/** 其他圆点颜色 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/** 当前圆点颜色 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/** 滚动的时间间隔 默认为2s，最小为1s  */
@property (nonatomic, assign) CGFloat time;

/** 是否隐藏pageControl 默认不隐藏 */
@property (nonatomic, assign) BOOL hidePageControl;

/** 是否隐藏在只有一页的时候隐藏pageControl 默认不隐藏 */
@property (nonatomic, assign) BOOL hidesForSinglePage;

/** 默认图片的名字  这个属性要在imageNamesArray之前设置才生效*/
@property (nonatomic, copy) NSString *defaultImageName;

@end
