//
//  TObserverInfo.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/8.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TObserverInfo.h"
@implementation TObserverInfo
- (instancetype)initWithKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options handler:(Handler)handler{
    if (self = [super init]) {
        _keyPath = keyPath;
        _options = options;
        _handler = [handler copy];
    }
    return self;
}
@end
