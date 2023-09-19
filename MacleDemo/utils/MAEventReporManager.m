//
//  MAEventReporManager.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAEventReporManager.h"
#import "MAReportEventApi.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AFNetworking/AFNetworking.h>

static NSString *const EVENTNAME_HOMEPAGEFIRSTLOADED = @"homepageFirstLoaded";
static NSString *const EVENTNAME_STARTMINIAPP = @"startMiniApp";
static NSString *const EVENTNAME_HOMEPAGEFIRSTSTARTRENDER = @"homepageFirstStartRender";
static NSString *const EVENTNAME_HOMEPAGEFIRSTFINISHRENDER = @"homepageFirstFinishRender";
static NSString *const EVENTNAME_PAGEFINISHLOAD = @"pageFinishLoad";
static NSString *const EVENTNAME_PAGESTARTRENDER = @"pageStartRender";
static NSString *const EVENTNAME_PAGEFINISHRENDER = @"pageFinishRender";
static NSString *const EVENTNAME_CLICKMINIAPP = @"clickMiniApp";
static NSString *const EVENTNAME_STARTDOWNLOADPACK = @"startDownloadPack";
static NSString *const EVENTNAME_FINISHDOWNLOADPACK = @"finishDownloadPack";
static NSString *const EVENTNAME_MINIAPPLOADED = @"miniAppLoaded";

@interface MAEventReporManager ()
@property (nonatomic, strong) NSMutableDictionary *eventDic;
@property (nonatomic, strong) MAReportEventApi *reportApi;
@end

@implementation MAEventReporManager
+ (instancetype)sharedInstance {
    static MAEventReporManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[MAEventReporManager alloc] initPrivate];
    });
    
    return shared;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"singleton" reason:@"Use + [MAEventReporManager sharedInstance]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        self.eventDic = [[NSMutableDictionary alloc] init];
        
        self.reportApi = [[MAReportEventApi alloc] initWithDeviceInfo: [self getDeviceInfo]];
    }
    return self;
}

- (MARsDeviceInfo *)getDeviceInfo {
    struct utsname systemInfo;

    uname(&systemInfo);

    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

    NSDictionary *devices = @{@"iPhone1,2" : @"iPhone 3G", @"iPhone2,1" : @"iPhone 3GS", @"iPhone3,1" : @"iPhone 4", @"iPhone1,1" : @"iPhone 2G", @"iPhone3,2" : @"iPhone 4", @"iPhone3,3" : @"iPhone 4", @"iPhone4,1" : @"iPhone 4S", @"iPhone5,1" : @"iPhone 5", @"iPhone5,2" : @"iPhone 5", @"iPhone5,3" : @"iPhone 5c", @"iPhone5,4" : @"iPhone 5c", @"iPhone6,1" : @"iPhone 5s", @"iPhone6,2" : @"iPhone 5s", @"iPhone7,1" : @"iPhone 6 Plus", @"iPhone7,2" : @"iPhone 6", @"iPhone8,1" : @"iPhone 6s", @"iPhone8,2" : @"iPhone 6s Plus", @"iPhone8,4" : @"iPhone SE", @"iPhone9,1" : @"iPhone 7", @"iPhone9,2" : @"iPhone 7 Plus", @"iPod1,1" : @"iPod Touch 1G", @"iPod2,1" : @"iPod Touch 2G", @"iPod3,1" : @"iPod Touch 3G", @"iPod4,1" : @"iPod Touch 4G", @"iPod5,1" : @"iPod Touch 5G", @"iPad1,1" : @"iPad 1G", @"iPad2,1" : @"iPad 2", @"iPad2,2" : @"iPad 2", @"iPad2,3" : @"iPad 2", @"iPad2,4" : @"iPad 2", @"iPad2,5" : @"iPad Mini 1G", @"iPad2,6" : @"iPad Mini 1G", @"iPad2,7" : @"iPad Mini 1G", @"iPad3,1" : @"iPad 3", @"iPad3,2" : @"iPad 3", @"iPad3,3" : @"iPad 3", @"iPad3,4" : @"iPad 4", @"iPad3,5" : @"iPad 4", @"iPad3,6" : @"iPad 4", @"iPad4,1" : @"iPad Air", @"iPad4,2" : @"iPad Air", @"iPad4,3" : @"iPad Air", @"iPad4,4" : @"iPad Mini 2G", @"iPad4,5" : @"iPad Mini 2G", @"iPad4,6" : @"iPad Mini 2G", @"i386" : @"iPhone Simulator", @"x86_64" : @"iPhone Simulator", @"iPhone10,1": @"iPhone8",@"iPhone10,4": @"iPhone8", @"iPhone10,2": @"iPhone 8 Plus", @"iPhone10,5": @"iPhone 8 Plus", @"iPhone10,3": @"iPhone X", @"iPhone10,6": @"iPhone X", @"iPhone11,8": @"iPhone XR", @"iPhone11,2": @"iPhone XS", @"iPhone11,6": @"iPhone XS Max", @"iPhone12,1":@"iPhone 11", @"iPhone12,3":@"iPhone 11 Pro", @"iPhone12,5": @"iPhone 11 Pro Max", @"iPhone12,8": @"iPhone SE (2nd generation)", @"iPhone13,1": @"iPhone 12 mini", @"iPhone13,2": @"iPhone 12", @"iPhone13,3": @"iPhone 12 Pro", @"iPhone13,4": @"iPhone 12 Pro Max"};

    NSString *deviceType = devices[deviceModel];
    if (!deviceType) {
        // default string
        deviceType = @"iOS Device";
    }
    
    MARsDeviceInfo *info = [[MARsDeviceInfo alloc] init];
    [info setDevice_name:deviceType];
    [info setDevice_model:deviceModel];
    [info setDevice_brand:@"Apple"];
    [info setSystem:@"IOS"];
    
    return info;
}

/*
 eventName value：
 homepageFirstLoaded Home page loaded
 startMiniApp mini app begin start
 homepageFirstStartRender  page load start first time
 homepageFirstFinishRender  page load complete first time
 pageFinishLoad  page load complete
 pageStartRender page render begin
 pageFinishRender page render complete
 clickMiniApp user click mini app logo
 startDownloadPack  mini app start download
 finishDownloadPack mini app download complete
 miniAppLoaded mini app start complete
 
 eventParam structure：
    path: page path
    timestamp: event happening time
    appName:mini app name
    appVersion: mini app version
 */
- (void)reportEvent: (NSString *)appId eventName:(NSString *)eventName eventParam:(NSDictionary *)eventParam {
    NSLog(@"report event: %@, eventParam: %@, appId:%@", eventName, eventParam, appId);
    
    if ([eventName isEqualToString:EVENTNAME_HOMEPAGEFIRSTFINISHRENDER]) {
        //After receiving the homepageFirstFinishRender event, start calculating and reporting startup indicators
        NSMutableArray<MARsPerformanceData *> *array = [NSMutableArray new];
        MARsPerformanceData *data = [MARsPerformanceData new];
        [array addObject:data];
        
        NSMutableArray<MARsPerformanceEvent *> *events = [NSMutableArray new];
        [data setEvent_properties:events];
        MARsNetWorkInfo *network = [MARsNetWorkInfo new];
        [network setNetwork_type:[self getNetconnType]];
        [data setNetwork_info:network];
        
        //Obtain the cached data reported by the applet
        NSMutableDictionary *dic = self.eventDic[appId];
        
        //Calculate the total startup time appLaunch = homepageFirstFinishRender - clickMiniApp
        MARsPerformanceEvent *launchEvent = [MARsPerformanceEvent new];
        //This report is the finishrender event, the data has not been cached yet, use it directly
        NSDictionary *firstFinishRenderDic = eventParam;
        NSDictionary *clickMiniAppDic = dic[EVENTNAME_CLICKMINIAPP];
        
        MARsMiniApp *app = [MARsMiniApp new];
        [app setMini_app_id:appId];
        [app setMini_app_name:firstFinishRenderDic[@"appName"]];
        [app setMini_app_version:firstFinishRenderDic[@"appVersion"]];
        [data setMini_app:app];
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        long finishRenderTime = [firstFinishRenderDic[@"timestamp"] longValue];
        NSDate *finishRenderDate = [NSDate dateWithTimeIntervalSince1970:(double)finishRenderTime/1000];
        long clickAppTime = [clickMiniAppDic[@"timestamp"] longValue];
        NSDate *clickAppDate = [NSDate dateWithTimeIntervalSince1970:(double)clickAppTime/1000];
        
        [launchEvent setEvent_id:@"appLaunch"];
        [launchEvent setEvent_occur_time:[formatter stringFromDate:clickAppDate]];
        [launchEvent setEvent_end_time:[formatter stringFromDate:finishRenderDate]];
        [launchEvent setCost_time:finishRenderTime - clickAppTime];
        [launchEvent setPath_name:firstFinishRenderDic[@"path"]];
        [events addObject:launchEvent];
        
        //Calculate the download time of the code package downloadPackage = finishDownloadPack - startDownloadPack
        MARsPerformanceEvent *downloadEvent = [MARsPerformanceEvent new];
        NSDictionary *downloadBeginDic = dic[EVENTNAME_STARTDOWNLOADPACK];
        NSDictionary *downlaodEndDic = dic[EVENTNAME_FINISHDOWNLOADPACK];
        
        long downloadBeginTime = [downloadBeginDic[@"timestamp"] longValue];
        NSDate *downloadBeginDate = [NSDate dateWithTimeIntervalSince1970:(double)downloadBeginTime/1000];
        long downloadEndTime = [downlaodEndDic[@"timestamp"] longValue];
        NSDate *downloadEndDate = [NSDate dateWithTimeIntervalSince1970:(double)downloadEndTime/1000];
        [downloadEvent setEvent_id:@"downloadPackage"];
        [downloadEvent setEvent_occur_time:[formatter stringFromDate:downloadBeginDate]];
        [downloadEvent setEvent_end_time:[formatter stringFromDate:downloadEndDate]];
        [downloadEvent setCost_time:downloadEndTime - downloadBeginTime];
        [events addObject:downloadEvent];
        //After calculating the download time of the code package, delete the cached downloadBeginDic and downloadEndDic
        [dic removeObjectForKey:EVENTNAME_STARTDOWNLOADPACK];
        [dic removeObjectForKey:EVENTNAME_FINISHDOWNLOADPACK];
        
        //Calculate js injection time-consuming evaluateScript = homepageFirstLoaded -startMiniApp
        MARsPerformanceEvent *jsEvent = [MARsPerformanceEvent new];
        NSDictionary *firstLoadDic = dic[EVENTNAME_HOMEPAGEFIRSTLOADED];
        NSDictionary *startAppDic = dic[EVENTNAME_STARTMINIAPP];
        
        long firstLoadTime = [firstLoadDic[@"timestamp"] longValue];
        NSDate *firstLoadDate = [NSDate dateWithTimeIntervalSince1970:(double)firstLoadTime/1000];
        long startAppTime = [startAppDic[@"timestamp"] longValue];
        NSDate *startAppDate = [NSDate dateWithTimeIntervalSince1970:(double)startAppTime/1000];
        [jsEvent setEvent_id:@"evaluateScript"];
        [jsEvent setEvent_occur_time:[formatter stringFromDate:startAppDate]];
        [jsEvent setEvent_end_time:[formatter stringFromDate:firstLoadDate]];
        [jsEvent setCost_time:firstLoadTime - startAppTime];
        [events addObject:jsEvent];
        
        // Calculate the time spent on the first rendering of the home page firstRender =homepageFirstFinishRender -homepageFirstStartRender
        MARsPerformanceEvent *firstRenderEvent = [MARsPerformanceEvent new];
        NSDictionary *startRenderDic = dic[EVENTNAME_HOMEPAGEFIRSTSTARTRENDER];
        long startRenderTime = [startRenderDic[@"timestamp"] longValue];
        NSDate *startRenderDate = [NSDate dateWithTimeIntervalSince1970:(double)startRenderTime/1000];
        [firstRenderEvent setEvent_id:@"firstRender"];
        [firstRenderEvent setEvent_occur_time:[formatter stringFromDate:startRenderDate]];
        [firstRenderEvent setEvent_end_time:[formatter stringFromDate:finishRenderDate]];
        [firstRenderEvent setCost_time:finishRenderTime - startRenderTime];
        [events addObject:firstRenderEvent];
        
        // Calculation of pure startup timeappLaunchExDownload = appLaunch - downloadPackage
        MARsPerformanceEvent *pureLaunchEvent = [MARsPerformanceEvent new];
        [pureLaunchEvent setEvent_id:@"appLaunchExDownload"];
        [pureLaunchEvent setEvent_occur_time:[formatter stringFromDate:clickAppDate]];
        [pureLaunchEvent setCost_time: launchEvent.cost_time - downloadEvent.cost_time];
        [events addObject:pureLaunchEvent];
        
        [self.reportApi reportEvent:array];
    } else {
        // Cache the indicator first, and use it for subsequent calculations
        if ([[self.eventDic allKeys] containsObject:appId]) {
            NSMutableDictionary *dic = self.eventDic[appId];
            [dic setObject:eventParam forKey:eventName];
        }else {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setObject:eventParam forKey:eventName];
            [self.eventDic setObject:dic forKey:appId];
        }
    }
}

- (NSString *)getNetconnType{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    NSString *netconnType = @"";
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable: {
            netconnType = @"NotReachable";
        }
            break;
        case AFNetworkReachabilityStatusUnknown:
        {
            netconnType = @"Unknown";
        }
            break;

        case AFNetworkReachabilityStatusReachableViaWiFi:// Wifi
        {
            netconnType = @"Wifi";
        }
            break;

        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            // get cell phone network type
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];

            NSString *currentStatus = info.currentRadioAccessTechnology;

            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {

                netconnType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {

                netconnType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){

                netconnType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){

                netconnType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){

                netconnType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){

                netconnType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){

                netconnType = @"4G";
            }
        }
            break;

        default:
            break;
    }

    return netconnType;
}

@end
