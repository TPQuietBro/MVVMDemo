//
//  ViewController.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "ViewController.h"
#import "TLoginViewController.h"
#import "TUIKit.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view tapWithBlock:^(UIView *target) {
        NSLog(@"---%@",[target class]);
    }];
    [self.button clickForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        sender.selected = !sender.selected;
        NSLog(@"button clicked  selected : %d",sender.selected);
    }];
    
    
    [self.button bindConditions:@[@"qqq",@"www"] keyPath:Target_KeyPath(self.button, backgroundColor) bindBlock:^id(NSString *name,NSString *pwd){
        NSLog(@"name : %@,pwd : %@",name,pwd);
        if (name.length > 0 && pwd.length > 0) {
            return [UIColor redColor];
        }
        return [UIColor blueColor];
    }];

    [self.button bindConditions:@[@"123",@"123"] keyPath:Target_KeyPath(self.button, enabled) bindBlock:^id(NSString *name,NSString *pwd){
        NSLog(@"name : %@,pwd : %@",name,pwd);
        return @(name.length > 8 && pwd.length > 8);
    }];
//    [self.button setBackgroundColor:[UIColor redColor]];
//    [self.button setBackgroundColor:[UIColor redColor] forControlState:UIControlStateNormal];
//
//    [self.button setBackgroundColor:[UIColor orangeColor] forControlState:UIControlStateSelected];
//
//    [self.button setBackgroundColor:[UIColor blueColor] forControlState:UIControlStateDisabled];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.button.enabled = NO;
//    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[TLoginViewController new] animated:YES];
    }
}

@end
