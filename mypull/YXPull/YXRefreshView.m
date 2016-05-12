//
//  YXRefreshView.m
//  mypull
//
//  Created by 杨绍鑫 on 16/5/11.
//  Copyright © 2016年 Y. All rights reserved.
//

#import "YXRefreshView.h"

@interface YXRefreshView()
@property (nonatomic ,strong) UILabel *titleble;
@property (nonatomic ,strong) NSMutableArray *titleStrinArray;
@property (nonatomic ,assign) YXRefreshSate state;
@end

@implementation YXRefreshView

- (void)dealloc
{
    [self removeObserver:_scrollView forKeyPath:@"contentOffset"];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleStrinArray = [NSMutableArray arrayWithObjects:@"加载更多数据",@"下拉",@"loading..", nil];
        return self;
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleble.text = _titleStrinArray[_state];
}

- (UILabel*)titleble
{
    if (!_titleble) {
        _titleble = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_titleble];
        _titleble.textColor = [UIColor redColor];
    }
    return _titleble;
}

- (void)setState:(YXRefreshSate)state
{
    if (_state == state) {
        return;
    }
    _state = state;
    switch (state) {
        case YXRefreshLoading:
            [self setScollViewLoading];
            if (_actionHeadle) {
                _actionHeadle();
            }
            break;
        case YXRefreshTragging:
        case YXRefreshStoped:
            [self resetScollViewInset];
            break;
        default:
            break;
    }
    [self layoutSubviews];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"()))%f",self.scrollView.contentSize.height);
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint points = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        [self scollViewDidScollInset:points];
    }
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize size = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGRect r = self.frame;
        switch (_posit) {
            case YXRefewshPositTop:
                
                break;
            case YXRefewshPositBottom:
                r.origin.y = size.height;
                self.frame = r;
                break;
            default:
                break;
        }
    }
}

- (void)setScollViewLoading
{
    UIEdgeInsets inst = self.scrollView.contentInset;
    switch (_posit) {
        case YXRefewshPositTop:
             inst.top = 60;
        
            break;
        case YXRefewshPositBottom:
            inst.bottom =60;
            break;
        default:
            break;
    }
    [self scollViewContentInset:inst];
}

- (void)resetScollViewInset
{
    UIEdgeInsets inst = self.scrollView.contentInset;
    inst.top = 0;
    switch (_posit) {
        case YXRefewshPositTop:
            inst.top = 0;
            break;
        case YXRefewshPositBottom:
            inst.bottom = 0;
            break;
        default:
            break;
    }
    [self scollViewContentInset:inst];
}

- (void)scollViewContentInset:(UIEdgeInsets)inset
{
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0.0
                                 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                                     self.scrollView.contentInset = inset;
                                       }
                              completion:^(BOOL finished) {
    
                              }];
}

- (void)scollViewDidScollInset:(CGPoint)point
{
    CGFloat oigiY = point.y;
    if(_state!=YXRefreshLoading)
     {
         if (_posit==YXRefewshPositTop) {
             if (oigiY < 0  && self.scrollView.isDragging==YES) {
                 self.state = YXRefreshTragging;
             }
             if (oigiY<-60 && self.scrollView.isDragging==YES) {
                 self.state = YXRefreshStoped;
             }
              if (oigiY<-60 && self.scrollView.isDragging==NO)
             {
                 self.state = YXRefreshLoading;
             }
         }
        else if(_posit==YXRefewshPositBottom)
        {
        
            NSLog(@"----*%f",oigiY);
            CGFloat palehod = MAX(self.scrollView.contentSize.height-self.scrollView.frame.size.height,0)+60;
            if (oigiY>palehod-60&&self.scrollView.isDragging==YES) {
                self.state = YXRefreshTragging;
            }
            if (oigiY>palehod&&self.scrollView.isDragging==YES) {
                self.state = YXRefreshStoped;
            }
            if (oigiY>palehod&&self.scrollView.isDragging==NO) {
                self.state = YXRefreshLoading;
            }
        }
     }
    else
    {
           [self setScollViewLoading];
    }
}

- (void)startAnimating
{
    self.state = YXRefreshLoading;
}
- (void)stopAnimating
{
    self.state = YXRefreshStoped;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
