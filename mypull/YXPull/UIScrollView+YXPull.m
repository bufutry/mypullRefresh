//
//  UIScrollView+YXPull.m
//  mypull
//
//  Created by 杨绍鑫 on 16/5/11.
//  Copyright © 2016年 Y. All rights reserved.
//

#import "UIScrollView+YXPull.h"
#import "YXRefreshView.h"
#import <objc/runtime.h>

static char UIYXRefreshView;
static char UIFootRefreshView;

@implementation UIScrollView (YXPull)

@dynamic refreshView,footRefreshView,isShowPullView;

- (void)startAnimating
{
    [self.refreshView startAnimating];
}
- (void)stopAnimating
{
    [self.refreshView stopAnimating];
}
- (void)footStartAnimating
{
   [self.footRefreshView startAnimating];
}
- (void)footStopAnimating
{
   [self.footRefreshView stopAnimating];
}
- (void)addPull:(void(^)())actionHeadel
{
    [self addPull:actionHeadel posit:YXRefewshPositTop];
}

- (void)addPull:(void (^)())actionHeadel posit:(YXRefewshPosit)posit
{
 
    CGFloat orginY = 0;
    if (posit==YXRefewshPositTop) {
        orginY = -40;
    }
    else
    {
        orginY = self.frame.size.height+40;
    }
    
    YXRefreshView *refreshView = [[YXRefreshView alloc] initWithFrame:CGRectMake(0, orginY, self.frame.size.width, 40)];
    [self addSubview:refreshView];
    refreshView.scrollView = self;
    switch (posit) {
        case YXRefewshPositTop:
            self.refreshView = refreshView;
            break;
        default:
            self.footRefreshView = refreshView;
            break;
    }
    refreshView.actionHeadle = actionHeadel;
    refreshView.posit = posit;

    [self addObserver:refreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:refreshView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)setRefreshView:(YXRefreshView *)refreshView
{
    objc_setAssociatedObject(self, &UIYXRefreshView, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YXRefreshView*)refreshView
{
    return objc_getAssociatedObject(self, &UIYXRefreshView);
}

- (void)setFootRefreshView:(YXRefreshView *)footRefreshView
{
    objc_setAssociatedObject(self, &UIFootRefreshView, footRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YXRefreshView*)footRefreshView
{
    return objc_getAssociatedObject(self, &UIFootRefreshView);
}

@end
