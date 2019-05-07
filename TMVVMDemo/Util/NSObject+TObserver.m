//
//  NSObject+TObserver.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "NSObject+TObserver.h"
#import <objc/runtime.h>
#import "TBaseDefine.h"
@interface NSObject()

@end

@implementation NSObject (TObserver)

- (NSObject *)addObserver:(id)observer keyPath:(NSString *)keyPath{
    
    ASLog(@"target : %@ keyPath : %@",[self class],keyPath);
    
    return self;
}

- (void)statusChangeHandler:(void (^)(id))handler{
    self.handler = [handler copy];
}

#pragma mark - association

- (void)setHandler:(Handler)handler{
    objc_setAssociatedObject(self, @selector(setHandler:), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Handler)handler{
    return objc_getAssociatedObject(self, @selector(setHandler:));
}

@end
