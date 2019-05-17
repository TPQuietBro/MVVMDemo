//
//  UIView+PropertyBind.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/15.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "UIView+PropertyBind.h"
#import <objc/runtime.h>
@interface UIView()
@property (nonatomic, strong) TBlock bindBlock;
@end
@implementation UIView (PropertyBind)

#pragma mark - public

- (void)bindConditions:(NSArray *)conditions keyPath:(NSString *)keyPath bindBlock:(TBlock)block{
    if (conditions.count == 0) {
        return;
    }
    self.bindBlock = [block copy];
    
    id returnValue = [self invokeWithArguments:conditions];
    
    SEL propSelector = NSSelectorFromString(keyPath);
    
    BOOL isRespondSelector = [self selfRespondsToSelector:propSelector returnValue:returnValue keyPath:keyPath];
    
    if (!isRespondSelector) {
        propSelector = NSSelectorFromString([self isGetterKeyPath:keyPath]);
        [self selfRespondsToSelector:propSelector returnValue:returnValue keyPath:keyPath];
    }
}

#pragma mark - override

// 防止KVC崩溃
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key hasPrefix:@"is"]) {
        key = [self originalKeyPathWithOutIs:key];
        [self setValue:value forKeyPath:key];
    }
}

#pragma mark - private

- (BOOL)selfRespondsToSelector:(SEL)aSelector returnValue:(id)returnValue keyPath:(NSString *)keyPath{
    if ([self instances:[self class] RespondToSelector:aSelector]) {
        if (returnValue && keyPath.length > 0) {
            [self setValue:returnValue forKeyPath:keyPath];
        }
        return YES;
    }
    return NO;
}
// 去掉i'is'属性
- (NSString *)originalKeyPathWithOutIs:(NSString *)keyPath{
    keyPath = [keyPath lowercaseString];
    return [keyPath stringByReplacingOccurrencesOfString:@"is" withString:@""];
}

// 包含'is'的属性
- (NSString *)isGetterKeyPath:(NSString *)keyPath{
    if (keyPath.length == 0) {
        return @"";
    }
    NSString *realKeyPath = [keyPath capitalizedString];
    
    return [NSString stringWithFormat:@"is%@",realKeyPath];
}

- (BOOL)instances:(Class)class RespondToSelector:(SEL)selector{
    if ([class instancesRespondToSelector:selector]) {
        return YES;
    } else {
        if (class.superclass) {
            return [self instances:class.superclass RespondToSelector:selector];
        }
    }
    return NO;
}

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
    id (^block)(id) = self.bindBlock;
    return block(obj1);
}

- (id)performWith:(id)obj1 :(id)obj2 {
    id (^block)(id, id) = self.bindBlock;
    return block(obj1, obj2);
}

#pragma mark - association

- (void)setBindBlock:(__strong TBlock)bindBlock{
    objc_setAssociatedObject(self, @selector(bindBlock), bindBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TBlock)bindBlock{
    return objc_getAssociatedObject(self, @selector(bindBlock));
}

@end
