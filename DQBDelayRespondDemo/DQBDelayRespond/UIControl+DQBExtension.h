//
//  UIControl+DQBExtension.h
//  DQBDelayRespondDemo
//
//  Created by DQB on 8/16/16.
//  Copyright © 2016 DQB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (DQBExtension)

@property (nonatomic, assign) NSTimeInterval dqb_acceptEventInterval;   // 可以用这个给重复点击加间隔

@end
