//
//  BulletManage.m
//  弹幕
//
//  Created by XWQ on 16/11/23.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "BulletManage.h"
#import "BulletView.h"

@interface BulletManage()

//弹幕数据来源
@property (nonatomic,strong)NSMutableArray *datasourse;

//弹幕使用过程中的数组变量
@property (nonatomic,strong)NSMutableArray *bulletComment;

//存储弹幕view的数组
@property (nonatomic,strong)NSMutableArray *bulletViews;


@property (nonatomic,assign)BOOL bStopAnimation;
@end

@implementation BulletManage

-(instancetype)init{
    if (self = [super init]) {
        self.bStopAnimation = YES;
    }
    return self;
}

-(NSMutableArray *)datasourse{
    if (!_datasourse) {
        _datasourse = [NSMutableArray arrayWithObjects:@"弹幕一~~~~~~",@"弹幕二~~~~~~~~~~~~~~",@"弹幕三~哈哈哈",@"弹幕四~哈哈哈",@"弹幕五~哈哈哈",@"弹幕六~哈哈哈",@"弹幕7~哈哈哈", nil];
    }
    return _datasourse;
}


-(NSMutableArray *)bulletComment{
    if (!_bulletComment) {
        _bulletComment = [NSMutableArray array];
    }
    return _bulletComment;
}

-(NSMutableArray *)bulletViews{
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}

-(void)start{
    if (!self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = NO;

    [self.bulletComment removeAllObjects];
    [self.bulletComment addObjectsFromArray:self.datasourse];
    
    [self initBulletComment];
}
-(void)stop{
    if (self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = YES;

    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnmition];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}

-(void)initBulletComment{
    //三个弹道
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for (int i = 0; i<3; i++) {
        if(self.bulletComment.count > 0)
        {
            NSInteger index = arc4random()%trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            //删除这个
            [trajectorys removeObjectAtIndex:index];
            
            //从弹幕数组中逐一取出弹幕数据
            NSString *comment = [self.bulletComment firstObject];
            [self.bulletComment removeObjectAtIndex:0];
            
            [self createBulletView:comment trajectory:trajectory];
        }
    }
    
    NSLog(@"%@",self.bulletComment);
    
}

-(void)createBulletView:(NSString *)comment trajectory:(int)trajectory{
    if (self.bStopAnimation) {
        return;
    }
    
    BulletView *view = [[BulletView alloc]initWithComment:comment];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    
    __weak typeof (view) weakView = view;
    __weak typeof (self) myself = self;
    NSLog(@"%@",self.bulletComment);

    view.moveStatusBlock = ^(MoveStatus status){
        if (myself.bStopAnimation) {
            return;
        }
        switch (status) {
            case Start:
            {
                //弹幕开始进入屏幕
                [myself.bulletViews addObject:weakView];
            }
                break;
            case Enter:
            {
                //弹幕完全进入屏幕,判断是否还有其他内容,有追加
                NSString *comment = [myself nextComment];
                if (comment) {
                    [myself createBulletView:comment trajectory:trajectory];
                }
            }
                break;
            case End:
            {
                if ([myself.bulletViews containsObject:weakView]) {
                    [weakView stopAnmition];
                    [myself.bulletViews removeObject:weakView];
                }
                if (myself.bulletViews.count == 0) {
                    //说明屏幕上面没有弹幕,开始循环
                    self.bStopAnimation = YES;
                    [myself start];
                }

            }
                break;
                
            default:
                break;
        }
     
    };
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
    
}

-(NSString *)nextComment{
    if (self.bulletComment.count == 0) {
        return nil;
    }
    
    NSString *comment = [self.bulletComment firstObject];
    if (comment) {
        [self.bulletComment removeObjectAtIndex:0];
    }
    return comment;
}

@end
