//
//  UIScrollView+YXPull.h
//  mypull
//
//  Created by 杨绍鑫 on 16/5/11.
//  Copyright © 2016年 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXRefreshView;
@interface UIScrollView (YXPull)
@property (nonatomic ,weak) YXRefreshView *refreshView;
- (void)addPull:(void(^)())actionHeadel;
- (void)startAnimating;
- (void)stopAnimating;
@end
