//
//  MacleAppInfo.h
//  Macle
//
//  Created by dev1 on 2021/5/18.
//

/*!
@header MacleAppInfo
@abstract 小程序配置相关信息
@author 服务与软件技术规划与标准专利部
@version 1.0.0
*/


#import <Foundation/Foundation.h>
#import "MacleStyle.h"


NS_ASSUME_NONNULL_BEGIN

@interface MacleAppInfo : NSObject

/*!
 @property appId
 @abstract 小程序appId
*/
@property (nonatomic, copy) NSString *appId;

/*!
 @property appName
 @abstract 小程序名称
 */
@property (nonatomic, copy) NSString *appName;

/*!
 @property appVersion
 @abstract app版本号
 */
@property (nonatomic, copy) NSString *appVersion;

/*!
 @property instanceId
 @abstract 小程序实例id
 */
@property (nonatomic, copy) NSString *instancId;

/*!
 @property appDescription
 @abstract 小程序描述
 */
@property (nonatomic, copy) NSString * _Nullable appDescription;

/*！
 @property appLogoUrl
 @abstract 小程序图标url地址，如果 appLogo 没有值需要根据 url 去下载
 */
@property (nonatomic, copy) NSString * _Nullable appLogoUrl;

/*！
 @property appLogo
 @abstract 小程序图标
 */
@property (nonatomic, strong) UIImage * _Nullable appLogo;

/*！
 @property appLogo
 @abstract 小程序加载时的默认图标
 */
@property (nonatomic, strong) UIImage * _Nullable defaultImage;

/*!
 @property style
 @abstract 设置小程序的样式
*/
@property (nonatomic, strong) MacleStyle * _Nullable style;

/*！
 @property userId
 @abstract 宿主app当前登陆的用户id
 */
@property (nonatomic, copy) NSString * _Nullable userId;

/*！
 @property launchPath
 @abstract 启动app的着陆页，可以是任意一页
 */
@property (nonatomic, copy) NSString * _Nullable launchPath;

/*！
 @property pageSetting
 @abstract 页面配置项，具体如下
    showHomeButton：app启动时页面跳转后是否显示home按钮
 */
@property (nonatomic, copy) NSDictionary * _Nullable pageSetting;

/*！
 @property appUrl
 @abstract 小程序包的下载地址
 */
@property (nonatomic, copy) NSString * _Nullable appUrl;

/*！
 @property isTrial
 @abstract 当前版本小程序是否为体验版本
 */
@property (nonatomic, assign) BOOL isTrial;

/*！
 @property trialSign
 @abstract 体验版本签名，当isTrial为YES时才会使用
 */
@property (nonatomic, copy) NSString * _Nullable trialSign;

- (instancetype)initWithAppId:(NSString *_Nonnull)appId
                      appName:(NSString *_Nonnull)appName
                   appVersion:(NSString *_Nonnull)appVersion
                   instanceId:(NSString *_Nonnull)instanceId;

- (MacleAppInfo * (^)(NSString *))setAppDescription;

- (MacleAppInfo * (^)(NSString *))setAppLogoUrl;

- (MacleAppInfo * (^)(UIImage *))setAppLogo;

- (MacleAppInfo * (^)(UIImage *))setDefaultImage;

- (MacleAppInfo * (^)(MacleStyle *))setStyle;

- (MacleAppInfo * (^)(NSString *))setUserId;

- (MacleAppInfo * (^)(NSString *))setLaunchPath;

- (MacleAppInfo * (^)(NSDictionary *))setPageSetting;

- (MacleAppInfo * (^)(NSString *))setAppUrl;

- (MacleAppInfo * (^)(BOOL))setIsTrial;

- (MacleAppInfo * (^)(NSString *))setTrialSign;

@end

NS_ASSUME_NONNULL_END
