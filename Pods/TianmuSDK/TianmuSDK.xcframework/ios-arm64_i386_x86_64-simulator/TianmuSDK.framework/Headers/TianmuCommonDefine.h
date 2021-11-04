//
//  TianmuCommonDefine.h
//  TianmuSDK
//
//  Created by Erik on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TianmuAdLayoutType) {
    TianmuAdLayoutTypeTopImage = 1, // 上图下文
    TianmuAdLayoutTypeBottomImage = 2, // 上文下图
    TianmuAdLayoutTypeLeftImage = 3, // 左图右文
    TianmuAdLayoutTypeRightImage = 4, // 左文右图
    TianmuAdLayoutTypeHorizonImage = 5, // 纯图
};

typedef NS_ENUM(NSUInteger, TianmuAdRenderType) {
    TianmuAdRenderTypeNative = 1, // 自渲染
    TianmuAdRenderTypeExpress = 2 // 模板
};

typedef NSString * TianmuAdType NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT TianmuAdType _Nonnull const TianmuAdTypeSplash;

FOUNDATION_EXPORT TianmuAdType _Nonnull const TianmuAdTypeBanner;

FOUNDATION_EXPORT TianmuAdType _Nonnull const TianmuAdTypeNative;

FOUNDATION_EXPORT TianmuAdType _Nonnull const TianmuAdTypeInterstitial;



NS_ASSUME_NONNULL_END
