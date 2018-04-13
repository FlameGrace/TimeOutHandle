//
//  TimeoutHandle.m
//
//  Created by Flame Grace on 16/10/20.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "TimeoutHandle.h"
#import "DispatchTimer.h"

@interface TimeoutHandle()

@property (strong, nonatomic) DispatchTimer *timer;
@property (assign, nonatomic) NSTimeInterval startTime;
@property (readwrite, assign, nonatomic) BOOL isValid;

@end

@implementation TimeoutHandle

- (instancetype)init
{
    if(self = [super init])
    {
        self.handlePeriod = 1;
    }
    return self;
}

- (id)initWithTimeout:(NSTimeInterval)timeout timeOutHandle:(TimeOutCallback)timeOutHandle
{
    return [self initWithTimeout:timeout timeOutHandle:timeOutHandle handlePeriod:0 handleTimeBlock:nil];
}


- (id)initWithTimeout:(NSTimeInterval)timeout timeOutHandle:(TimeOutCallback)timeOutHandle handlePeriod:(NSTimeInterval)handlePeriod handleTimeBlock:(TimeOutHandleTimeCallback)handleTimeBlock
{
    if(self = [super init])
    {
        self.handlePeriod = handlePeriod;
        self.timeout = timeout;
        self.timeOutHandle = timeOutHandle;
        self.handleTimeBlock = handleTimeBlock;
    }
    return self;
}



- (void)startTimer
{
    if((self.timeout >0 && self.timeout < 1) || self.handlePeriod > self.timeout)
    {
        self.handlePeriod = self.timeout;
    }
    
    [self endTimer];
    self.startTime = [[NSDate date]timeIntervalSince1970];
    __weak typeof(self) weakSelf = self;
    self.timer = [[DispatchTimer alloc]initWithDuration:self.handlePeriod handleBlock:^{
        [weakSelf handleTimer];
    }];
    [self.timer startTimer];
}

- (void)endTimer
{
    if(self.timer)
    {
        [self.timer endTimer];
        self.timer = nil;
        self.startTime = 0;
    }
}

- (void)setHandlePeriod:(NSTimeInterval)handlePeriod
{
    if(handlePeriod <= 0)
    {
        handlePeriod = 1;
    }
    _handlePeriod = handlePeriod;
}


//计时器回调方法
- (void)handleTimer
{
    
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    NSTimeInterval handleTime = now - self.startTime;
    if(self.handleTimeBlock)
    {
        self.handleTimeBlock(self, handleTime);
    }
    if(handleTime >= self.timeout)
    {
        [self endTimer];
        self.isValid = NO;
        if(self.timeOutHandle)self.timeOutHandle(self);
    }
}

//开始生效
- (void)valid
{
    if(self.timeout > 0 && self.timeOutHandle)
    {   self.isValid = YES;
        [self startTimer];
    }
}

//请求失效
- (void)invalidate
{
    [self endTimer];
    self.isValid = NO;
}
@end;
