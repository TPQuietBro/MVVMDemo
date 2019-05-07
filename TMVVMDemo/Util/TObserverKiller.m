//
//  TObserverKiller.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TObserverKiller.h"
#import "TObserverDefine.h"

@interface TObserverKiller()
@property (nonatomic, strong) NSMutableDictionary *observerDict;
@end
@implementation TObserverKiller

- (void)t_addObserver:(NSObject *)observer keyPath:(NSString *)keyPath{
    if (!observer || !keyPath) {
        return;
    }
    [self.observerDict setObject:observer forKey:keyPath];
}

- (void)t_removeObserver:(NSObject *)observer keyPath:(NSString *)keyPath{
    NSObject
    [self.observerDict removeObjectForKey:keyPath];
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
