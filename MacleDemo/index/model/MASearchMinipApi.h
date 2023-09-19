//
//  MASearchMinipApi.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKRequest.h>
#import "MAMinipInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
   Here is a model definition class, here we provide the definition of MAMinipsModel and MASearchMinipApi
 */
@interface MAMinipsModel : NSObject

@property(nonatomic, assign) NSInteger total_count;///int Required total number of records
@property(nonatomic, assign) NSInteger current_page_num;///int Required current page number
@property(nonatomic, assign) NSInteger per_page_size;///int Required records per page
@property(nonatomic, strong) NSArray<MAMinipInfoModel *> *app_infos;///int optional mini app infos

@end

@interface MASearchMinipApi : YTKRequest

@end


NS_ASSUME_NONNULL_END
