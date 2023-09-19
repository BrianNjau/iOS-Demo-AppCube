//
//  MacleSdk.h
//  MiniCaseOCVersion
//
//  Created by dev1 on 2021/5/18.
//

/*!
@header MacleSdk
@abstract 使用sdk拉起小程序分三步，详细集成步骤请参考指导文档
 
 1. 初始化initSdkEnvironmentWithOptions,按需传入参数;
 
 2. 检查小程序包是否已经部署(isExsitApp), 如果未部署，则需要先从服务器端下载小程序包，再调用releaseAppPackageToRunPath部署到小程序运行路径。如果是
 生产环境，则还需要比较小程序包的版本号，宿主app需要做好小程序的版本管理;
 
 3. createMacleApp获取app实例，然后startApp
@author 服务与软件技术规划与标准专利部
@version 1.0.0
*/

#import <Foundation/Foundation.h>
#import "MacleSdkDelegate.h"
#import <UIKit/UIApplication.h>
#import "MacleAuthorityScope.h"

@class MacleStyle;
@class UIViewController;
@class MacleAppSnapshot;
@class MacleAppInfo;
@protocol MacleAppProtocol;

/*!
 @param invokeStatusCode  0:成功 1：失败
 */
typedef void(^MacleApiReqCallback)(UInt8 invokeStatusCode, NSDictionary<NSString *, NSObject *> *_Nullable result);

typedef void (^MacleExternApiHandler)(id _Nullable dataParam, UIViewController *_Nullable VC, MacleApiReqCallback _Nullable callback);

/*!
 @class MacleSdk
 @abstract 小程序engine
 */
@interface MacleSdk : NSObject

/*!
 @method
 @abstract 设置小程序运行参数
 @discussion 设置小程序运行参数，参数名称如下
    enableLog: 是否开启日志，默认YES
    maxRunningAppsNum: 后台同时打开的小程序上限，默认5个
    allowInvalidSSLCert:  允许任意SSL证书，默认为NO，谨慎设置YES(一般为调测场景，服务端使用自签名证书时设置)
    serviceOrigin: 服务端地址
    enableLogReport: 是否开启日志上报，默认NO
 */
+ (void)initSdkEnvironmentWithOptions:(NSDictionary *_Nullable)options DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient. This method will be replaced by 'initWithConfig:' in MacleClient.");

/*!
 @method 
 @abstract 部署小程序包到运行路径
 @discussion 部署小程序包到运行路径
 @param appId <a href="">申请</a>的小程序appid
 @param appInstance 小程序实例id，服务器返回
 @param packageFilePath 小程序包位置
 @param isTrial 体验版 YES， 正式版 NO
 @result 空
 */
+ (BOOL)releaseAppPackageToRunPath:(NSString *_Nonnull)appId
                       appInstance:(NSString *_Nonnull)appInstance
                   packageFilePath:(NSString *_Nonnull)packageFilePath
                           isTrial:(BOOL)isTrial DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient. This method will be removed in MacleClient. You do not need to release app package.");

/*!
 @method
 @abstract 部署framework包到运行路径
 @discussion sdk已经预置初始版本framework，如果宿主app可以从云端获取到framework新版本，可以调用此接口更新
 @param filePath framework zip文件路径
 */
+ (BOOL)releaseFrameworkFileToRunPath:(NSString *_Nonnull)filePath DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient. This method will be removed in MacleClient. You can just config the URL of framework within the object of 'MacleAppConfig'");

/*!
 * 通过小程序信息实例，创建小程序实例，如果对应 appId 的小程序已经打开了，则返回已经打开的小程序实例
 * @param appInfo 小程序信息实例
 * @return MacleApp实例
 */
+ (_Nullable id <MacleAppProtocol>)createMacleApp:(MacleAppInfo *_Nonnull)appInfo DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient. This method will be removed in MacleClient. You can just startApp with the object of 'MacleAppInfo'");

/*!
 * 创建小程序实例, 创建实例后，使用对应start方法拉起小程序
 * @param appId 小程序id
 * @param appInstance 小程序实例id
 * @param version 小程序版本
 * @param name 小程序名称
 * @return app实例
 */
+ (_Nullable id <MacleAppProtocol>)createMacleApp:(NSString *_Nonnull)appId
                                      appInstance:(NSString *_Nonnull)appInstance
                                          version:(NSString *_Nonnull)version
                                             name:(NSString *_Nonnull)name DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient. This method will be removed in MacleClient. You can just startApp with the object of 'MacleAppInfo'");

/*!
 @method
 @abstract 获取sdk版本号
 @discussion 获取sdk版本号
 @result 版本号
 */
+ (NSString *_Nullable)sdkVerion DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @abstract 运行目录中是否已经存在app
 @discussion 如果appInstance为空，只检查app目录是否存在；非空则根据instanceId查看运行目录下某个具体版本是否存在
 */
+ (BOOL)isExsitApp:(NSString *_Nonnull)appId appInstance:(NSString *_Nonnull)appInstance DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @abstract 关闭指定列表中的小程序
 @discussion 关闭指定列表中的小程序
 @param appIdList 小程序Id列表
 @param needClearData 是否需要清除storage data
 */
+ (void)stopAppWithAppIdList:(NSArray<NSString *> *_Nonnull)appIdList needClearData:(BOOL)needClearData DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @abstract 关闭所有打开的小程序
 @discussion 关闭所有打开的小程序
 @param needClearData 是否需要清除storage data
 */
+ (void)stopAllApps:(BOOL)needClearData DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @abstract 获取在后台的小程序列表
 @discussion 获取在后台的小程序列表
 */
+ (NSArray<MacleAppSnapshot *> *_Nullable)getRunningApps DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @abstract 宿主app注册api，api由宿主app实现
 @discussion 宿主app注册api，api由宿主app实现
 */
+ (void)registerExternApi:(NSString *_Nonnull)apiName handler:(MacleExternApiHandler _Nonnull)handler DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @discussion 获取sdk运行日志目录，可以通过此目录采集sdk日志
 */
+ (NSString * _Nonnull)getSdkLogPath DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");


+ (UIInterfaceOrientationMask)supportOrientation DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @abstract 宿主app注册权限
 @discussion 宿主app注册权限
 */
+ (void)registerExternAuthority:(MacleAuthorityScope *_Nonnull)auth DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

/*!
 @method
 @abstract 宿主app检测权限
 @discussion 宿主app检测权限
 */
+ (void)checkAuthority:(NSString *_Nonnull)authId allowHandler:(nullable void (^)(void))allowHandler denyHandler:(nullable void (^)(void))denyHandler DEPRECATED_MSG_ATTRIBUTE("MacleSDK will not be supported. Recommend to use MacleClient.");

@end
