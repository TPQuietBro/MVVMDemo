//
//  TObserverKiller.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TObserverKiller.h"
#import "TObserverDefine.h"

#define T_NULL_RETURN \
if (!target || !keyPath) {\
return;\
}

@interface TObserverKiller()
@property (nonatomic, strong) NSMutableDictionary *observerDict;

@end
@implementation TObserverKiller

- (void)t_addObserver:(NSObject *)observer target:(NSObject *)target keyPath:(NSString *)keyPath{
    T_NULL_RETURN
    _target = target;
    _observer = observer;
    _keyPath = keyPath;
}

- (void)dealloc{
    [self.observerDict removeAllObjects];
    if (!self.observer) {
        return;
    }
    [self.target removeObserver:self.observer forKeyPath:self.keyPath];
    ASLog(@"%@ 被释放了",self.observer);
}

- (void)t_removeObserverFor:(NSObject *)target keyPath:(NSString *)keyPath{
    T_NULL_RETURN

}

- (void)t_removeAllObserver{
    
}

#pragma mark - getter / setter
- (NSMutableDictionary *)observerDict{
    if (!_observerDict) {
        _observerDict = [[NSMutableDictionary alloc] init];
    }
    return _observerDict;
}
@end
