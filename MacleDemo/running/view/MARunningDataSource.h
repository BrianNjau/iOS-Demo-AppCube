//
//  MARunningDataSource.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>
#import <MacleKit/MacleAppSnapshot.h>


NS_ASSUME_NONNULL_BEGIN

/**
   Here is a class which contain the result of runing mini apps, it is the source of the tableview in MARunningVC. In this class, we create the MARunningCell object.
 */
@interface MARunningDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSArray<MacleAppSnapshot *> *apps;
@property(nonatomic, copy)void(^didKillAppBlock)(void);
@property(nonatomic, copy)void(^didRemoveAppBlock)(void);

@end

NS_ASSUME_NONNULL_END
