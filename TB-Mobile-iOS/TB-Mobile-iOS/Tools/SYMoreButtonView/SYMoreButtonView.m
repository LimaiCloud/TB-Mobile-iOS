//
//  SYMoreButtonView.m
//  DemoMoreButton
//
//  Created by dongmingming on 2018/5/11.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

#import "SYMoreButtonView.h"

static CGFloat const originXY = 15.0;
static CGFloat const heightline = 3.0;

static NSInteger const tagButton = 1000;

@interface SYMoreButtonView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleView;
@property (nonatomic, strong) UIView *titleLine;

@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, assign) CGFloat previousOffX;

@end

@implementation SYMoreButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
 
        _showline = NO;
        _showlineAnimation = NO;
        _colorline = [UIColor colorWithHue:59 / 255.0 saturation:133 / 255.0 brightness:207 / 255.0 alpha:1.0];
        
        _indexSelected = 0;
        _colorNormal = [UIColor blackColor];
        _colorSelected = [UIColor colorWithHue:55 / 255.0 saturation:131 / 255.0 brightness:210 / 255.0 alpha:1.0];
        
        [self setUI];
    }
    return self;
}

#pragma mark - view

- (void)setUI
{
    // titleView
    self.titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.titleView];
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.titleView.showsHorizontalScrollIndicator = NO;
    self.titleView.showsVerticalScrollIndicator = NO;
    self.titleView.delegate = self;
    
    // titleLine
    self.titleLine = [[UIView alloc] initWithFrame:CGRectMake(originXY + 5, (self.titleView.frame.size.height - heightline), 0.0, heightline)];
    [self.titleView addSubview: self.titleLine];
    self.titleLine.backgroundColor = _colorline;
}

#pragma mark - response

- (void)cationClick:(UIButton *)button
{
    
    // View effect processing
    [self resetTileLine:button];
    [self resetTitleView:button];
    
    // status
    if (self.previousButton != nil)
    {
        self.previousButton.selected = NO;
        self.previousButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }else {
        [self.titleView bringSubviewToFront:button];

    }
    button.selected = !button.selected;
    self.previousButton = button;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    // response
    if (self.buttonClick)
    {
        NSInteger index = button.tag - tagButton;
        self.buttonClick(index);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sy_buttonClick:)])
    {
        NSInteger index = button.tag - tagButton;
        [self.delegate sy_buttonClick:index];
    }
}

#pragma mark - UISCrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.previousOffX = scrollView.contentOffset.x;
}

#pragma mark - setter

- (void)setTitles:(NSArray<NSString *> *)titles
{
    _titles = titles;
    
    __block CGFloat sizeWidth = originXY;
    [_titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // string length
        CGFloat titleWidth = [obj boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil].size.width;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(sizeWidth, 0.0, titleWidth, self.titleView.frame.size.height - _titleLine.frame.size.height)];
        [self.titleView addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        if (idx == 0) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        }else {
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];

        }
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:_colorNormal forState:UIControlStateNormal];
        [button setTitleColor:_colorSelected forState:UIControlStateSelected];
        button.tag = tagButton + idx;
        [button addTarget:self action:@selector(cationClick:) forControlEvents:UIControlEventTouchUpInside];
        
        sizeWidth += titleWidth + (originXY * 2);
    }];
    self.titleView.contentSize = CGSizeMake((sizeWidth - originXY), self.frame.size.height);
}

#pragma mark - methord

- (void)resetTileLine:(UIButton *)button
{
    if (_showline)
    {
        if (_showlineAnimation)
        {
            __block CGRect rectline = self.titleLine.frame;
            rectline.size.width = button.frame.size.width - 10;
            [UIView animateWithDuration:0.3 animations:^{
                rectline.origin.x = button.frame.origin.x + 5;
                self.titleLine.frame = rectline;
            }];
        }
        else
        {
            CGRect rectline = self.titleLine.frame;
            rectline.size.width = button.frame.size.width + 10;
            rectline.origin.x = button.frame.origin.x - 5;
            self.titleLine.frame = rectline;
        }
    }
}

- (void)resetTitleView:(UIButton *)button
{
    CGFloat buttonRight = button.frame.origin.x + button.frame.size.width + originXY;
    CGFloat buttonLeft = button.frame.origin.x;
    
    if (buttonRight > (self.titleView.frame.size.width + self.previousOffX))
    {
        self.previousOffX = (buttonRight - self.titleView.frame.size.width);
        [self.titleView setContentOffset:CGPointMake(self.previousOffX, 0.0) animated:YES];
    }
    else if (buttonLeft < self.previousOffX)
    {
        self.previousOffX = (buttonRight - button.frame.size.width - originXY * 2);
        [self.titleView setContentOffset:CGPointMake(self.previousOffX, 0.0) animated:YES];
    }
}

- (void)resetTitleButton
{
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)obj;
            if (_colorNormal)
            {
                [button setTitleColor:_colorNormal forState:UIControlStateNormal];
            }
            if (_colorSelected)
            {
                [button setTitleColor:_colorSelected forState:UIControlStateSelected];
            }
        }
    }];
}

- (void)reloadData
{
    [self resetTitleButton];
    
    self.titleLine.hidden = !_showline;
    self.titleLine.backgroundColor = _colorline;
    
    // initinal
    UIButton *button = (UIButton *)[self.titleView viewWithTag:(tagButton + _indexSelected)];
    [self cationClick:button];
}


@end
