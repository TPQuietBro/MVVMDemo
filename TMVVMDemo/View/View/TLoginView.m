//
//  TLoginView.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TLoginView.h"
#import "TLoginViewModel.h"
#import <Masonry.h>
#import "TCommand.h"
#import "TObserverKiller.h"
#import "TObserver.h"

@interface TLoginView()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) TLoginViewModel *viewModel;
@end
@implementation TLoginView

#pragma mark - init methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    self.backgroundColor = [UIColor redColor];
    [self addSubview:self.button];
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).mas_equalTo(5);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).mas_equalTo(5);
        make.centerX.mas_equalTo(self);
    }];
}

#pragma mark - public

- (void)bindViewModel:(TLoginViewModel *)viewModel{
    self.viewModel = viewModel;
    self.label1.text = viewModel.name1;
    self.label2.text = viewModel.name2;
    
    __weak typeof(self) weak_self = self;

//    T_Observe_Handler(self.viewModel, name1, ^(NSDictionary *change, id target, NSString *keyPath){
//        id newValue = change[NSKeyValueChangeNewKey];
//        weak_self.label1.text = newValue;
//    });

//    T_Observe_Handler(self.viewModel, name2, ^(NSDictionary *change, id target, NSString *keyPath){
//        id newValue = change[NSKeyValueChangeNewKey];
//        weak_self.label2.text = newValue;
//    });
    
//    Handler handler = nil;
//    T_Observe_Multi_Handler(self.viewModel, @[@"name1",@"name2"], handler);
//    ^(NSDictionary *change, id target, NSString *keyPath){
//        id newValue = change[NSKeyValueChangeNewKey];
//        weak_self.label2.text = newValue;
//    }
    
    T_Observe_Multi_Handler(self.viewModel, (@[@"name1",@"name2"]), ^(NSDictionary *change, id target, NSString *keyPath){
        id newValue = change[NSKeyValueChangeNewKey];
        if ([keyPath isEqualToString:@t_keypath(weak_self.viewModel,name1)]) {
            weak_self.label1.text = newValue;
        } else {
            weak_self.label2.text = newValue;
        }
    });
}

#pragma mark - event response
- (void)login:(UIButton *)sender{
    
}

#pragma mark - getter / setter

- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"login" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.text = @"我是label1";
    }
    return _label1;
}

- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.text = @"我是label2";
    }
    return _label2;
}
@end
