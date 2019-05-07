//
//  NSObject+TObserver.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "NSObject+TObserver.h"
#import <objc/runtime.h>
#import "TObserverDefine.h"
#import "TObserverKiller.h"

static Handler _handler;
static TObserverKiller *_killer;

@interface NSObject()
@property (nonatomic, strong) Handler handler;
@property (nonatomic, strong) TObserverKiller *killer;
@end

@implementation NSObject (TObserver)

- (NSObject *)addObserver:(NSObject *)observer keyPath:(NSString *)keyPath{
    
    ASLog(@"target : %@ keyPath : %@",[self class],keyPath);
    if (!observer) {
        NSAssert(observer, @"observer must not be nil");
        return self;
    }
    
    if (!_killer) {
        _killer = [[TObserverKiller alloc] init];
//        self.killer = [[TObserverKiller alloc] init];
    }
    [self.killer t_addObserver:observer target:self keyPath:keyPath];
    ASLog(@"killer : %@",self.killer);
    
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (!self.killer) {
        ASLog(@"killer is nil");
        return;
    }
    
    if ([self.killer.keyPath isEqualToString:keyPath]) {
        SAFE_BLOCK(self.handler,change[NSKeyValueChangeNewKey],self);
    }
}


- (void)statusChangeHandler:(Handler)handler{
    self.handler = [handler copy];
}

#pragma mark - association

- (void)setKiller:(TObserverKiller *)killer{
    objc_setAssociatedObject(self, @selector(setKiller:), killer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TObserverKiller *)killer{
    TObserverKiller *killer = objc_getAssociatedObject(self, @selector(setKiller:));
    if (!killer) {
        killer = [[TObserverKiller alloc] init];
    }
    return killer;
}

- (void)setHandler:(Handler)handler{
    objc_setAssociatedObject(self, @selector(setHandler:), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Handler)handler{
    Handler handler = objc_getAssociatedObject(self, @selector(setHandler:));
    if (!handler) {
        handler = ^(id newValue,id observer){};
    }
    return handler;
}

@end
