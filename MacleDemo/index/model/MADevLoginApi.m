//
//  MADevLoginApi.m
//  MacleDemo
//
//  Created by Macle
//

#import "MADevLoginApi.h"
#import <Toast/Toast.h>
#import <SCLAlertView_Objective_C/SCLAlertView.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface MADevLoginApi ()

@property(nonatomic, copy)NSString *userName;
@property(nonatomic, copy)NSString *pwd;

@end

@implementation MADevLoginApi

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSInteger)cacheTimeInSeconds {
    return 0;
}

+ (void)needLoginOnViewController:(UIViewController *)viewController withScanBlock:(void (^)(void))scanBlock {
    if (!viewController) {
        return;
    }
    
    void (^showMenu)(void) = ^() {
        SCLALertViewButtonBuilder *scanButton = [SCLALertViewButtonBuilder new]
            .title(@"scanCode")
            .actionBlock(^{
                if (scanBlock) {
                    scanBlock();
                }
            });
        
        SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
            .showAnimationType(SCLAlertViewShowAnimationFadeIn)
            .hideAnimationType(SCLAlertViewHideAnimationFadeOut)
            .shouldDismissOnTapOutside(NO)
            .addButtonWithBuilder(scanButton);
        
        SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
            .style(SCLAlertViewStyleCustom)
            .image([UIImage imageNamed:@"user"])
            .color([UIColor colorWithRed:34.f/255.f green:99.f/255.f blue:192.f/255.f alpha:1])
            .title(@"Menu")
            .closeButtonTitle(@"cancle")
            .duration(0.0f);

        [showBuilder showAlertView:builder.alertView onViewController:viewController];
    };
    
    showMenu();
}

@end
