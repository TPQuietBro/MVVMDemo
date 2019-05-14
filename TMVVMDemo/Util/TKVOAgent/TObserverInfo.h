//
//  TObserverInfo.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/8.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TObserverDefine.h"
@class TObserverKiller;
@interface TObserverInfo : NSObject
@property (nonatomic, assign) NSKeyValueObservingOptions options;
@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic, strong) Handler handler;
@property (nonatomic, strong) NSObject *target;
- (instancetype)initWithTarget:(NSObject *)target keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options handler:(Handler)handler;
@end
