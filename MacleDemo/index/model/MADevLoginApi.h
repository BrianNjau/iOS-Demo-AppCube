//
//  MADevLoginApi.h
//  MacleDemo
//
//  Created by Macle
//

#import <YTKNetwork/YTKNetwork.h>


@class UIViewController;

NS_ASSUME_NONNULL_BEGIN

typedef void(^MADevLoginSuccess)(NSString *auth_token);
typedef void(^MADevLoginFailure)(NSError *error);

/**
   Here is a model definition class, here we provide the definition of MADevLoginApi, whose function is to provide some function of scanning code to login or do other things,
 */
@interface MADevLoginApi : YTKRequest

+ (void)needLoginOnViewController:(UIViewController *)viewController withScanBlock:(void (^)(void))scanBlock;

@end

NS_ASSUME_NONNULL_END
