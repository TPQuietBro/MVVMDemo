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
#import "TObserver.h"

@interface TLoginView()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UITextField *textF1;
@property (nonatomic, strong) UITextField *textF2;
@property (nonatomic, strong) TLoginViewModel *viewModel;
@property (nonatomic, strong) TObserverAgent *kvoAgent;
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
    self.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.button];
    [self addSubview:self.label1];
    [self addSubview:self.textF1];
    [self addSubview:self.label2];
    [self addSubview:self.textF2];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(16);
    }];
    
    [self.textF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.label1);
        make.left.mas_equalTo(self.label1.mas_right).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(16);
    }];
    
    [self.textF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.label2);
        make.left.mas_equalTo(self.label2.mas_right).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
}

#pragma mark - public

- (void)bindViewModel:(TLoginViewModel *)viewModel{
    self.viewModel = viewModel;
    
//    self.kvoAgent = [[TObserverAgent alloc] init];
//    Weakify(self);
//    
//    [self.kvoAgent t_addObserverForTarget:self.viewModel keyPaths:@[@"name1",@"name2"] handler:^(NSDictionary *change, id target, NSString *keyPath) {
//        Strongify(self);
//        id newValue = change[NSKeyValueChangeNewKey];
//        if ([keyPath isEqualToString:@t_keypath(self.viewModel,name1)]) {
//            self.label1.text = newValue;
//        } else {
//            self.label2.text = newValue;
//        }
//    }];
}

#pragma mark - event response
- (void)login:(UIButton *)sender{
    
    NSDictionary *params = @{
                             @"username" : self.textF1.text,
                             @"pwd" : self.textF2.text
                             };
    // 执行登录
    [self.viewModel.command excute:params];
}

- (void)acountInput:(UITextField *)textField{
    self.button.enabled = self.textF1.text.length > 8 && self.textF2.text.length > 6;
}

- (void)pwdInput:(UITextField *)textField{
    self.button.enabled = self.textF1.text.length > 8 && self.textF2.text.length > 6;
}

#pragma mark - getter / setter

- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.enabled = NO;
        [_button setTitle:@"login" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_button setBackgroundColor:[UIColor whiteColor]];
        [_button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.text = @"账号";
    }
    return _label1;
}

- (UITextField *)textF1{
    if (!_textF1) {
        _textF1 = [[UITextField alloc] init];
        _textF1.placeholder = @"请输入账号...";
        [_textF1 addTarget:self action:@selector(acountInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textF1;
}

- (UITextField *)textF2{
    if (!_textF2) {
        _textF2 = [[UITextField alloc] init];
        _textF2.placeholder = @"请输入密码...";
        [_textF2 addTarget:self action:@selector(pwdInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textF2;
}

- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.text = @"密码";
    }
    return _label2;
}
@end
