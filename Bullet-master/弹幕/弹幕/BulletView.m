//
//  BulletView.m
//  弹幕
//
//  Created by XWQ on 16/11/23.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "BulletView.h"

#define Padding  10

@interface BulletView()

@property (nonatomic,strong)UILabel *lbComment;

@end

@implementation BulletView


-(instancetype) initWithComment:(NSString *)comment{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:dict].width;
        self.bounds = CGRectMake(0, 0, width+2*Padding, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding, 0, width, 30);
    }
    return self;
}

-(void)startAnmition{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0;
    CGFloat whoileWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    CGFloat speed = whoileWidth / duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed + 0.2;
    
    [self performSelector:@selector(EnterScreen) withObject:nil afterDelay:enterDuration];
    
    /*
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(EnterScreen) object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
     */
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x  -= whoileWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
}

-(void)stopAnmition{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(EnterScreen) object:nil];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}
-(void)EnterScreen{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

-(UILabel *)lbComment{
    if (!_lbComment) {
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        [self addSubview:_lbComment];
    }
    return _lbComment;
}

@end
