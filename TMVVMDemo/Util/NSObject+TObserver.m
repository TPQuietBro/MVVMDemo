//
//  NSObject+TObserver.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "NSObject+TObserver.h"
#import <objc/runtime.h>
#import "TObserverKiller.h"
#import "TObserverInfo.h"

@interface NSObject()
@property (nonatomic, strong) TObserverKiller *killer;
@end

@implementation NSObject (TObserver)

- (TObserverInfo *)addObserver:(NSObject *)observer keyPath:(NSString *)keyPath handler:(Handler)handler{
    ASLog(@"target : %@ keyPath : %@",[self class],keyPath);
    if (!observer) {
        NSAssert(observer, @"observer must not be nil");
    }
    
    if (!self.killer) {
        self.killer = [[TObserverKiller alloc] init];
    }
    [self.killer t_addObserverForTarget:self keyPath:keyPath handler:^(NSDictionary *change, id target,NSString* keyPath) {
        ASLog(@"handler : %@",handler);
        SAFE_BLOCK(handler,change,target,keyPath);
    }];
    
    TObserverInfo *info = [[TObserverInfo alloc] initWithObserverKiller:self.killer];
    return info;
}

- (void)addObserver:(NSObject *)observer keyPaths:(NSArray<NSString *> *)keyPaths handler:(Handler)handler{
    if (keyPaths.count == 0) {
        ASLog(@"keyPaths is nil");
        return;
    }
    
    for (NSString *keyPath in keyPaths) {
        [self addObserver:observer keyPath:keyPath handler:handler];
    }
}

#pragma mark - association

- (void)setKiller:(TObserverKiller *)killer{
    objc_setAssociatedObject(self, @selector(killer), killer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TObserverKiller *)killer{
    TObserverKiller *killer = objc_getAssociatedObject(self, @selector(killer));
    return killer;
}
@end
