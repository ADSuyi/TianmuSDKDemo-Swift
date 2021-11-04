//
//  ADSuyiCache.h
//  JASImageCache
//
//  Created by 陶冶明 on 2020/8/3.
//  Copyright © 2020 陶冶明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, ADSuyiWebImageSaveType) {
    ADSuyiWebImageSaveTypeDisk = 1 << 0,
    ADSuyiWebImageSaveTypeMem = 1 << 1,
};

@interface ADSuyiCache : NSObject

+ (instancetype)shared;

- (void)saveData:(NSData *)data key:(NSString *)key saveType:(ADSuyiWebImageSaveType)type;

- (nullable NSData *)readData:(NSString *)key;

- (void)loadImageWithUrlString:(NSString *)urlString
                       timeOut:(NSInteger)time
                   shouldCache:(BOOL)shouldCache
                 completeBlock:(void (^) (NSData *data))completeBlock
                   failedBlock:(void (^) (void))failedBlock;

@end

NS_ASSUME_NONNULL_END


