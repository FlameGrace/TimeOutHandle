//
//  RetryTimeoutHandle.h
//
//
//  Created by Flame Grace on 2018/1/24.
//  Copyright ©2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^RetryVoidBlock)(void);

@interface RetryTimeoutHandle : NSObject

@property (assign, nonatomic) NSTimeInterval retryDuration;

@property (copy, nonatomic) RetryVoidBlock failedBlock;
@property (copy, nonatomic) RetryVoidBlock retryBlock;
@property (copy, nonatomic) RetryVoidBlock stopBlock;
/**
 重试次数，如果设置为0，则一直重试
 */
@property (assign, nonatomic) NSInteger retryCount;

/**
 current retry count
 */
@property (readonly, assign, nonatomic) NSInteger currentCount;

- (void)start;

- (void)stop;

@end
