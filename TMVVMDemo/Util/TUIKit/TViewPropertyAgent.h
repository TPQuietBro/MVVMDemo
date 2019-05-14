//
//  TViewPropertyAgent.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/14.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TObserver.h"
#define TOBERSERVE(target,KEYAPTH) [[TViewPropertyAgent alloc] initWithKeyPath:@t_keypath(target,KEYAPTH)];
@interface TViewPropertyAgent : NSObject
@property (nonatomic, strong) NSString *keyPath;
- (instancetype)initWithKeyPath:(NSString *)keyPath;
@end
