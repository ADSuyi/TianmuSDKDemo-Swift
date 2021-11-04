//
//  TianmuNativeExpressView.h
//  TianmuSDK
//
//  Created by 陈则富 on 2021/9/15.
//

#import <UIKit/UIKit.h>
#import "TianmuAdDataModel.h"
#import "TianmuEventReporter.h"
#import "TianmuExpressViewRegisterProtocol.h"
#import "TianmuCommonDefine.h"


NS_ASSUME_NONNULL_BEGIN
@class TianmuNativeExpressView;
@protocol TianmuNativeExpressViewDelegate <NSObject>

- (void)tianmuExpressAdViewClose:(TianmuNativeExpressView *)expressAdView;
- (void)tianmuExpressAdViewRenderSucceed:(TianmuNativeExpressView *)expressAdView;
- (void)tianmuExpressAdViewRenderFail:(TianmuNativeExpressView *)expressAdView;

@end

@interface TianmuNativeExpressView : UIView<TianmuExpressViewRegisterProtocol>


- (instancetype)initWithAdData:(TianmuAdDataModel *)adData;


@property (nonatomic, assign) TianmuAdLayoutType adType;

@property (nonatomic, strong) TianmuReportMark *mark;

@property (nonatomic, strong) NSValue *insetsValue;

@property (nonatomic, assign) CGFloat adWidth;

@property (nonatomic, weak) id<TianmuNativeExpressViewDelegate> delegate;

@property (nonatomic, strong) TianmuAdDataModel *nativeAdData;


@end

NS_ASSUME_NONNULL_END
