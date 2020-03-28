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
/** 图片名字 */
@property (nonatomic, strong) NSArray *httpImageNames;

/** 其他圆点颜色 */
@property (nonatomic, strong) UIColor *otherColor;
/** 当前圆点颜色 */
@property (nonatomic, strong) UIColor *currentColor;

- (void)stopTimer;
@end
