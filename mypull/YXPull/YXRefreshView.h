//
//  YXRefreshView.h
//  mypull
//
//  Created by 杨绍鑫 on 16/5/11.
//  Copyright © 2016年 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+YXPull.h"

typedef enum : NSUInteger {
    YXRefreshStoped,
    YXRefreshTragging,
    YXRefreshLoading,
} YXRefreshSate;

@interface YXRefreshView : UIView

@property (nonatomic,copy)void(^actionHeadle)();
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,assign) YXRefewshPosit posit;

- (void)startAnimating;
- (void)stopAnimating;
@end
