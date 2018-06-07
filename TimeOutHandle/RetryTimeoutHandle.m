//
//  RetryTimeoutHandle.m
//
//
//  Created by Flame Grace on 2018/1/24.
//  Copyright ©2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "RetryTimeoutHandle.h"
#import "TimeOutHandleCenter.h"

@interface RetryTimeoutHandle()

@property (readwrite, assign, nonatomic) NSInteger currentCount;
@property (assign,nonatomic) BOOL isStop;

@end

@implementation RetryTimeoutHandle

- (instancetype)init
{
    if(self = [super init])
    {
        self.isStop = YES;
        self.retryCount = 1;
        self.retryDuration = 5;
    }
    return self;
}

- (void)start
{
    @synchronized (self)
    {
        if(!self.isStop)
        {
            return;
        }
        self.isStop = NO;
        self.currentCount = 0;
        [self retry];
    }
}

- (void)retry
{
    if(self.isStop)
    {
        return;
    }
    if(self.currentCount >= self.retryCount && self.retryCount > 0)
    {
        [self stop];
        RetryVoidBlock failedBlock = self.failedBlock;
        if(failedBlock)
        {
            failedBlock();
        }
        return;
    }
    self.currentCount ++;
    __weak typeof(self) weakSelf = self;
    [[TimeOutHandleCenter defaultCenter]registerHandleWithIdentifier:[NSString stringWithFormat:@"%@_%p",NSStringFromClass([self class]),self] timeOut:self.retryDuration timeOutCallback:^(TimeoutHandle *handle) {
        __strong typeof(weakSelf) self = weakSelf;
        [self retry];
    }];
    RetryVoidBlock retryBlock = self.retryBlock;
    if(retryBlock)
    {
        retryBlock();
    }
}

- (void)stop
{
    self.isStop = YES;
    [[TimeOutHandleCenter defaultCenter]removeHandleByIdentifier:[NSString stringWithFormat:@"%@_%p",NSStringFromClass([self class]),self]];
    self.currentCount = 0;
    RetryVoidBlock stopBlock = self.stopBlock;
    if(stopBlock)
    {
        stopBlock();
    }
}

- (void)dealloc
{
    [self stop];
}

- (void)setRetryCount:(NSInteger)retryCount
{
    if(retryCount <= 0)
    {
        retryCount = 0;
    }
    _retryCount = retryCount;
}

- (void)setRetryDuration:(NSTimeInterval)retryDuration
{
    if(retryDuration <= 0)
    {
        retryDuration = 0;
    }
    _retryDuration = retryDuration;
}

@end

