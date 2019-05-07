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

@interface TLoginView()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label1;
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
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).mas_equalTo(5);
        make.centerX.mas_equalTo(self);
    }];
}

#pragma mark - public

- (void)bindViewModel:(TLoginViewModel *)viewModel{
    self.viewModel = viewModel;
    __weak typeof(self) weak_self = self;
    
    [T_Observe(self.viewModel, name1) statusChangeHandler:^(id newValue) {
        weak_self.label1.text = newValue;
    }];
    
}

#pragma mark - event response
- (void)login:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.label1.text = self.viewModel.name1;
    } else {
        self.label1.text = self.viewModel.name2;
    }
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
        _label1.text = @"我是label";
    }
    return _label1;
}
@end
