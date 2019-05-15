//
//  UIView+Event.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/14.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "UIView+Event.h"
#import <objc/runtime.h>

typedef void(^GestureBlock)(UIView *target);

@interface UIView()
@property (nonatomic, strong) GestureBlock block;
@end

@implementation UIView (Event)
- (void)tapWithBlock:(void(^)(UIView *target))block{
    self.block = [block copy];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [self addGestureRecognizer:tap];
}

- (void)tapWithDoubleTapped:(BOOL)isDoubleTapped block:(void (^)(UIView *))block{
    self.block = [block copy];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    if (isDoubleTapped) {
        tap.numberOfTapsRequired = 2;
    }
    [self addGestureRecognizer:tap];
}

- (void)longpressWithDuration:(NSInteger)duration block:(void (^)(UIView *))block{
    self.block = [block copy];
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longSelector:)];
    [self addGestureRecognizer:tap];
    
    if (duration > 0) {
        tap.minimumPressDuration = duration;
    }
}

- (void)swipeWithBlock:(void(^)(UIView *target))block{
    //# TODO
}

#pragma mark - selector
- (void)tapSelector:(UITapGestureRecognizer *)tap{
    UIView *target = tap.view;
    self.block ? self.block(target) : nil;
}

- (void)longSelector:(UILongPressGestureRecognizer *)tap{
    UIView *target = tap.view;
    self.block ? self.block(target) : nil;
}


#pragma mark - base

- (NSMutableArray *)allPropertyies{
    __block NSMutableArray *props = [[NSMutableArray alloc] init];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (NSInteger i = 0; i < count; i++) {
            const char *pName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:pName];
            if (name) {
                [props addObject:name];
            }
        }
        free(properties);
    });
    return props;
}

#pragma mark - assiciation

//- (void)setProAgent:(TViewPropertyAgent *)proAgent{
//    objc_setAssociatedObject(self, @selector(proAgent), proAgent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (TViewPropertyAgent *)proAgent{
//    return objc_getAssociatedObject(self, @selector(proAgent));
//}

- (void)setBlock:(GestureBlock)block{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GestureBlock)block{
    return objc_getAssociatedObject(self, @selector(block));
}
@end
