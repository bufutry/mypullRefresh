//
//  UIScrollView+YXPull.h
//  mypull
//
//  Created by 杨绍鑫 on 16/5/11.
//  Copyright © 2016年 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXRefreshView;

typedef enum : NSUInteger {
    YXRefewshPositTop,
    YXRefewshPositBottom,
} YXRefewshPosit;

@interface UIScrollView (YXPull)

@property (nonatomic ,weak,readonly) YXRefreshView *refreshView;
@property (nonatomic ,weak,readonly) YXRefreshView *footRefreshView;
@property (nonatomic ,assign) BOOL isShowPullView;

- (void)addPull:(void(^)())actionHeadel;
- (void)addPull:(void (^)())actionHeadel posit:(YXRefewshPosit)posit;

- (void)startAnimating;
- (void)stopAnimating;
- (void)footStartAnimating;
- (void)footStopAnimating;
@end
