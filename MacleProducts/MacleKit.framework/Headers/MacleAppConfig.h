//
//  MacleAppConfig.h
//  MacleKit
//
//  Created by Macle on 17/02/2023.
//

/*!
@header MacleAppConfig
@abstract 小程序配置对象
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MacleAppConfig : NSObject

/*!
 @property enableLog
 @abstract 是否开启日志，默认YES
*/
@property (nonatomic, assign) BOOL enableLog;

/*!
 @property maxRunningAppsNum
 @abstract 设置同时打开小程序的个数，，默认5个，超过会关闭最少使用的小程序
*/
@property (nonatomic, assign) NSInteger maxRunningAppsNum;

/*!
 @property allowInvalidSSLCert
 @abstract 允许任意SSL证书，默认为NO，谨慎设置YES(一般为调测场景，服务端使用自签名证书时设置)
 */
@property (nonatomic, assign) BOOL allowInvalidSSLCert;

/*!
 @property serviceOrigin
 @abstract 管理台服务的源地址，即 协议 + IP + 端口
 */
@property (nonatomic, strong) NSString *serviceOrigin;

/*!
 @property enableLogReport
 @abstract 是否开启日志上报，默认为NO
*/
@property (nonatomic, assign) BOOL enableLogReport;

/*!
 @property frameworkUrl
 @abstract framwork地址，可以是网络地址，也可以是本地路径
 */
@property (nonatomic, strong) NSString *frameworkUrl;

/*!
 @property canBackToHome
 @abstract H5场景下页面栈中仅有一个页面且为非首页时，返回是否需要回到首页
*/
@property (nonatomic, assign) BOOL canBackToHome;

/*!
 @property showRating
 @abstract 是否展示评分入口
*/
@property (nonatomic, assign) BOOL showRating;

/*!
 @property enableAccess2AppletDetail
 @abstract 是否允许进入小程序详情页面
*/
@property (nonatomic, assign) BOOL enableAccessToAppletDetail;

/*!
 @property showRefreshing
 @abstract 是否展示小程序刷新入口
*/
@property (nonatomic, assign) BOOL showRefreshing;

/*!
 @property needCheckWhiteList
 @abstract webview是否校验白名单
*/
@property (nonatomic, assign) BOOL needCheckWhiteList;

@end

NS_ASSUME_NONNULL_END
