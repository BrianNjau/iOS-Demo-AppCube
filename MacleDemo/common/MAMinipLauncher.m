//
//  MAMinipLauncher.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAMinipLauncher.h"
#import <UIKit/UIKit.h>
#import "MACustomMenuItem.h"
#import "MACustomRunningMenuItem.h"
#import <MacleKit/MacleKit.h>
#import "MARunningVC.h"
#import "MAMinipInfoModel.h"
#import "MAEventReporManager.h"
#import <MacleKit/MacleStyle.h>
#import <MacleKit/MacleAppInfo.h>
#import <MacleKit/MacleAuthorityScope.h>
#import <MacleKit/MacleAppConfig.h>
#import <MacleKit/MacleClient.h>
#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "MACustomDetailMenuItem.h"


@interface MAMinipLauncher () <MacleSdkDelegate, NSURLSessionDelegate>

@end


@implementation MAMinipLauncher

+ (instancetype)defaultLauncher {
    static MAMinipLauncher *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[MAMinipLauncher alloc] init];
    });
    return shared;
}

- (instancetype)init {
    if (self = [super init]) {
        // initialize macle sdk
        [self initSDKConfig];
        // Register Extended Rights
        [self sdkRegisterExternAuth];
        // Register extension API
        [self sdkRegisterExternApi];
    }
    return self;
}


#pragma mark - Initialize applet

/// Initialize SDK configuration
- (void)initSDKConfig {
    MacleAppConfig *appConfig = [[MacleAppConfig alloc] init];
    appConfig.maxRunningAppsNum = 10;
    appConfig.allowInvalidSSLCert = YES;
    appConfig.enableLog = NO;
    appConfig.enableLogReport = NO;
    /// the bellow service origin url is an example，you can replace it with your own configure.
    appConfig.serviceOrigin = @"http://7.213.211.48:7000";
    NSString * frameworkpath = [[NSBundle mainBundle] pathForResource:@"framework" ofType:@"zip"];
    appConfig.frameworkUrl = frameworkpath;
    appConfig.canBackToHome = YES;
    appConfig.showRating = YES;
    appConfig.needCheckWhiteList = NO;
    [MacleClient init:appConfig withDelegate:self];
}

// Register extended permissions through sdk
- (void)sdkRegisterExternAuth {
    MacleAuthorityScope *payAuth = [[MacleAuthorityScope alloc] initAuthWithId:@"Payment" name:@"payment authority" type:PERMISSION description:@"need get your payment authority"];
    [MacleClient registerPermissionScope:payAuth];
}

// Register extension API through sdk
- (void)sdkRegisterExternApi {
    // Register simulated memory warnings
    [MacleClient registerCustomApi:@"simulateMemoryWarning" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC, MacleApiReqCallback callback) {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app respondsToSelector:@selector(_performMemoryWarning)]) {
            [app performSelector:@selector(_performMemoryWarning)];
        }
    }];
    
    [MacleClient registerCustomApi:@"getAppLocale" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC, MacleApiReqCallback callback) {
        if (callback) {
            callback(0, @{@"language":@"zh"});
        }
    }];
    
    [MacleClient registerCustomApi:@"getMiniAppToken" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC, MacleApiReqCallback callback) {
        if (callback) {
            callback(0, @{@"token":@"123456789"});
        }
    }];
    
    // Register getPayToken api
    [MacleClient registerCustomApi:@"getPayToken" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC, MacleApiReqCallback callback) {
        if (callback) {
            callback(0, @{@"token":@"12345678"});
        }
    }];
    
    // Pull up the host app page to test
    [MacleClient registerCustomApi:@"startAppPage" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC, MacleApiReqCallback callback) {
        MARunningVC *runningVC = [MARunningVC new];
        [VC presentViewController:runningVC animated:YES completion:nil];
        if (callback) {
            callback(0, @{@"resultCode":@"12345678"});
        }
    }];
    
    // Register getKBZPayToken
    [MacleClient registerCustomApi:@"getKBZPayToken" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC,MacleApiReqCallback callback) {
        if (callback && [dataParam isKindOfClass:[NSDictionary class]]) {
            callback(0,@{@"token":@"c1e5d9d36ec25998df9819c53fbcca86"});
        }
    }];

    //register payment api
    [MacleClient registerCustomApi:@"startPay" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC,MacleApiReqCallback callback) {
        [MacleClient checkPermissionAuth:@"Payment" allowHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"please input pay password" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"cacle" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *userNameTextField = alertController.textFields.firstObject;
                NSLog(@"pay password：%@",userNameTextField.text);
                NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"macleTest",@"token",@"macleTest",@"tradeType",@"zh",@"lang",@1,@"resultCode", nil];
                if (callback) {
                    callback(0, dic);
                }
            }]];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"please input pay password";
                textField.secureTextEntry = YES;
            }];
            [VC presentViewController:alertController animated:YES completion:nil];
        } denyHandler:^{
            if (callback) {
                callback(-1, @{@"res": @"the user do not autuorize the payment"});
            }
        }];
    }];
    
    //注册getKbzBackendServerUrl
    [MacleClient registerCustomApi:@"getKbzBackendServerUrl" handler:^(id  _Nullable dataParam, UIViewController * _Nullable VC,MacleApiReqCallback callback) {
        NSString *jsServerUrl = [[NSUserDefaults standardUserDefaults] objectForKey:JS_SERVER_URL];
        if (callback) {
            callback(0, @{@"url": jsServerUrl?:@""});
        }
    }];
}

- (void)startAppWithUrl:(NSString *)appUrl isTrial:(BOOL)isTrial trialSign:(NSString *)sign {
    dispatch_async(dispatch_get_main_queue(), ^{
        MacleStyle *style = [MacleStyle new];
        style.menus = @[
            [MACustomDetailMenuItem new],
            [MACustomMenuItem new], [MACustomRunningMenuItem new], [MACustomRunningMenuItem new],
            [MACustomRunningMenuItem new], [MACustomRunningMenuItem new], [MACustomRunningMenuItem new],
            [MACustomMenuItem new], [MACustomRunningMenuItem new], [MACustomRunningMenuItem new],
            [MACustomMenuItem new], [MACustomRunningMenuItem new], [MACustomRunningMenuItem new],
            [MACustomRunningMenuItem new], [MACustomMenuItem new], [MACustomMenuItem new]];

        style.capsuleShow = YES;
        style.capsuleStyle.capsuleMenuIconImage = [UIImage imageNamed:@"menu"];
        style.capsuleStyle.capsuleCloseIconImage = [UIImage imageNamed:@"close"];
        
        MacleCapsuleStyle *lightStyle = [MacleCapsuleStyle new];
        lightStyle.capsuleMenuIconImage = [UIImage imageNamed:@"menu"];
        lightStyle.capsuleCloseIconImage = [UIImage imageNamed:@"close"];
        lightStyle.capsuleBorderColor = [UIColor systemGreenColor];
        lightStyle.capsuleBackgroundColor = [UIColor systemYellowColor];
        
        MacleCapsuleStyle *darkStyle = [MacleCapsuleStyle new];
        darkStyle.capsuleMenuIconImage = [UIImage imageNamed:@"scan"];
        darkStyle.capsuleCloseIconImage = [UIImage imageNamed:@"desktop"];
        darkStyle.capsuleBorderColor = [UIColor systemRedColor];
        darkStyle.capsuleBackgroundColor = [UIColor systemBlueColor];
        
        style.capsuleStyleMap = @{
            @"light": lightStyle,
            @"dark": darkStyle
        };
        
        MacleNaviStyle *naviStyle = [MacleNaviStyle new];
        naviStyle.naviBackImage = [UIImage imageNamed:@"scan"];
        style.naviStyle = naviStyle;
        
        // Get the set launchPage and whether to display the home button
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *launchPage = [userDefaults objectForKey:@"launchPage"];
        BOOL showHomeButton = [[userDefaults objectForKey:@"showHomeButton"] boolValue];
        NSDictionary *pageSetting = @{
            @"showHomeButton": @(showHomeButton)
        };
        
        MacleAppInfo *appInfo = [[MacleAppInfo alloc] initWithAppId:self.info.app_id appName:self.info.app_name appVersion:self.info.version instanceId:self.info.instance_id];
        appInfo.setAppDescription(self.info.app_desc).setAppLogoUrl(self.info.app_logo).setUserId(@"").setAppUrl(appUrl).setIsTrial(isTrial).setTrialSign(sign).setStyle(style).setLaunchPath(launchPage).setPageSetting(pageSetting);
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        [MacleClient startApplet:appInfo completion:^(BOOL success, NSString *msg) {
            NSLog(@"start applet %@，%@", success ? @"success" : @"fail", msg);
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            if (success) {
                NSDictionary *historyApps = [userDefaults objectForKey:@"historyApps"] ?: @{};
                NSMutableDictionary *mutableHistoryApps = [NSMutableDictionary dictionaryWithDictionary:historyApps];
                NSData *data = [NSJSONSerialization dataWithJSONObject:[self.info toDictionary] options:0 error:nil];
                [mutableHistoryApps setValue:data forKey:self.info.app_id];
                [userDefaults setValue:mutableHistoryApps forKey:@"historyApps"];
            }
        }];
    });
}

- (void)showError {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        [[UIApplication sharedApplication].keyWindow makeToast:@"download fail！"];
    });
}

#pragma mark - <MacleSDKDelegate>
- (void)reportAuthorityOperation:(NSString *)appId user:(NSString *)userId auth:(NSString *)authId preState:(MacleAuthorityState)preState curState:(MacleAuthorityState)curState {
    NSString *preStateStr = @"DEFAULT";
    if (preState == ALLOW) {
        preStateStr = @"ALLOW";
    } else if (preState == DENY) {
        preStateStr = @"DENY";
    }
    
    NSString *curStateStr = @"DEFAULT";
    if (curState == ALLOW) {
        curStateStr = @"ALLOW";
    } else if (curState == DENY) {
        curStateStr = @"DENY";
    }
    
    NSLog(@"Authority Operation -- appId: %@, user: %@, auth: %@, preState: %@, curState: %@", appId, userId, authId, preStateStr, curStateStr);
}

- (void)onEventReport: (NSString *)appId eventName:(NSString *)eventName eventParam:(NSDictionary *)eventParam {
    [[MAEventReporManager sharedInstance] reportEvent: appId eventName:eventName eventParam:eventParam];
}

- (NSString *)getLocale {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"language"];
}

- (NSString *)getAccessToken {
    /// here is the token from appcube, please set it by calling interface to appCube server
    return @"oRonLPnmyBGY4KapAqn8_hOxDBwD21FnEA5PiSebA";
}

- (NSDictionary *)getAdditionalRequestParams {
    NSDictionary * additionalRequestParams = @{
        /// here is the third-party-id para from appcube, please set it by it support of appcube,
        @"third-party-id": @"1729e3cb20c946d6b578bc8efdef852e"
    };
    return additionalRequestParams;
}

#pragma mark - NSURLSessionDelegate delegate HTTPS
/** disposition：how to handle certificate
    NSURLSessionAuthChallengeUseCredential use certificate
    NSURLSessionAuthChallengePerformDefaultHandling  ignore certificate default method
    NSURLSessionAuthChallengeCancelAuthenticationChallenge cancle request  ignore certificate
    NSURLSessionAuthChallengeRejectProtectionSpace refuse request  ignore certificate
*/
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    // Determine whether the certificate returned by the server is trusted by the server
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;  // use certificate
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;  //  ignore certificate default method
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;  // cancle request  ignore certificate
    }
    if (completionHandler) {  // install cerficate
        completionHandler(disposition, credential);
    }
}

@end
