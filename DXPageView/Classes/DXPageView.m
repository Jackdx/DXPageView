//
//  DXPageView.m
//  分页
//
//  Created by dengxiang on 15/5/28.
//  Copyright (c) 2015年 dx. All rights reserved.
//



#import "DXPageView.h"
#import "UIImageView+WebCache.h"


#define DXScrollW self.scrollView.frame.size.width
#define DXScrollH self.scrollView.frame.size.height

@interface DXPageView() <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation DXPageView

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        
        // 添加子控件代码
    }
    return self;
}

/**
 * 当控件从xib\storyboard中创建完毕时，就会调用这个方法
 * 当控件从xib\storyboard中创建完毕后的初始化操作。应该在这个方法中执行
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

/**
 * 初始化代码
 */
- (void)setup
{
    // 开启定时器
    [self startTimer];
}

+ (instancetype)pageView
{
    return [[[self dx_pageViewBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 * 当控件的尺寸发生改变的时候，会自动调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置scrollView的frame
    self.scrollView.frame = self.bounds;

    // 设置pageControl
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = DXScrollW - pageW;
    CGFloat pageY = DXScrollH - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    self.pageControl.center = CGPointMake(DXScrollW / 2.0, pageY);
    
    // 设置内容大小
    self.scrollView.contentSize = CGSizeMake((self.httpImageNames.count + 2) * DXScrollW, 0);
    self.scrollView.contentOffset = CGPointMake(DXScrollW, 0);
    
    // 设置所有imageView的frame
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * DXScrollW, 0, DXScrollW, DXScrollH);
    }
}

#pragma mark - setter方法的重写
- (void)setHttpImageNames:(NSArray *)httpImageNames
{
    _httpImageNames = httpImageNames;
    
    // 移除之前的所有imageView
    // 让subviews数组中的所有对象都执行removeFromSuperview方法
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger num = httpImageNames.count;
    if (num == 0) return;
    
    UIImageView *firstImageView = [[UIImageView alloc] init];
    [self checkImgUrl:httpImageNames[num-1] withImgV:firstImageView];
//    [firstImageView sd_setImageWithURL:[NSURL URLWithString:httpImageNames[num-1]] placeholderImage:[UIImage imageNamed:@"default"]];
    [self.scrollView addSubview:firstImageView];
    // 根据图片名创建对应个数的imageView
    
    for (int i = 0; i<num; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:httpImageNames[i]] placeholderImage:[UIImage imageNamed:@"default"]];
        [self checkImgUrl:httpImageNames[i] withImgV:imageView];
        [self.scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag = i;
    }
    UIImageView *lastImageView = [[UIImageView alloc] init];
//    [lastImageView sd_setImageWithURL:[NSURL URLWithString:httpImageNames[0]] placeholderImage:[UIImage imageNamed:@"default"]];
    [self checkImgUrl:httpImageNames[0] withImgV:lastImageView];
    [self.scrollView addSubview:lastImageView];
    
    // 设置总页数
    self.pageControl.numberOfPages = httpImageNames.count;

}
- (void)checkImgUrl:(NSString *)imgUrl withImgV:(UIImageView *)imageView
{
    if ([imgUrl hasPrefix:@"http"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    }
    else
    {
        imageView.image = [UIImage imageNamed:imgUrl];
    }
}
- (void)tap:(UITapGestureRecognizer *)t
{
    if ([_delegate respondsToSelector:@selector(pageView:didSelectPageAtIndex:)]) {
        [_delegate pageView:self didSelectPageAtIndex:t.view.tag];
    }
}
- (void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentColor;
}

- (void)setOtherColor:(UIColor *)otherColor
{
    _otherColor = otherColor;
    
    self.pageControl.pageIndicatorTintColor = otherColor;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5 - 1);
    int num = (scrollView.contentOffset.x / DXScrollW);
    if (num == self.httpImageNames.count + 1) {
        
        [self.scrollView setContentOffset:CGPointMake(DXScrollW, 0) animated:NO];
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
        [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
        [self startTimer];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self checkPage:scrollView];
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width - 1;
    
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self stopTimer];
    }
}
- (void)willRemoveSubview:(UIView *)subview
{
    [self stopTimer];
}
#pragma mark - 定时器控制
- (void)startTimer
{
    // 创建一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/**
 * 下一页
 */
- (void)nextPage
{
    NSInteger page = self.pageControl.currentPage + 2;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = page * DXScrollW;
    [self.scrollView setContentOffset:offset animated:YES];
//    NSLog(@"---下一页");
}
//- (void)dealloc
//{
//    NSLog(@" DXPageView  dealloc  ");
//}

- (void)checkPage:(UIScrollView *)scrollView
{
    int num = (scrollView.contentOffset.x / DXScrollW);
    if (num == self.httpImageNames.count + 1) {
        
        [self.scrollView setContentOffset:CGPointMake(DXScrollW, 0) animated:NO];
    }
    if(num == 0)
    {
        [self.scrollView setContentOffset:CGPointMake(DXScrollW * self.httpImageNames.count, 0) animated:NO];
    }

}

#pragma mark 私有方法
+ (NSBundle *)dx_pageViewBundle
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:NSStringFromClass(self) ofType:@"bundle"]];
    return bundle;
}
@end
