//
//  Request.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/10/20.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//  针对一些需要进行超时处理的操作，可以使用此类来完成
//  此类也作为超时管理类（TimeOutHandleManager）的基础模型，用来记录超时请求的一些关键信息

#import <Foundation/Foundation.h>

@class TimeoutHandle;

//超时回调
typedef void(^TimeOutCallback)(TimeoutHandle *request);
typedef void(^TimeOutHandleTimeCallback)(TimeoutHandle *request, NSTimeInterval handleTime);

@interface TimeoutHandle : NSObject

//发起请求的时间
@property (assign, nonatomic) NSTimeInterval time;
//请求标识符
@property (strong, nonatomic) NSString *identifier;
//
@property (copy, nonatomic) TimeOutCallback timeOutHandle;
//超时回调
@property (copy, nonatomic) TimeOutHandleTimeCallback handleTimeBlock;
//超时时间，<=0时不回调
@property (assign, nonatomic) NSInteger timeout;
//请求是否失效
@property (readonly, nonatomic) BOOL isValid;

//请求开始生效
- (void)valid;
//请求失效
- (void)invalidate;

- (id)initWithTimeout:(NSInteger)timeout timeOutHandle:(TimeOutCallback)timeOutHandle;

- (id)initWithTimeout:(NSInteger)timeout timeOutHandle:(TimeOutCallback)timeOutHandle handleTimeBlock:(TimeOutHandleTimeCallback)handleTimeBlock;

@end
