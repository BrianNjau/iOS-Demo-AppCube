//
//  MAGetTrialApi.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAGetTrialApi.h"
#import <YYModel/YYModel.h>


@implementation MAGetTrialModel

@end


@implementation FecMAGetTrialModel

@end


@interface MAGetTrialApi ()

@property(nonatomic, copy)NSString *appId;
@property(nonatomic, copy)NSString *version;
@property(nonatomic, copy)NSString *sign;

@end


@implementation MAGetTrialApi

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)getTrialWithAppId:(NSString *)appId
                  version:(NSString *)version
                     sign:(NSString *)sign
                  success:(MAGetTrialSuccess)success
                  failure:(MAGetTrialFailure)failure {
    if (self.isExecuting) {
        return;
    }
    self.appId = appId;
    self.version = version;
    self.sign = sign;
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        MAMinipInfoModel *minips;
        if (request.responseJSONObject) {
            NSDictionary * dict = request.responseJSONObject;
            if (dict[@"message"]) {
                failure([NSError errorWithDomain:@"999" code:@"999" userInfo:@{NSLocalizedDescriptionKey:dict[@"message"]?:@""}]);
            }
            MAGetTrialModel *trialModel = [MAGetTrialModel yy_modelWithJSON:request.responseJSONObject];
            minips = trialModel.app_info;
            if (minips) {
                success(minips);
            } else {
                failure([NSError errorWithDomain:@"999" code:@"999" userInfo:@{NSLocalizedDescriptionKey:@"get trial mini app fail"}]);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (!failure) {
            return;
        }
        if ([request.responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *resultCode = [request.responseObject objectForKey:@"resultCode"];
            NSString *resultMsg = [request.responseObject objectForKey:@"resultMsg"];
            if ([resultCode isEqualToString:@"invalid.cert.identity"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DEV_NTK];
                [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:DEV_NTK_TIME];
                [[NSUserDefaults standardUserDefaults] synchronize];
                failure([NSError errorWithDomain:resultCode code:request.error.code userInfo:@{NSLocalizedDescriptionKey:resultMsg?:@""}]);
            }else {
                failure([NSError errorWithDomain:resultCode?:@"" code:request.error.code userInfo:@{NSLocalizedDescriptionKey:resultMsg?:@""}]);
            }
        }else {
            failure(request.error);
        }
    }];
}

- (NSString *)requestUrl {
    NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:DEV_TRIAL_URL];
    return url.length?url:@"http://localhost:8080/api/v2/miniprogram/experience/query";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"mappId": self.appId ? self.appId : @"",
        @"version": self.version ? self.version : @"",
        @"sign": self.sign ?: @""
    };
}

- (NSInteger)cacheTimeInSeconds {
    return 0;
}

- (BOOL)ignoreCache {
    return YES;
}

- (NSTimeInterval)requestTimeoutInterval {
    return 5;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSString *ntk = [[NSUserDefaults standardUserDefaults] objectForKey:DEV_NTK];
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:FEC_GREEN_CLOUD_TOKEN_NAME];
    
    return @{
            @"Content-Type": @"application/json",
            FEC_GREEN_CLOUD_TOKEN_NAME: access_token ?: @"",
            @"third-party-id": [[NSUserDefaults standardUserDefaults] objectForKey:THIRD_PARRT_ID]
        };
}

@end
