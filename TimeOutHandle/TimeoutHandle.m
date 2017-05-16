//
//
//  Created by Flame Grace on 16/10/20.
//  Copyright © 2016年 . All rights reserved.
//

#import "TimeoutHandle.h"

@interface TimeoutHandle()


@property (strong, nonatomic) NSTimer *timeOutTimer;
@property (assign, nonatomic) NSTimeInterval startTime;
@property (readwrite, assign, nonatomic) BOOL isValid;

@end

@implementation TimeoutHandle


- (id)initWithTimeout:(NSInteger)timeout timeOutHandle:(TimeOutCallback)timeOutHandle
{
    if(self = [super init])
    {
        self.timeout = timeout;
        self.timeOutHandle = timeOutHandle;
    }
    return self;
}

//设置
- (void)setTimeout:(NSInteger)timeout
{
    if(_timeout == timeout)return;
    _timeout = timeout;
}

//开始超时计时器
- (void)startTimer
{
    [self endTimer];
    self.startTime = [[NSDate date]timeIntervalSince1970];
    self.timeOutTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(handleTimer) userInfo:self repeats:YES];
    [self.timeOutTimer fire];
    
}
//停止计时器
- (void)endTimer
{
    [self.timeOutTimer invalidate];
    self.timeOutTimer = nil;
    self.startTime = 0;
}

//计时器回调方法
- (void)handleTimer
{
    
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    if(now - self.startTime >= self.timeout)
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
