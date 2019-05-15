//
//  UIButton+Event.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/14.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Event)

/**
 点击事件

 @param controlEvents 触发方式
 @param block 回调
 */
- (void)clickForControlEvents:(UIControlEvents)controlEvents block:(void(^)(UIButton *sender))block;

/**
 根据状态设置背景颜色

 @param backgroundColor 背景颜色
 @param controlState 状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forControlState:(UIControlState)controlState;
@end

