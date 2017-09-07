//
//  BulletView.h
//  弹幕
//
//  Created by XWQ on 16/11/23.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MoveStatus){
    Start,
    Enter,
    End
};

@interface BulletView : UIView
@property (nonatomic,assign)int trajectory;//
@property (nonatomic,copy)void(^moveStatusBlock)(MoveStatus);

-(instancetype) initWithComment:(NSString *)comment;

-(void)startAnmition;

-(void)stopAnmition;


@end
