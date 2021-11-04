//
//  TianmuBannderAdView.h
//  TianmuSDK
//
//  Created by 陈则富 on 2021/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TianmuBannerAdView;

@protocol TianmuBannerAdViewDelegate <NSObject>

@optional
/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)tianmuBannerSuccessLoad:(TianmuBannerAdView *)tianmuBannerView;

/**
 *  请求广告条数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)tianmuBannerViewFailedToLoadWithError:(NSError *)error;

/**
 *  曝光回调
 */
- (void)tianmuBannerViewWillExpose:(TianmuBannerAdView *)tianmuBannerView;

/**
 *  点击回调
 */
- (void)tianmuBannerViewClicked:(TianmuBannerAdView *)tianmuBannerView;

/**
 *  被用户关闭时调用
 */
- (void)tianmuBannerViewWillClose:(TianmuBannerAdView *)tianmuBannerView;


@end

@interface TianmuBannerAdView : UIView

/**
 *  委托 
 */
@property (nonatomic ,weak) id<TianmuBannerAdViewDelegate>  delegate;

/*
 详解：当前ViewController[必传]
 */
@property (nonatomic ,weak) UIViewController  *viewController;

/**
 *  构造方法
 *  详解：frame - banner 展示的位置和大小
 *       postId - 广告位 ID
 */
- (instancetype)initWithFrame:(CGRect)frame posId:(NSString *)posId;

/**
 *  开始请求广告
 */
- (void)loadRequest;


@end

NS_ASSUME_NONNULL_END
