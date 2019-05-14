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
        NSLog(@"button clicked");
    }];

    
//    [self.button bindConditions:@[@"123",@"123"] bindBlock:^id(NSString *name,NSString *pwd){
//        NSLog(@"name : %@,pwd : %@",name,pwd);
//        return @(name.length > 0 && pwd.length > 0);
//    }];
    
    self.button.proAgent = TOBERSERVE(self.button,backgroundColor);
    [self.button bindConditions:@[@"qqq",@"www"] bindBlock:^id(NSString *name,NSString *pwd){
        NSLog(@"name : %@,pwd : %@",name,pwd);
        if (name.length > 0 && pwd.length > 0) {
            return [UIColor redColor];
        }
        return [UIColor blueColor];
    }];
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
