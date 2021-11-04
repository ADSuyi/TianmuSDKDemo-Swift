/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ADSuyiImageCacheConfigExpireType) {
    ADSuyiImageCacheConfigExpireTypeAccessDate,
    ADSuyiImageCacheConfigExpireTypeModificationDate,
    ADSuyiImageCacheConfigExpireTypeCreationDate,
    ADSuyiImageCacheConfigExpireTypeChangeDate,
};

@interface ADSuyiImageCacheConfig : NSObject <NSCopying>

@property (nonatomic, class, readonly, nonnull) ADSuyiImageCacheConfig *defaultCacheConfig;

@property (assign, nonatomic) BOOL shouldDisableiCloud;

@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;

@property (assign, nonatomic) BOOL shouldUseWeakMemoryCache;

@property (assign, nonatomic) BOOL shouldRemoveExpiredDataWhenEnterBackground;

@property (assign, nonatomic) NSDataReadingOptions diskCacheReadingOptions;

@property (assign, nonatomic) NSDataWritingOptions diskCacheWritingOptions;

@property (assign, nonatomic) NSTimeInterval maxDiskAge;

@property (assign, nonatomic) NSUInteger maxDiskSize;

@property (assign, nonatomic) NSUInteger maxMemoryCost;

@property (assign, nonatomic) NSUInteger maxMemoryCount;

@property (assign, nonatomic) ADSuyiImageCacheConfigExpireType diskCacheExpireType;

@property (strong, nonatomic, nullable) NSFileManager *fileManager;

@property (assign, nonatomic, nonnull) Class memoryCacheClass;

@property (assign ,nonatomic, nonnull) Class diskCacheClass;

@end
