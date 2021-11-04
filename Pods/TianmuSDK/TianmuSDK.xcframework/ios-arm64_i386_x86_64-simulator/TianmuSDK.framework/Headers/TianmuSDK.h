//
//  TianmuSDK.h
//  TianmuSDK
//
//  Created by Erik on 2021/9/11.
//

#import <Foundation/Foundation.h>
#import <TianmuSDK/TianmuSplashAd.h>
#import <TianmuSDK/TianmuBannerAdView.h>
#import <TianmuSDK/TianmuInterstitialAd.h>
#import <TianmuSDK/TianmuNativeExpressAd.h>
#import <TianmuSDK/TianmuExpressViewRegisterProtocol.h>
#import <TianmuSDK/TianmuNativeExpressView.h>

NS_ASSUME_NONNULL_BEGIN

@interface TianmuSDK : NSObject

/**
初始化SDK
@param appId 给定的唯一appid
@param completion 启动完成回调
*/
+ (void)initWithAppId:(NSString *)appId completionBlock:(nullable void(^)(NSError *_Nullable error))completion;

/**
 获取SDK版本号
 */
+ (NSString *)getSDKVersion;

/**
 是否允许SDK采集设备信息（网络信息等） ，默认开启，如需关闭需在初始化之前设置(开启并不会影响审核)
 */
@property (nonatomic, assign, class) BOOL enablePersonalInformation;

@end

NS_ASSUME_NONNULL_END
