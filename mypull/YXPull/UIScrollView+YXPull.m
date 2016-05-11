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

@implementation UIScrollView (YXPull)

@dynamic refreshView;

- (void)startAnimating
{
    [self.refreshView startAnimating];
}
- (void)stopAnimating
{
    [self.refreshView stopAnimating];
}

- (void)addPull:(void(^)())actionHeadel
{
    YXRefreshView *refreshView = [[YXRefreshView alloc] initWithFrame:CGRectMake(0, -40, self.frame.size.width, 40)];
    [self addSubview:refreshView];
    refreshView.scrollView = self;
    self.refreshView = refreshView;
    refreshView.actionHeadle = actionHeadel;
    [self addObserver:refreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)setRefreshView:(YXRefreshView *)refreshView
{
    objc_setAssociatedObject(self, &UIYXRefreshView, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YXRefreshView*)refreshView
{
    return objc_getAssociatedObject(self, &UIYXRefreshView);
}
@end
