//
// Created by dev1 on 2021/9/7.
//

#import <Foundation/Foundation.h>

@class MacleStyle;
@protocol MacleSdkDelegate;

@protocol MacleAppProtocol <NSObject>
@required
/*!
 * 启动小程序
 * @param userId 当前登录用户id，没有可为空
 * @param style 导航栏和胶囊按钮样式，不传则使用默认样式
 * @param delegate 小程序依赖外部实现的接口
 * @param completion 拉起小程序的成功回调
 */
- (void)startApp:(NSString *_Nullable)userId
           style:(MacleStyle *_Nullable)style
        delegate:(id <MacleSdkDelegate> _Nonnull)delegate
      completion:(void (^ _Nonnull)(BOOL success, NSString *_Nullable msg))completion DEPRECATED_MSG_ATTRIBUTE("Recommend to use 'startApp:completion:'");

/*!
 * 启动小程序
 * @param userId 当前登录用户id，没有可为空
 * @param path 指定启动页
 * @param pageSetting 页面配置项
 * @param style 导航栏和胶囊按钮样式，不传则使用默认样式
 * @param delegate 小程序依赖外部实现的接口
 * @param completion 拉起小程序的成功回调
 */
- (void)startApp:(NSString *_Nullable)userId
  launchPagePath:(NSString *_Nullable)path
     pageSetting:(NSDictionary *_Nullable)pageSetting
           style:(MacleStyle *_Nullable)style
        delegate:(id <MacleSdkDelegate> _Nonnull)delegate
      completion:(void (^ _Nonnull)(BOOL success, NSString *_Nullable msg))completion DEPRECATED_MSG_ATTRIBUTE("Recommend to use 'startApp:completion:'");

/*!
 * 启动小程序
 * @param delegate 小程序依赖外部实现的接口
 * @param completion 拉起小程序的成功回调
 */
- (void)startApp:(id <MacleSdkDelegate> _Nonnull)delegate
      completion:(void (^ _Nonnull)(BOOL success, NSString *_Nullable msg))completion;

/*!
 * 销毁后台运行的小程序
 */
- (void)stopApp;
@end
