//
//  SYMoreButtonView.h
//  DemoMoreButton
//
//  Created by dongmingming on 2018/5/11.
//  Copyright © 2018年 DongMingMing. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const heightSYMoreButtonView = 40.0;

@protocol SYMoreButtonDelegate <NSObject>

@optional
- (void)sy_buttonClick:(NSInteger)index;

@end

@interface SYMoreButtonView : UIView

/// title Array
@property (nonatomic, strong) NSArray <NSString *> *titles;

/// show line default no
@property (nonatomic, assign) BOOL showline;
// showlineAnimation default no
@property (nonatomic, assign) BOOL showlineAnimation;
/// colorline
@property (nonatomic, strong) UIColor *colorline;

/// initinal indexSelected default 0
@property (nonatomic, assign) NSInteger indexSelected;
/// colorNormal default black
@property (nonatomic, strong) UIColor *colorNormal;
/// colorSelected
@property (nonatomic, strong) UIColor *colorSelected;

/// response
@property (nonatomic, copy) void (^buttonClick)(NSInteger index);

/// delegate
@property (nonatomic, assign) id<SYMoreButtonDelegate> delegate;

/// reload data
- (void)reloadData;

- (void)resetTitleButton;

@end
