//
//  TianmuSplashSkipViewProtocol.h
//  TianmuSDK
//
//  Created by 陈则富 on 2021/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TianmuSplashSkipViewProtocol <NSObject>

@required
/**
当前按钮时间回调用，建议单纯用来展示（不建议用此数值做任何逻辑判断）
*/
- (void)setLifeTime:(NSInteger)lifeTime;

@end

NS_ASSUME_NONNULL_END
