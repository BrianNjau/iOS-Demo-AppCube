//
//  MacleStyle.h
//  MacleKit
//
//  Created by gl on 2021/7/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

@class MacleCapsuleStyle;
@class MacleNaviStyle;
@protocol MacleMenuItemProtocol;


NS_ASSUME_NONNULL_BEGIN

@interface MacleStyle : NSObject

/// 是否显示胶囊按钮 默认YES展示
@property(nonatomic, assign) BOOL capsuleShow;

/// 胶囊按钮样式配置
@property(nonatomic, strong) MacleCapsuleStyle *capsuleStyle;

/// 导航栏样式配置
@property(nonatomic, strong) MacleNaviStyle *naviStyle;

/// 小程序自定义菜单
@property(nonatomic, strong) NSArray<id<MacleMenuItemProtocol>> *menus;

/// 小程序胶囊样式定制表
@property(nonatomic, strong) NSDictionary<NSString *, MacleCapsuleStyle *> *capsuleStyleMap;

@end


@interface MacleCapsuleStyle  : NSObject

/// 自定义胶囊按钮菜单图标
@property(nonatomic, strong) UIImage *capsuleMenuIconImage;

/// 自定义胶囊按钮关闭图标
@property(nonatomic, strong) UIImage *capsuleCloseIconImage;

/// 自定义胶囊按钮图标颜色 图标的着色 默认白色
@property(nonatomic, strong) UIColor *capsuleTintColor;

/// 自定义胶囊按钮边框颜色 默认 #dcdcdc
@property(nonatomic, strong) UIColor *capsuleBorderColor;

/// 自定义胶囊按钮边背景色 默认 #fcfcfc
@property(nonatomic, strong) UIColor *capsuleBackgroundColor;

@end


@interface MacleNaviStyle  : NSObject

/// 自定义导航栏返回按钮图标
@property(nonatomic, strong) UIImage *naviBackImage;

@end

NS_ASSUME_NONNULL_END
