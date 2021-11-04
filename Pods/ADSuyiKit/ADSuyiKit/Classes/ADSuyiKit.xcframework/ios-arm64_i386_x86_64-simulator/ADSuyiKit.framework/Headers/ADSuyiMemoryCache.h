/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <UIKit/UIKit.h>

@class ADSuyiImageCacheConfig;

@interface ADSuyiMemoryCache <KeyType, ObjectType> : NSCache <KeyType, ObjectType>

@property (nonatomic, strong, nonnull, readonly) ADSuyiImageCacheConfig *config;

- (nonnull instancetype)initWithConfig:(nonnull ADSuyiImageCacheConfig *)config;

- (nullable id)objectForKey:(nonnull id)key;

- (void)setObject:(nullable id)object forKey:(nonnull id)key;

- (void)setObject:(nullable id)object forKey:(nonnull id)key cost:(NSUInteger)cost;

- (void)removeObjectForKey:(nonnull id)key;

- (void)removeAllObjects;

@end
