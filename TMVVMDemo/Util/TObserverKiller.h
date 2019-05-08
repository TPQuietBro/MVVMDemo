//
//  TObserverKiller.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TObserverDefine.h"

@interface TObserverKiller : NSObject

@property (nonatomic, weak) NSObject *target;
@property (nonatomic, strong) NSString *keyPath;

- (void)t_addObserverForTarget:(NSObject *)target
                       keyPath:(NSString *)keyPath handler:(Handler)handler;
@end
