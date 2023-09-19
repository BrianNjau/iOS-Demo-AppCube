//
//  MACustomMenuItem.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>
#import <MacleKit/MacleMenuItemProtocol.h>


NS_ASSUME_NONNULL_BEGIN

/**
   Here is an example user-contacted class, in this MADesktopMenuItem,  developer can implement their own logic method communicated to mini app, here we provide the current mini app detail to developer.In this class we just make a blue UIViewController.
 
   note: these class is injected to mini app sdk in macleClient.start api.
 */
@interface MACustomMenuItem : NSObject <MacleMenuItemProtocol>

@end

NS_ASSUME_NONNULL_END
