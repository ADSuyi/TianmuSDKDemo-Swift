//
//  ADSuyiKitQueueUtils.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/6/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADSuyiKitQueueUtils : NSObject

#pragma mark - main queue

FOUNDATION_EXPORT void ADSuyiAutoAsyncMainBlock(void (^block) (void)) __attribute__((overloadable));

FOUNDATION_EXPORT void ADSuyiAsyncMainBlock(void (^block) (void)) __attribute__((overloadable));

FOUNDATION_EXPORT void ADSuyiDelayAsyncMainBlock(double second, void (^block) (void)) __attribute__((overloadable));

#pragma mark - global queue

FOUNDATION_EXPORT void ADSuyiAsyncGlobalBlock(void (^block) (void)) __attribute__((overloadable));

FOUNDATION_EXPORT void ADSuyiDelayAsyncGlobalBlock(double second, void (^block) (void)) __attribute__((overloadable));

#pragma mark - report global queue
FOUNDATION_EXPORT void ADSuyiReportAsyncGlobalBlock(void (^block) (void)) __attribute__((overloadable));

#pragma mark - imege load global queue
FOUNDATION_EXPORT void ADSuyiImageAsyncGlobalBlock(void (^block) (void)) __attribute__((overloadable));

@end

NS_ASSUME_NONNULL_END
