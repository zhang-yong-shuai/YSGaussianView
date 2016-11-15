//
//  MGaussianView.m
//  MBuyGo_HD
//
//  Created by 张永帅 on 15/4/17.
//  Copyright (c) 2015年 Corpse. All rights reserved.
//

#import "YSGaussianView.h"

#define kGaussianViewTag 1313

@interface YSGaussianView ()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation YSGaussianView
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame BlurStyle:(UIBlurEffectStyle)blurStyle {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.f) {
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:blurStyle];
            UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            blurView.frame = self.frame;
            blurView.alpha = 0.95;
            [self addSubview:blurView];
        } else {
            self.clipsToBounds = YES;
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
            toolbar.alpha = 0.98;
            self.toolbar = toolbar;
            [self.layer insertSublayer:self.toolbar.layer atIndex:0];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        return;
    }
    self.toolbar.frame = self.bounds;
}

#pragma mark - called outside
+ (void)show {
    YSGaussianView *gView = [[YSGaussianView alloc] initWithFrame:[UIScreen mainScreen].bounds BlurStyle:UIBlurEffectStyleExtraLight];
    gView.tag = kGaussianViewTag;
    [[[UIApplication sharedApplication] keyWindow] addSubview:gView];
}

+ (void)dismiss {
    NSArray *subViews = [[UIApplication sharedApplication] keyWindow].subviews;
    for (id object in subViews) {
        if ([[object class] isSubclassOfClass:[YSGaussianView class]]) {
            __block YSGaussianView *gView = (YSGaussianView *)object;
            if (gView.tag == kGaussianViewTag) {
                [UIView animateWithDuration:0.2 animations:^{
                    gView.alpha = 0;
                    [gView removeFromSuperview];
                    gView = nil;
                }];
            }
        }
    }
}

@end
