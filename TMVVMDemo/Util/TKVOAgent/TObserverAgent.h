//
//  TObserverAgent.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TObserverDefine.h"

#define TKVO(observer,target,key_path,block) [observer t_addObserverForTarget:target keyPath:@t_keypath(target,key_path) handler:block]

@interface TObserverAgent : NSObject
// 单个keyPath
- (void)t_addObserverForTarget:(NSObject *)target
                       keyPath:(NSString *)keyPath
                       handler:(Handler)handler;
// 多个keyPath
- (void)t_addObserverForTarget:(NSObject *)target
                      keyPaths:(NSArray *)keyPaths
                       handler:(Handler)handler;
@end
