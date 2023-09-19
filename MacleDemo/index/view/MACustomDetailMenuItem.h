//
//  MACustomDetailMenuItem.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>
#import <MacleKit/MacleMenuItemProtocol.h>
#import <UiKit/UIViewController.h>


NS_ASSUME_NONNULL_BEGIN

@class MacleAppInfo;

/**
   Here is an example user-contacted class, in this MADesktopMenuItem,  developer can implement their own logic method communicated to mini app, here we provide the current mini app detail to developer.In this class we present the json string of current mini app.
 
   note: these class is injected to mini app sdk in macleClient.start api.
 */
@interface MACustomDetailMenuItem : NSObject <MacleMenuItemProtocol>

@end


@interface RatingViewController : UIViewController
@property(nonatomic, strong) MacleAppInfo *appInfo;
@property(nonatomic, strong) UIView * ratingView;
@property(nonatomic, strong) UILabel * label1;
@property(nonatomic, strong) UILabel * label2;
- (instancetype)initWithAppInfo:(MacleAppInfo *)appInfo;

@end

NS_ASSUME_NONNULL_END
