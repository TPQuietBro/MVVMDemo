//
//  TObserverInfo.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/8.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TObserverInfo.h"
#import "TObserverKiller.h"
@implementation TObserverInfo
- (instancetype)initWithObserverKiller:(TObserverKiller *)killer{
    if (self = [super init]) {
        _target = killer.target;
        _keyPath = killer.keyPath;
    }
    return self;
}
@end
