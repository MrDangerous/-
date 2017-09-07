//
//  ViewController.m
//  弹幕
//
//  Created by XWQ on 16/11/23.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "ViewController.h"
#import "BulletManage.h"
#import "BulletView.h"
@interface ViewController ()
@property (nonatomic,strong)BulletManage *manage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manage = [[BulletManage alloc]init];
    
    __weak typeof (self) myself = self;
   
    self.manage.generateViewBlock = ^(BulletView *view){
        [myself addBulletView:view];
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn setTitle:@"开始弹幕" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(230, 100, 100, 30);
    [btn1 setTitle:@"停止弹幕" forState:UIControlStateNormal];

    [btn1 addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    btn1.backgroundColor = [UIColor orangeColor];
}
-(void)btnClick{
    [self.manage start];

}
-(void)stop{
    [self.manage stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addBulletView:(BulletView *)view{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory*40, CGRectGetWidth(view.bounds),CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    [view startAnmition];
    
}

@end
