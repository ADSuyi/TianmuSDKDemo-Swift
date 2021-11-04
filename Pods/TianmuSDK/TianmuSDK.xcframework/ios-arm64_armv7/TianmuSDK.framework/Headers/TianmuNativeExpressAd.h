//
//  TianmuNativeExpressAd.h
//  TianmuSDK
//
//  Created by 陈则富 on 2021/9/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class TianmuNativeExpressAd;
@class TianmuNativeExpressView;

@protocol TianmuNativeExpressAdDelegate<NSObject>

/**
 模板信息流广告加载成功
 */
- (void)tianmuExpressAdSucceedToLoad:(TianmuNativeExpressAd *)expressAd views:(NSArray<__kindof TianmuNativeExpressView *> *)views;

/**
 模板信息流广告加载失败
 */
- (void)tianmuExpressAdFailToLoad:(TianmuNativeExpressAd *)expressAd error:(NSError *)error;

/**
 模板信息流广告渲染成功
 */
- (void)tianmuExpressAdRenderSucceed:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;

/**
 模板信息流广告渲染失败
 */
- (void)tianmuExpressAdRenderFail:(TianmuNativeExpressView *)expressAd error:(NSError *)error;

/**
 模板信息流广告关闭
 */
- (void)tianmuExpressAdClosed:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;

/**
 模板信息流广告点击
 */
- (void)tianmuExpressAdClick:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;

/**
 模板信息流广告展示
 */
- (void)tianmuExpressAdDidExpourse:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;


@end

@interface TianmuNativeExpressAd : NSObject

/**
 *  委托 [必须实现]
 */
@property (nonatomic ,weak) id<TianmuNativeExpressAdDelegate>  delegate;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;


/**
 请求超时时间,默认为4s,需要设置3s及以上
*/
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 一般为当前展示广告控制器
*/
@property (nonatomic, weak) UIViewController *controller;


/**
 初始化广告加载器，需传入需要广告尺寸(一般按照16：9比例返回广告视图）
 */
- (instancetype)initWithAdSize:(CGSize)adSize NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

/**
 加载广告

 @param count 拉取几条广告,建议区间 1~4, 超过可能无法拉取到
 */
- (void)loadAdWithCount:(int)count;

@end

NS_ASSUME_NONNULL_END
