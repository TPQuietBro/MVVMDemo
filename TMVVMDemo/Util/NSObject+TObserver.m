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

static NSMutableDictionary *_dict;
static Handler _handler;
static TObserverKiller *killer;

@interface NSObject()
@property (nonatomic, strong) Handler handler;
@end

@implementation NSObject (TObserver)

- (NSObject *)addObserver:(NSObject *)observer keyPath:(NSString *)keyPath{
    
    ASLog(@"target : %@ keyPath : %@",[self class],keyPath);
    if (!observer) {
        NSAssert(observer, @"observer must not be nil");
        return self;
    }
    if (!_dict) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    [_dict setObject:observer forKey:keyPath];
    
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    return self;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (!_dict) {
        ASLog(@"obDict is nil");
        return;
    }
    [_dict enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
        if ([keyPath isEqualToString:key]) {
            ASLog(@"handler : %@",_handler);
            SAFE_BLOCK(_handler,change[NSKeyValueChangeNewKey],obj);
        }
    }];
}

- (void)statusChangeHandler:(Handler)handler{
    _handler = [handler copy];
}

#pragma mark - association

- (void)setHandler:(Handler)handler{
    objc_setAssociatedObject(self, @selector(setHandler:), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Handler)handler{
    return objc_getAssociatedObject(self, @selector(setHandler:));
}

@end
