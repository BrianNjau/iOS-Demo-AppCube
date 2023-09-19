//
//  MacleMenuProtocol.h
//  MacleKit
//
//  Created by gl on 2021/8/16.
//

#import <Foundation/Foundation.h>
#import "MacleAppInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MacleMenuItemProtocol <NSObject>

@required

/*
 * @field macleMenuItemTitle add custom menuItem title string here
 */
- (NSString *)macleMenuItemTitle;

/*
 * @field macleMenuItemIcon add custom menuItem icon image here
 */
- (UIImage *)macleMenuItemIcon;

/*
 * Handle click custom menuItem button event
 *
 * @param menu applet menuItem
 * @param appInfo current applet appInfo
 * @param present Host app custom processing event，usually opening a new UIViewController
 */
- (void)macleMenuItem:(id<MacleMenuItemProtocol>)menu didClickWithAppInfo:(MacleAppInfo *)appInfo presentAction:(void (^)(UIViewController *vc))present;

@end

NS_ASSUME_NONNULL_END
