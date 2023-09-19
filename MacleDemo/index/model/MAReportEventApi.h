//
//  MAReportEventApi.h
//  MacleDemo
//
//  Created by Macle
//

#import <YTKNetwork/YTKRequest.h>

NS_ASSUME_NONNULL_BEGIN

/**
   Here is a model definition class, here we provide the definition of MAReportEventApi, whose function is to report some performance function of Macle mini app.
 */
@interface MARsDeviceInfo : NSObject
@property (nonatomic, copy) NSString *device_name;
@property (nonatomic, copy) NSString *device_model;
@property (nonatomic, copy) NSString *device_brand;
@property (nonatomic, copy) NSString *system;
@end

@interface MARsNetWorkInfo : NSObject
@property (nonatomic, copy) NSString *network_type;
@end

@interface MARsMiniApp : NSObject
@property (nonatomic, copy) NSString *mini_app_id;
@property (nonatomic, copy) NSString *mini_app_name;
@property (nonatomic, copy) NSString *mini_app_version;
@property (nonatomic, copy) NSString *mini_app_uuid;
@end

@interface MARsPerformanceEvent : NSObject
@property (nonatomic, copy) NSString *event_id;
@property (nonatomic, copy) NSString *event_occur_time;
@property (nonatomic, copy) NSString *event_end_time;
@property (nonatomic, copy) NSString *path_name;
@property (nonatomic, assign) NSInteger cost_time;
@property (nonatomic, copy) NSString *customize_dimensions;
@property (nonatomic, copy) NSString *event_session;
@end

@interface MARsPerformanceData : NSObject
@property (nonatomic, strong) MARsNetWorkInfo *network_info;
@property (nonatomic, strong) MARsMiniApp *mini_app;
@property (nonatomic, strong) NSMutableArray<MARsPerformanceEvent *> *event_properties;
@end


@interface MAReportEventApi : YTKRequest
- (instancetype)initWithDeviceInfo: (MARsDeviceInfo *)info;

- (void)reportEvent: (NSArray<MARsPerformanceData *> *) data;
@end

NS_ASSUME_NONNULL_END
