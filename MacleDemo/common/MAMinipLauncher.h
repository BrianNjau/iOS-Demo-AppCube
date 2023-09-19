//
//  MAMinipLauncher.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>

@class MAMinipInfoModel;

NS_ASSUME_NONNULL_BEGIN

/*!
 @header MAMinipLauncher in this class, we provide the sdk implementation.
 @abstract mini app laucher class
 */
@interface MAMinipLauncher : NSObject

@property(nonatomic, strong) MAMinipInfoModel *info;

+ (instancetype)defaultLauncher;

- (void)startAppWithUrl:(NSString *)appUrl isTrial:(BOOL)isTrial trialSign:(NSString * _Nullable)sign;

- (void)initSDKConfig;

@end

NS_ASSUME_NONNULL_END
