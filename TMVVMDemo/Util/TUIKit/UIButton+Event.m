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

typedef void(^ClickBlock)(UIView *target);

@interface UIButton()
@property (nonatomic, strong) ClickBlock clickBlock;
@property (nonatomic, strong) NSArray *conditions;
@property (nonatomic, strong) TBlock block;
@end

@implementation UIButton (Event)
- (void)clickForControlEvents:(UIControlEvents)controlEvents block:(void (^)(UIButton *))block{
    self.clickBlock = [block copy];
    [self addTarget:self action:@selector(click:) forControlEvents:controlEvents];
}

- (void)click:(UIButton *)sender{
    self.clickBlock ? self.clickBlock(sender): nil;
}

#pragma mark - public

- (void)bindConditions:(NSArray *)conditions bindBlock:(TBlock)block{
    if (conditions.count == 0) {
        return;
    }
    self.block = [block copy];

    id returnValue = [self invokeWithArguments:conditions];
    
    NSArray *allProp = [self allPropertyies];
    NSString *keyPath = self.proAgent.keyPath;
    [allProp enumerateObjectsUsingBlock:^(NSString *  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([@"_plainButtonBackgroundColor" isEqualToString:key]) {
            NSLog(@"keyPath %@",keyPath);
            [self setValue:returnValue forKeyPath:keyPath];
            *stop = YES;
        }
    }];
    
//    if ([returnValue isKindOfClass:[NSNumber class]]) {
//        self.enabled = [returnValue boolValue];
//    } else if ([returnValue isKindOfClass: [UIColor class]]){
//        self.backgroundColor = returnValue;
//    }
}

#pragma mark - private

- (id)invokeWithArguments:(NSArray *)conditions{
    SEL selector = [self selectorForArgumentCount:conditions.count];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    invocation.selector = selector;
    
    for (NSInteger i = 0; i < conditions.count; i++) {
        id arg = conditions[i];
        NSInteger argIndex = i + 2;
        [invocation setArgument:&arg atIndex:argIndex];
    }
    [invocation invokeWithTarget:self];
    
    __unsafe_unretained id returnVal;
    [invocation getReturnValue:&returnVal];
    return returnVal;
}

- (SEL)selectorForArgumentCount:(NSUInteger)count {
    NSCParameterAssert(count > 0);
    
    switch (count) {
        case 0: return NULL;
        case 1: return @selector(performWith:);
        case 2: return @selector(performWith::);
    }
    // 暂时只支持 2个参数
    NSCAssert(NO, @"The argument count is too damn high! Only blocks of up to 2 arguments are currently supported.");
    return NULL;
}

- (id)performWith:(id)obj1 {
    id (^block)(id) = self.block;
    return block(obj1);
}

- (id)performWith:(id)obj1 :(id)obj2 {
    id (^block)(id, id) = self.block;
    return block(obj1, obj2);
}

#pragma mark - associtation

- (void)setBlock:(__strong TBlock)block{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ClickBlock)block{
    return objc_getAssociatedObject(self, @selector(block));
}

- (void)setConditions:(NSArray *)conditions{
    objc_setAssociatedObject(self, @selector(conditions), conditions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)conditions{
    return objc_getAssociatedObject(self, @selector(conditions));
}

- (void)setClickBlock:(ClickBlock)clickBlock{
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ClickBlock)clickBlock{
    return objc_getAssociatedObject(self, @selector(clickBlock));
}

@end
