//
//  UIButton+Event.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/14.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "UIButton+Event.h"
#import <objc/runtime.h>
#import "UIView+Event.h"
#import "UIImage+ImageUtil.h"

typedef void(^ClickBlock)(UIButton *target);

@interface UIButton()
@property (nonatomic, strong) ClickBlock clickBlock;
@end

@implementation UIButton (Event)

#pragma mark - click

- (void)clickForControlEvents:(UIControlEvents)controlEvents block:(void (^)(UIButton *))block{
    self.clickBlock = [block copy];
    [self addTarget:self action:@selector(click:) forControlEvents:controlEvents];
}

- (void)click:(UIButton *)sender{
    self.clickBlock ? self.clickBlock(sender): nil;
}

#pragma mark - property

- (void)setBackgroundColor:(UIColor *)backgroundColor forControlState:(UIControlState)controlState{
    UIImage *image = [UIImage imageWithColor:backgroundColor];
    [self setBackgroundImage:image forState:controlState];
}

#pragma mark - associtation

- (void)setClickBlock:(ClickBlock)clickBlock{
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ClickBlock)clickBlock{
    return objc_getAssociatedObject(self, @selector(clickBlock));
}

@end
