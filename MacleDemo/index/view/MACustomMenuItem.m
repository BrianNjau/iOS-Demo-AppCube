//
//  MACustomMenuItem.m
//  MacleDemo
//
//  Created by Macle
//

#import "MACustomMenuItem.h"
#import <UIKit/UIImage.h>
#import <UIKit/UIViewController.h>


@implementation MACustomMenuItem

- (void)macleMenuItem:(id<MacleMenuItemProtocol>)menu didClickWithAppInfo:(MacleAppInfo *)appInfo presentAction:(void (^)(UIViewController * _Nonnull))present {
    NSLog(@"MADesktopMenuItem %@",menu.macleMenuItemTitle);
    if (present) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor blueColor];
        present(vc);
    }
}

- (nonnull UIImage *)macleMenuItemIcon {
    return [UIImage imageNamed:@"desktop"];
}

- (nonnull NSString *)macleMenuItemTitle {
    return @"Custom";
}

@end
