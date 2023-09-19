//
//  MAEventReporManager.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Here is the common utls class, in this class we provide the MAEventReporManager functions.
 */
@interface MAEventReporManager : NSObject
+ (instancetype)sharedInstance;

- (void)reportEvent: (NSString *)appId eventName:(NSString *)eventName eventParam:(NSDictionary *)eventParam;
@end

NS_ASSUME_NONNULL_END
