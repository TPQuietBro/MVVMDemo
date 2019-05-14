//
//  UIView+Event.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/14.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TViewPropertyAgent.h"

@interface UIView (Event)

@property (nonatomic, strong) TViewPropertyAgent *proAgent;

- (NSMutableArray *)allPropertyies;

/**
 tab手势 无双击

 @param block 事件回调
 */
- (void)tapWithBlock:(void(^)(UIView *target))block;

/**
 tab手势 支持多次点击

 @param isDoubleTapped 是否支持双击
 @param block 事件回调
 */
- (void)tapWithDoubleTapped:(BOOL)isDoubleTapped block:(void(^)(UIView *target))block;

/**
 长按手势

 @param duration 时间
 @param block 事件回调
 */
- (void)longpressWithDuration:(NSInteger)duration block:(void(^)(UIView *target))block;

/**
 侧滑手势,暂未实现

 @param block 事件回调
 */
- (void)swipeWithBlock:(void(^)(UIView *target))block;
@end

