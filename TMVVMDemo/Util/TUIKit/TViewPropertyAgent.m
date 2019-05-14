//
//  TViewPropertyAgent.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/14.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TViewPropertyAgent.h"
@interface TViewPropertyAgent()

@end
@implementation TViewPropertyAgent
- (instancetype)initWithKeyPath:(NSString *)keyPath{
    self = [super init];
    if (self) {
        _keyPath = keyPath;
    }
    return self;
}
@end
