//
//  TObserverAgent.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TObserverAgent.h"
#include <pthread.h>
#import "TObserverInfo.h"
#define T_NULL_RETURN \
if (!target || !keyPath) {\
return;\
}

@interface TObserverAgent()
{
    pthread_mutex_t _lock;
}
@property (nonatomic, strong) NSMapTable *infoDict;

@property (nonatomic, strong) Handler handler;
@end
@implementation TObserverAgent

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
    
    TObserverInfo *info = [[TObserverInfo alloc] initWithTarget:target keyPath:keyPath options:NSKeyValueObservingOptionNew handler:handler];
    
    NSMutableSet *infos = [self.infoDict objectForKey:target];
    if ([infos member:info]) {
        ASLog(@"repeated observing");
        return;
    }
    if (!infos) {
        infos = [NSMutableSet set];
    }
    [infos addObject:info];
    
    [self.infoDict setObject:infos forKey:target];
    
    pthread_mutex_unlock(&_lock);
    
    [target addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)t_addObserverForTarget:(NSObject *)target keyPaths:(NSArray *)keyPaths handler:(Handler)handler{
    if (keyPaths.count == 0) {
        ASLog(@"keyPaths is nil");
        return;
    }
    for (NSString *keyPath in keyPaths) {
        [self t_addObserverForTarget:target keyPath:keyPath handler:handler];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (!self.infoDict) {
        ASLog(@"dict is nil");
        return;
    }
    NSMutableSet *infos = [self.infoDict objectForKey:object];
    [infos enumerateObjectsUsingBlock:^(TObserverInfo * _Nonnull info, BOOL * _Nonnull stop) {
        
        if ([info.keyPath isEqualToString:keyPath]) {
            _SAFE_BLOCK(info.handler,change,object,keyPath);
            ASLog(@"newValue : %@",change[NSKeyValueChangeNewKey]);
        }
    }];
}

- (void)dealloc{
    if (!self) {
        return;
    }
    [self t_removeAllObserver];
    ASLog(@"%@ 被释放了",self);
    pthread_mutex_destroy(&_lock);
}

- (void)t_removeAllObserver{
    pthread_mutex_lock(&_lock);

    NSMapTable *infosMap = [self.infoDict copy];
    
    [[infosMap keyEnumerator].allObjects enumerateObjectsUsingBlock:^(NSObject * _Nonnull target, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableSet *infos = [infosMap objectForKey:target];
        [infos enumerateObjectsUsingBlock:^(TObserverInfo *  _Nonnull info, BOOL * _Nonnull stop) {
            [target removeObserver:self forKeyPath:info.keyPath];
        }];
        
        ASLog(@"kvoAgent %@ 移除了观察者",[target class]);
    }];
    [self.infoDict removeAllObjects];
    pthread_mutex_unlock(&_lock);
}

#pragma mark - getter / setter

- (NSMapTable *)infoDict{
    if (!_infoDict) {
        _infoDict = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory];
    }
    return _infoDict;
}
@end
