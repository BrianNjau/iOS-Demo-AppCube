//
//  MAIndexDataSource.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>
#import "MASearchMinipApi.h"

NS_ASSUME_NONNULL_BEGIN

/**
   Here is a class which contain the result of searching mini apps, it is the source of the tableview in MAIndexVC. In this class, we create the MacleIndexCell object.
 */
@interface MAIndexDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) MAMinipsModel * _Nullable minips;

@end

NS_ASSUME_NONNULL_END
