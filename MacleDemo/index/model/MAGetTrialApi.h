//
//  MAGetTrialApi.h
//  MacleDemo
//
//  Created by Macle
//

#import <YTKNetwork/YTKNetwork.h>
#import "MAMinipInfoModel.h"
#import "FecMAMinipInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
   Here is a model definition class, here we provide the definition of MAGetTrialModel, whose function is to provide some function of getting the trial version of mini app , in which might be related to some request to host app server.
   And the host app server need implement "miniprogram/experience/query" path in their interface.
 */
@interface MAGetTrialModel : NSObject

@property(nonatomic, copy) NSString *resultCode;
@property(nonatomic, copy) NSString *resultMsg;
@property(nonatomic, copy) NSString *resultType;
@property(nonatomic, strong) MAMinipInfoModel *app_info;

@end


@interface FecMAGetTrialModel : NSObject

@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, strong) FecMAMinipInfoModel *data;

@end


typedef void(^MAGetTrialSuccess)(MAMinipInfoModel * _Nullable trialModel);
typedef void(^MAGetTrialFailure)(NSError *error);


@interface MAGetTrialApi : YTKRequest

- (void)getTrialWithAppId:(NSString *)appId
                  version:(NSString *)version
                     sign:(NSString *)sign
                  success:(MAGetTrialSuccess)success
                  failure:(MAGetTrialFailure)failure ;

@end

NS_ASSUME_NONNULL_END
