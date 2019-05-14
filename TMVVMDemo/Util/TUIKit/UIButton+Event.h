//
//  UIButton+Event.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/14.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wstrict-prototypes\"") \
typedef id(^TBlock)();
_Pragma("clang diagnostic pop")

@interface UIButton (Event)
- (void)clickForControlEvents:(UIControlEvents)controlEvents block:(void(^)(UIButton *sender))block;

- (void)bindConditions:(NSArray *)conditions bindBlock:(TBlock)block;
@end

