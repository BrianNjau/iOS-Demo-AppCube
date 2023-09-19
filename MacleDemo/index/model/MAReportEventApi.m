//
//  MAReportEventApi.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAReportEventApi.h"
#import <YYModel/YYModel.h>

@interface MAReportEventApi ()
@property (nonatomic, strong) MARsDeviceInfo *deviceInfo;
@property (nonatomic, strong) NSArray<MARsPerformanceData *> *data;
@end


@implementation MAReportEventApi
- (instancetype)initWithDeviceInfo: (MARsDeviceInfo *)info {
    if (self = [super init]) {
        _deviceInfo = info;
    }
    return self;
}

- (void)reportEvent:(NSArray<MARsPerformanceData *> *)data {
    self.data = data;

    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"event report success!");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"event report failed with: %@", [request.error localizedDescription]);
    }];
}

- (NSString *)requestUrl {
    NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:EVENT_REPORT_URL];
    return url.length?url:@"https://his.macle.inhuawei.com/api/v1/miniprogram/report/performance";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    NSDateFormatter *formatter = [NSDateFormatter new];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    NSString *formateTime = [formatter stringFromDate:date];
    
    return @{
        @"report_id" : [NSString stringWithFormat:@"%lu%@", (unsigned long)[self hash], timeString],
        @"report_time" : formateTime,
        @"device_info" : [self.deviceInfo yy_modelToJSONObject],
        @"data" : [self.data yy_modelToJSONObject]
    };
}

- (NSString *)getDateStringWithTimeStr:(NSString *)str {
    NSTimeInterval time = [str doubleValue] / 1000;
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detailDate];
    return currentDateStr;
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
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:PAGE_QUERY_AUTH];
    return @{
        @"Content-Type":@"application/json",
        @"nirvana-authorization":auth.length?auth: @"nirvana-auth-v1/1ab48688fe948cd96692a6b797ace710457532/2021-06-11T11:23:58.534Z/31536000//n8GKLbc3gSH5W3/+dHjMdVH/nF2x99tXdfwMHZ+40mw=",
    };
}

@end

@implementation MARsDeviceInfo

@end

@implementation MARsNetWorkInfo

@end

@implementation MARsMiniApp

@end

@implementation MARsPerformanceEvent

@end

@implementation MARsPerformanceData

@end
