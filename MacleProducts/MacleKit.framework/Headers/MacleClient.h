//
//  MacleClient.h
//  MacleKit
//
//  Created by Macle on 17/02/2023.
//

/*!
@header MacleClient
@abstract 使用SDK拉起小程序仅需2步，详细集成步骤请参考指导文档
 
 1. 初始化 initWithConfig，按需传入 MacleAppConfig
 
 2. 启动小程序 startApp，按需构建 MacleAppInfo 对象传入

*/

#import <Foundation/Foundation.h>
#import "MacleSdkDelegate.h"
#import <UIKit/UIApplication.h>
#import "MacleAuthorityScope.h"
#import "MacleAppConfig.h"
#import "MacleSearchAppletsModel.h"

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
 @class MacleClient
 @abstract Macle Client SDK
 */
@interface MacleClient : NSObject

/*!
 * @method
 * @abstract 设置小程序运行参数
 * @discussion 设置小程序运行参数
 * @param config 小程序运行参数，详情见MacleAppConfig定义
 * @param delegate MacleSdkDelegate 代理
 */
+ (void)init:(MacleAppConfig * _Nullable)config withDelegate:(id<MacleSdkDelegate> _Nullable)delegate DEPRECATED_MSG_ATTRIBUTE("This method has a timing problem, you can use the ‘Macle.init:withDelegate:completion’ asynchronous method to replace");

/*!
 * @method
 * @abstract 设置小程序运行参数
 * @discussion 设置小程序运行参数
 * @param config 小程序运行参数，详情见MacleAppConfig定义
 * @param delegate MacleSdkDelegate 代理
 * @param completion 初始化小程序SDK的回调
 */
+ (void)init:(MacleAppConfig * _Nullable)config withDelegate:(id<MacleSdkDelegate> _Nullable)delegate completion:(void (^ _Nonnull)(BOOL success, NSString *_Nullable msg))completion;

/*!
 * @method
 * @abstract 搜索小程序
 * @discussion 搜索小程序，回调返回搜索结果，包括分页信息
 * @param searchRequest 搜索请求对象
 * @param success 搜索成功回调
 * @param failure 搜索失败回调
 */
+ (void)searchApplets:(MacleSearchAppletsRequest * _Nonnull)searchRequest
              success:(void(^ _Nullable)(MacleSearchAppletsResponse * _Nullable))success
              failure:(void(^ _Nullable)(void))failure;

/*!
 * @method
 * @abstract 启动小程序
 * @discussion 启动小程序
 * @param completion 拉起小程序的成功回调
 */
+ (void)startApplet:(MacleAppInfo *_Nonnull)appInfo
         completion:(void (^ _Nonnull)(BOOL success, NSString *_Nullable msg))completion;

/*!
 * @method
 * @abstract 关闭指定的小程序
 * @discussion 关闭指定的小程序
 * @param appId 小程序Id
 * @param needClearData 是否需要清除storage data
 */
+ (void)stopApplet:(NSString *_Nonnull)appId needClearData:(BOOL)needClearData;

/*!
 * @method
 * @abstract 关闭所有打开的小程序
 * @discussion 关闭所有打开的小程序
 * @param needClearData 是否需要清除storage data
 */
+ (void)stopAllApplets:(BOOL)needClearData;

/*!
 * @method
 * @abstract 清除指定列表中的小程序
 * @discussion 清除指定列表中的小程序
 * @param appId 小程序Id列表
 */
+ (void)removeApplet:(NSString *_Nonnull)appId;

/*!
 * @method
 * @abstract 清除所有小程序
 * @discussion 清除所有小程序
 */
+ (void)removeAllApplets;

/*!
 * @method
 * @abstract 获取在后台的小程序列表
 * @discussion 获取在后台的小程序列表
 * @result 后台的小程序列表
 */
+ (NSArray<MacleAppSnapshot *> *_Nullable)getRunningApplets;

/*!
 * @method
 * @abstract 获取使用过的小程序列表
 * @discussion 获取使用过的小程序列表
 * @result 使用过的小程序列表
 */
+ (NSArray<NSString *> *_Nullable)getRecentApplets;

/*!
 * @method
 * @abstract 宿主app注册api，api由宿主app实现
 * @discussion 宿主app注册api，api由宿主app实现
 * @param apiName API名称
 * @param handler API对应的处理方法
 */
+ (void)registerCustomApi:(NSString *_Nonnull)apiName handler:(MacleExternApiHandler _Nonnull)handler;

/*!
 * @method
 * @abstract 宿主app注册权限
 * @discussion 宿主app注册权限
 * @param auth 权限对象
 */
+ (void)registerPermissionScope:(MacleAuthorityScope *_Nonnull)auth;

/*!
 * @method
 * @abstract 宿主app检测权限
 * @discussion 宿主app检测权限
 * @param authId 权限Id
 * @param allowHandler 权限允许回调
 * @param denyHandler 权限拒绝回调
 */
+ (void)checkPermissionAuth:(NSString *_Nonnull)authId allowHandler:(nullable void (^)(void))allowHandler denyHandler:(nullable void (^)(void))denyHandler;

/*!
 * @method
 * @abstract 获取sdk运行日志目录
 * @discussion 获取sdk运行日志目录，可以通过此目录采集sdk日志
 * @result sdk运行日志目录
 */
+ (NSString * _Nonnull)getSdkLogPath;

/*!
 * @method
 * @abstract 获取屏幕旋转类型
 * @discussion 获取屏幕旋转类型
 * @result 屏幕旋转类型
 */
+ (UIInterfaceOrientationMask)supportOrientation;

/*!
 * @method
 * @abstract 获取sdk版本号
 * @discussion 获取sdk版本号
 * @result 版本号
 */
+ (NSString *_Nullable)sdkVerion;

@end
