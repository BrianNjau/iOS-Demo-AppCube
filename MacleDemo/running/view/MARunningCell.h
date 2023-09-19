//
//  MARunningCell.h
//  MacleDemo
//
//  Created by Macle
//

#import <UIKit/UIKit.h>
#import <MacleKit/MacleAppSnapshot.h>


NS_ASSUME_NONNULL_BEGIN

/**
   Here is a user-contacted class, in this MARunningCell,  the  result of user running mini app is shown, and also here is an button , when clicking the button, the user can stop mini app or remove mini app.
 */
@interface MARunningCell : UITableViewCell

@property(nonatomic, strong)MacleAppSnapshot *appInfo;
@property(nonatomic, copy)void(^didKillAppBlock)(void);
@property(nonatomic, copy)void(^didRemoveAppBlock)(void);

@end

NS_ASSUME_NONNULL_END
