//
//  AppDelegate.m
//  MacleDemo
//
//  Created by Macle
//

#import "AppDelegate.h"
#import "MARootVC.h"
#import "MAIndexVC.h"
#import "MABaseNavigationVC.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import <MacleKit/MacleKit.h>
#import <AFNetworking/AFNetworking.h>
#import "MARunningVC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //init network state
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
         case AFNetworkReachabilityStatusNotReachable:
                break;
         case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
         case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
         default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://127.0.0.1:8080";
    config.securityPolicy.allowInvalidCertificates = YES;
    config.securityPolicy.validatesDomainName = NO;
    NSLog(@"%@",[MacleClient sdkVerion]);
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MARootVC *rootVC = [[MARootVC alloc] init];
    MAIndexVC *indexVC = [[MAIndexVC alloc] init];
    MABaseNavigationVC *indexNaviVC = [[MABaseNavigationVC alloc] initWithRootViewController:indexVC];
    indexNaviVC.tabBarItem.title = @"front";
    indexNaviVC.tabBarItem.image = [UIImage imageNamed:@""];
    
    MARunningVC *runningVC = [[MARunningVC alloc] init];
    MABaseNavigationVC *runningNaviVC = [[MABaseNavigationVC alloc] initWithRootViewController:runningVC];
    runningNaviVC.tabBarItem.title = @"running";
    runningNaviVC.tabBarItem.image = [UIImage imageNamed:@""];
    
    rootVC.viewControllers = @[indexNaviVC,runningNaviVC];
    self.window.rootViewController = rootVC;

    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Orientation

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return [MacleClient supportOrientation];
}

@end
