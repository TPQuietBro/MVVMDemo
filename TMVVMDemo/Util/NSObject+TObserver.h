//
//  NSObject+TObserver.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TObserverDefine.h"

#define T_Observe_Handler(target,keypath,handlerBlock) [target addObserver:self keyPath:@t_keypath(target,keypath) handler:handlerBlock]

#define T_Observe_Multi_Handler(target,_keys,handlerBlock) [target addObserver:self keyPaths:_keys handler:handlerBlock]
@class TObserverInfo;
@interface NSObject (TObserver)

- (TObserverInfo *)addObserver:(NSObject *)observer keyPath:(NSString *)keyPath handler:(Handler)handler;

- (void)addObserver:(NSObject *)observer keyPaths:(NSArray<NSString *> *)keyPaths handler:(Handler)handler;


@end

