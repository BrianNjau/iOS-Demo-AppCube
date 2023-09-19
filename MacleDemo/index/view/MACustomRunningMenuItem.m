//
//  MACustomRunningMenuItem.m
//  MacleDemo
//
//  Created by Macle
//

#import "MACustomRunningMenuItem.h"
#import <UIKit/UIImage.h>
#import <UIKit/UIViewController.h>
#import "MARunningVC.h"

@implementation MACustomRunningMenuItem

- (void)macleMenuItem:(id<MacleMenuItemProtocol>)menu didClickWithAppInfo:(MacleAppInfo *)appInfo presentAction:(void (^)(UIViewController * _Nonnull))present {
    NSLog(@"MADesktopMenuItem %@",menu.macleMenuItemTitle);
    if (present) {
        MARunningVC *runningVC = [MARunningVC new];
        present(runningVC);
    }
}

- (nonnull UIImage *)macleMenuItemIcon {
    return [UIImage imageNamed:@"desktop"];
}

- (nonnull NSString *)macleMenuItemTitle {
    return @"Setting";
}
@end
