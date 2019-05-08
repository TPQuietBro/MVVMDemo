//
//  TObserverKiller.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TObserverKiller.h"
#include <pthread.h>
#define T_NULL_RETURN \
if (!target || !keyPath) {\
return;\
}

@interface TObserverKiller()
{
    pthread_mutex_t _lock;
}
@property (nonatomic, strong) NSMapTable *targetDict;
@property (nonatomic, strong) NSMapTable *handlerDict;
@property (nonatomic, strong) Handler handler;
@end
@implementation TObserverKiller

- (instancetype)init
{
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

- (void)t_addObserverForTarget:(NSObject *)target keyPath:(NSString *)keyPath handler:(Handler)handler{
    T_NULL_RETURN
    pthread_mutex_lock(&_lock);
    [self.targetDict setObject:target forKey:keyPath];
    [self.handlerDict setObject:handler forKey:keyPath];
    pthread_mutex_unlock(&_lock);
    
    _target = target;
    _keyPath = keyPath;
    _handler = [handler copy];
    
    [target addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (!self.targetDict) {
        ASLog(@"dict is nil");
        return;
    }
    if ([self.targetDict objectForKey:keyPath]) {
        ASLog(@"newValue : %@",change[NSKeyValueChangeNewKey]);
        Handler handler = [self.handlerDict objectForKey:keyPath];
        SAFE_BLOCK(handler,change,[self.targetDict objectForKey:keyPath],keyPath);
    }
//    if ([_keyPath isEqualToString:keyPath]) {
//        SAFE_BLOCK(_handler,change,[self.targetDict objectForKey:keyPath],keyPath);
//    }
}

- (void)dealloc{
    if (!self) {
        return;
    }
    
    [self t_removeAllObserver];
    
//    [_target removeObserver:self forKeyPath:_keyPath];
    
    ASLog(@"%@ 被释放了",self);
}

- (void)t_removeAllObserver{
    pthread_mutex_lock(&_lock);
    [[self.targetDict.keyEnumerator allObjects] enumerateObjectsUsingBlock:^(NSString *  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        id target = [self.targetDict objectForKey:key];
        [target removeObserver:self forKeyPath:key];
        ASLog(@"%@ 移除了观察者",target);
    }];
    [self.targetDict removeAllObjects];
    [self.handlerDict removeAllObjects];
    pthread_mutex_unlock(&_lock);
}

#pragma mark - getter / setter

- (TObserverKiller *)subKiller{
    return [[TObserverKiller alloc] init];
}

- (NSMapTable *)targetDict{
    if (!_targetDict) {
        _targetDict = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
    }
    return _targetDict;
}

- (NSMapTable *)handlerDict{
    if (!_handlerDict) {
        _handlerDict = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    }
    return _handlerDict;
}
@end
