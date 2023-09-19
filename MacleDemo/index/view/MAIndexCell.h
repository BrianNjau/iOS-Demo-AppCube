//
//  MAIndexCell.h
//  MacleDemo
//
//  Created by Macle
//

#import <UIKit/UIKit.h>

@class MAMinipInfoModel;

NS_ASSUME_NONNULL_BEGIN

/**
   Here is a user-contacted class, in this MAIndexCell,  the search result of user searching mini app is shown, and also here is an button , when clicking the button, the user can start the mini app.
 */
@interface MAIndexCell : UITableViewCell

@property(nonatomic, strong) MAMinipInfoModel *info;

@end

NS_ASSUME_NONNULL_END
