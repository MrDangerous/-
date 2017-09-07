//
//  BulletManage.h
//  弹幕
//
//  Created by XWQ on 16/11/23.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;
@interface BulletManage : NSObject

@property (nonatomic,copy)void (^generateViewBlock)(BulletView *view);

-(void)start;

-(void)stop;



@end
