//
//  TianmuInterstitialAd.h
//  TianmuSDK
//
//  Created by 陈则富 on 2021/9/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TianmuInterstitialAd;

@protocol TianmuInterstitialAdDelegate <NSObject>

@optional

/**
 *  插屏广告数据请求成功
 */
- (void)tianmuInterstitialSuccessToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告数据请求失败
 */
- (void)tianmuInterstitialFailToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error;

/**
 *  插屏广告渲染成功
 *  建议在此回调后展示广告
 */
- (void)tianmuInterstitialRenderSuccess:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告视图展示成功回调
 *  插屏广告展示成功回调该函数
 */
- (void)tianmuInterstitialDidPresentScreen:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告视图展示失败回调
 *  插屏广告展示失败回调该函数
 */
- (void)tianmuInterstitialFailToPresent:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error;

/**
 *  插屏广告曝光回调
 */
- (void)tianmuInterstitialWillExposure:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告点击回调
 */
- (void)tianmuInterstitialClicked:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告页关闭
 */
- (void)tianmuInterstitialAdDidDismissClose:(TianmuInterstitialAd *)unifiedInterstitial;

@end

@interface TianmuInterstitialAd : NSObject

/**
 委托对象
 */
@property (nonatomic ,weak) id<TianmuInterstitialAdDelegate>  delegate;

/**
 详解：当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 请求超时时间,默认为4s,需要设置3s及以上
 */
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 加载广告数据
*/
- (void)loadAdData;

/**
 展示广告
*/
- (void)showFromRootViewController:(UIViewController *)viewController;


@end

NS_ASSUME_NONNULL_END
