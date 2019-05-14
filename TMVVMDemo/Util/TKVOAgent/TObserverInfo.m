//
//  TObserverInfo.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/8.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TObserverInfo.h"
@implementation TObserverInfo
- (instancetype)initWithTarget:(NSObject *)target keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options handler:(Handler)handler{
    if (self = [super init]) {
        _target = target;
        _keyPath = keyPath;
        _options = options;
        _handler = [handler copy];
    }
    return self;
}

- (BOOL)isEqual:(TObserverInfo *)object{
    BOOL isSameTarget = [self.target isEqual:object];
    BOOL isSameKeyPath = [self.keyPath isEqualToString:object.keyPath];
    
    if (isSameTarget && isSameKeyPath) {
        return YES;
    }
    return NO;
}
@end
