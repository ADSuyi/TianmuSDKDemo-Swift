//
//  TianmuSplashAd.h
//  TianmuSDK
//
//  Created by 陈则富 on 2021/9/16.
//

#import <UIKit/UIKit.h>
#import "TianmuSplashSkipViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class TianmuSplashAd;

@protocol TianmuSplashAdDelegate <NSObject>

@optional
/**
 *  开屏广告请求成功
 */
- (void)tianmuSplashAdSuccessLoad:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告素材加载成功
 */
- (void)tianmuSplashAdDidLoad:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告请求失败
 */
- (void)tianmuSplashAdFailLoad:(TianmuSplashAd *)splashAd withError:(NSError *)error;
/**
 *  开屏广告展示失败
 */
- (void)tianmuSplashAdRenderFaild:(TianmuSplashAd *)splashAd withError:(NSError *)error;

/**
 *  开屏广告曝光回调
 */
- (void)tianmuSplashAdExposured:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告点击回调
 */
- (void)tianmuSplashAdClicked:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告关闭回调
 */
- (void)tianmuSplashAdClosed:(TianmuSplashAd *)splashAd;

@end

@interface TianmuSplashAd : NSObject

/**
 *  委托
 */
@property (nonatomic ,weak) id<TianmuSplashAdDelegate>  delegate;

/**
 * 跳过按钮的类型，可以通过此接口替换开屏广告的跳过按钮样式
 */
@property (nonatomic, strong, null_resettable) UIView<TianmuSplashSkipViewProtocol> *skipView;

/**
 * 广告id
 */
@property (nonatomic ,copy) NSString  *posId;

/**
 * 不使用自带跳过视图
 */
@property (nonatomic, readwrite, assign) BOOL hiddenSkipView;

/**
开屏的默认背景色,或者启动页,为nil则代表透明
*/
@property (nonatomic, copy, nullable) UIColor *backgroundColor;

/**
加载开屏广告
如果全屏广告bottomView设置为nil
@param window 开屏广告展示的window
@param bottomView 底部logo视图, 高度不能超过屏幕的25%, 建议: 开屏的广告图片默认640 / 960比例, 可以用 MIN(screenHeight - screenWidth * (960 / 640.0), screenHeight * 0.25) 得出bottomview的高度
*/
- (void)loadAndShowInWindow:(UIWindow *)window withBottomView:(nullable UIView *)bottomView;


@end

NS_ASSUME_NONNULL_END
