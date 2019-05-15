//
//  UIView+PropertyBind.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/15.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wstrict-prototypes\"") \
typedef id(^TBlock)();
_Pragma("clang diagnostic pop")


@interface UIView (PropertyBind)

/**
 绑定UI的属性,回调逻辑实现的条件

 @param conditions 条件
 @param keyPath 属性 建议使用Target_KeyPath宏,避免硬编码
 @param block 条件回调
 */
- (void)bindConditions:(NSArray *)conditions keyPath:(NSString *)keyPath bindBlock:(TBlock)block;
@end

