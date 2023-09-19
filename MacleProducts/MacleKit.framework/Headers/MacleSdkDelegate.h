//
//  MacleSdkDelegate.h
//  MacleKit
//
//  Created by dev1 on 2021/6/7.
//

#import <Foundation/Foundation.h>
#import "MacleAuthorityScope.h"

NS_ASSUME_NONNULL_BEGIN

/*！
 @protocal
 @discussion 宿主app需要实现方法并注入到sdk
 */
@protocol MacleSdkDelegate <NSObject>

@optional
/*!
 @method
 @discussion 小程序检查更新
 @param appId appId
 @param instanceId instanceId
 @param resultHandler 宿主app检查更新后回调，YES代表有新版本，NO代表没有新版本
 */
- (void)checkForUpdate: (NSString *)appId
           appInstance: (NSString *)instanceId
         resultHandler: (void(^)(BOOL hasUpdate, NSString *newUrl, NSString *newVersion, NSString *newInstanceId)) resultHandler;

/*!
 @method
 @discussion 小程序数据上报, 宿主app在收到上报数据后，需要自行处理数据缓存，上报服务端
 @param eventName 事件名称
    homepageFirstFinishRender  首页首次渲染完成
    homepageFirstLoaded  首页加载完成
    miniAppStart 小程序开始启动
    homepageFirstStartRender  首页首次渲染开始
    homepageFirstFinishRender  首页首次渲染完成
    pageFinishLoad  页面完成加载
    pageStartRender 页面开始渲染
    pageFinishRender 页面完成渲染
 @param eventParam 上报参数，json格式字符串
 */
- (void)onEventReport: (NSString *)appId
            eventName: (NSString *)eventName
           eventParam: (NSDictionary *)eventParam;


- (void)downloadSubPackage: (NSString *)appInstance
                      name: (NSString *)name
             resultHandler: (void(^)(BOOL succ, NSString *subPkhPath))resultHandler DEPRECATED_MSG_ATTRIBUTE("This delegate method will not be supported. The subpackage download task will be excuted within Macle SDK.");

- (void)download: (NSString *)url
   resultHandler: (void(^)(BOOL succ, NSString *localPath)) resultHandler;

- (void)reportAuthorityOperation: (NSString *)appId
                            user: (NSString *)userId
                            auth: (NSString *)authId
                        preState: (MacleAuthorityState)preState
                        curState: (MacleAuthorityState)curState;

/**
 @method
 @discussion 设置SDK需要设置的语言
 @return SDK需要使用的语言
 */
- (NSString *)getLocale;

/**
 @method
 @discussion 设置SDK内请求管理台接口需要的token
 @return SDK内请求管理台接口需要的token
 */
- (NSString *)getAccessToken;

/**
 @method
 @discussion 设置宿主app请求服务管理台时透传的参数，如thirdPartyId或者后续支持透传的参数
 @return 获取宿主app请求服务管理台时透传的参数
 */
- (NSDictionary *)getAdditionalRequestParams;
@end

NS_ASSUME_NONNULL_END
