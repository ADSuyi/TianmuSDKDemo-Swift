//
//  TianmuExpressViewReigsterProtocol.h
//  TianmuSDK
//
//  Created by 陈则富 on 2021/9/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TianmuExpressViewRegisterProtocol <NSObject>
/**
 注册广告视图（必须调用的方法），不调用将无法渲染广告
 */
- (void)tianmu_registViews:(NSArray<UIView *> *)clickViews;


@end

NS_ASSUME_NONNULL_END
