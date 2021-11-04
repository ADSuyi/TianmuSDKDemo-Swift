//
//  TianmuAdDataModel.h
//  TianmuSDK
//
//  Created by Erik on 2021/9/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TianmuLinkLoadType) {
    TianmuLinkLoadTypeInApp = 0, // app内打开
    TianmuLinkLoadTypeOutApp = 1, // app外打开
};

@interface TianmuTrackModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> *display;
@property (nonatomic, strong) NSArray<NSString *> *click;
@property (nonatomic, strong) NSArray<NSString *> *deeplink;
@property (nonatomic, strong) NSArray<NSString *> *downloadEnd;
@property (nonatomic, strong) NSArray<NSString *> *downloadStart;
@property (nonatomic, strong) NSArray<NSString *> *installStart;
@property (nonatomic, strong) NSArray<NSString *> *installEnd;
@property (nonatomic, strong) NSArray<NSString *> *open;

- (instancetype)initTrackerModelWithJson:(NSDictionary *)json NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

@interface TianmuAdDataModel : NSObject
// 广告标题文案
@property (nonatomic, copy) NSString *title;
// 广告描述文案
@property (nonatomic, copy) NSString *desc;
// 图片链接
@property (nonatomic, copy) NSString *imageUrl;
// 多图链接
@property (nonatomic, strong) NSArray<NSString *> *imageUrlList;
// deeplink地址(scheme跳转字段)
@property (nonatomic, copy) NSString *deeplinkUrl;
// 落地页地址
@property (nonatomic, copy) NSString *landingPageUrl;
// 监测上报
@property (nonatomic, strong) TianmuTrackModel *tracker;
// 广告类型用于区分是否是信息流素材：flow splash banner inyerstitial
@property (nonatomic, copy) NSString *adType;

@property (nonatomic, assign) CGSize adSize;

- (instancetype)initAdDataModelWithJson:(NSDictionary *)json NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
