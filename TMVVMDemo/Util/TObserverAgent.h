//
//  TObserverAgent.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TObserverDefine.h"

#define TKVO(target,keyPath) 

@interface TObserverAgent : NSObject

- (void)t_addObserverForTarget:(NSObject *)target
                       keyPath:(NSString *)keyPath handler:(Handler)handler;

- (void)t_addObserverForTarget:(NSObject *)target
                      keyPaths:(NSArray *)keyPaths handler:(Handler)handler;
@end
