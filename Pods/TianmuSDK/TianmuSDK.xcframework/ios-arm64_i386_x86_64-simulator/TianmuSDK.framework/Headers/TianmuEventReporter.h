//
//  TianmuEventReporter.h
//  TianmuSDK
//
//  Created by Erik on 2021/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * TianmuSDKReportStatus NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT TianmuSDKReportStatus _Nonnull const TianmuSDKReportStatusRequest;

FOUNDATION_EXPORT TianmuSDKReportStatus _Nonnull const TianmuSDKReportStatusSuccess;

FOUNDATION_EXPORT TianmuSDKReportStatus _Nonnull const TianmuSDKReportStatusDisplay;

FOUNDATION_EXPORT TianmuSDKReportStatus _Nonnull const TianmuSDKReportStatusClick;

FOUNDATION_EXPORT TianmuSDKReportStatus _Nonnull const TianmuSDKReportStatusClose;

FOUNDATION_EXPORT TianmuSDKReportStatus _Nonnull const TianmuSDKReportStatusFailed;

FOUNDATION_EXPORT TianmuSDKReportStatus _Nonnull const TianmuSDKReportStatusRewarded;

@interface TianmuReportMark : NSObject

@property (nonatomic, assign) BOOL requestReported;
@property (nonatomic, assign) BOOL successReported;
@property (nonatomic, assign) BOOL failureReported;
@property (nonatomic, assign) BOOL displayReported;
@property (nonatomic, assign) BOOL clickReported;
@property (nonatomic, assign) BOOL closeReported;
@property (nonatomic, assign) BOOL rewardReported;

- (void)refreshStatus;
@end

@interface TianmuEventReporter : NSObject


- (instancetype)initWithAdSourceId:(NSString *)adSourceId;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

/// 广告位id
@property (nonatomic, copy) NSString *adPositionId;

/**
 广告位上报
 */

- (void)sendAdPositionRequestReportWithPosId:(NSString *)posId count:(NSInteger)number;

/**
 广告源上报
 */

- (void)sendRequestWithMark:(TianmuReportMark *)mark;

- (void)sendRequestReport;

- (void)sendRequestReportWithCount:(NSInteger)count;

- (void)sendSucceedWithMark:(TianmuReportMark *)mark;

- (void)sendSucceedReport;

- (void)sendSucceedReportWithCount:(NSInteger)count;

- (void)sendFailWithMark:(TianmuReportMark *)mark;

- (void)sendFailReport;

- (void)sendFailReportWithCount:(NSInteger)count;

- (void)sendDisplayWithMark:(TianmuReportMark *)mark;

- (void)sendDisplayReport;

- (void)sendDisplayReportWithCount:(NSInteger)count;

- (void)sendClickWithMark:(TianmuReportMark *)mark;

- (void)sendClickReport;


- (void)sendRewardWithMark:(TianmuReportMark *)mark;

- (void)sendRewardReport;

- (void)sendCloseWithMark:(TianmuReportMark *)mark;

- (void)sendCloseReport;


@end

NS_ASSUME_NONNULL_END
